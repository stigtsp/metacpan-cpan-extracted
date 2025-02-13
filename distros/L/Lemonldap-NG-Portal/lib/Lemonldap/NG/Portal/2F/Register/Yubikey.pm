# Self Yubikey registration
package Lemonldap::NG::Portal::2F::Register::Yubikey;

use strict;
use Mouse;
use JSON qw(from_json to_json);
use Lemonldap::NG::Portal::Main::Constants qw(
  PE_FORMEMPTY
  PE_ERROR
);

our $VERSION = '2.0.10';

extends 'Lemonldap::NG::Portal::Main::Plugin';

# INITIALIZATION

has prefix   => ( is => 'rw', default => 'yubikey' );
has template => ( is => 'ro', default => 'yubikey2fregister' );
has welcome  => ( is => 'ro', default => 'clickOnYubikey' );
has logo     => ( is => 'rw', default => 'yubikey.png' );

sub init {
    my ($self) = @_;
    return 1;
}

# RUNNING METHODS

# Main method
sub run {
    my ( $self, $req, $action ) = @_;
    my $user = $req->userData->{ $self->conf->{whatToTrace} };
    return $self->p->sendError( $req,
        'No ' . $self->conf->{whatToTrace} . ' found in user data', 500 )
      unless $user;

    # Check if UBK key can be updated
    my $msg = $self->canUpdateSfa( $req, $action );
    return $self->p->sendHtml(
        $req, 'error',
        params => {
            MAIN_LOGO       => $self->conf->{portalMainLogo},
            RAW_ERROR       => 'notAuthorizedAuthLevel',
            AUTH_ERROR_TYPE => 'warning',
        }
    ) if $msg;

    if ( $action eq 'register' ) {
        my $otp     = $req->param('otp');
        my $UBKName = $req->param('UBKName');
        my $epoch   = time();

     # Set default name if empty, check characters and truncate name if too long
        $UBKName ||= $epoch;
        unless ( $UBKName =~ /^[\w]+$/ ) {
            $self->userLogger->error('Yubikey name with bad character(s)');
            return $self->p->sendError( $req, 'badName', 200 );
        }
        $UBKName = substr( $UBKName, 0, $self->conf->{max2FDevicesNameLength} );
        $self->logger->debug("Yubikey name: $UBKName");

        if ( $otp
            and length($otp) > $self->conf->{yubikey2fPublicIDSize} )
        {
            my $key = substr( $otp, 0, $self->conf->{yubikey2fPublicIDSize} );

            # Read existing 2FDevices
            $self->logger->debug("Looking for 2F Devices...");
            my $_2fDevices;
            if ( $req->userData->{_2fDevices} ) {
                $_2fDevices = eval {
                    from_json( $req->userData->{_2fDevices},
                        { allow_nonref => 1 } );
                };
                if ($@) {
                    $self->logger->error("Corrupted session (_2fDevices): $@");
                    return $self->p->sendError( $req, "Corrupted session",
                        500 );
                }
            }

            else {
                $self->logger->debug("No 2F Device found");
                $_2fDevices = [];
            }

            # Search if the Yubikey is already registered
            my $SameUBKFound = 0;
            foreach (@$_2fDevices) {
                $self->logger->debug("Reading Yubikeys...");
                if ( $_->{_yubikey} eq $key ) {
                    $SameUBKFound = 1;
                    last;
                }
            }

            if ($SameUBKFound) {
                $self->userLogger->error("Yubikey already registered!");
                return $self->p->sendHtml(
                    $req, 'error',
                    params => {
                        MAIN_LOGO       => $self->conf->{portalMainLogo},
                        RAW_ERROR       => 'yourKeyIsAlreadyRegistered',
                        AUTH_ERROR_TYPE => 'warning',
                    }
                );
            }

            # Check if user can register one more device
            my $size    = @$_2fDevices;
            my $maxSize = $self->conf->{max2FDevices};
            $self->logger->debug("Registered 2F Device(s): $size / $maxSize");
            if ( $size >= $maxSize ) {
                $self->userLogger->warn("Max number of 2F devices is reached");
                return $self->p->sendHtml(
                    $req, 'error',
                    params => {
                        MAIN_LOGO       => $self->conf->{portalMainLogo},
                        RAW_ERROR       => 'maxNumberof2FDevicesReached',
                        AUTH_ERROR_TYPE => 'warning',
                    }
                );
            }

            push @{$_2fDevices},
              {
                type     => 'UBK',
                name     => $UBKName,
                _yubikey => $key,
                epoch    => $epoch
              };
            $self->logger->debug(
                "Append 2F Device: { type => 'UBK', name => $UBKName }");
            $self->p->updatePersistentSession( $req,
                { _2fDevices => to_json($_2fDevices) } );
            $self->userLogger->notice(
                "Yubikey registration of $UBKName succeeds for $user");

            return $self->p->sendHtml(
                $req, 'error',
                params => {
                    MAIN_LOGO       => $self->conf->{portalMainLogo},
                    RAW_ERROR       => 'yourKeyIsRegistered',
                    AUTH_ERROR_TYPE => 'positive',
                }
            );
        }
        else {
            $self->userLogger->error('Yubikey 2F: no code or name');
            return $self->p->sendHtml(
                $req, 'error',
                params => {
                    MAIN_LOGO       => $self->conf->{portalMainLogo},
                    AUTH_ERROR      => PE_FORMEMPTY,
                    AUTH_ERROR_TYPE => 'positive',
                }
            );
        }
    }

    elsif ( $action eq 'delete' ) {

        # Check if unregistration is allowed
        return $self->p->sendError( $req, 'notAuthorized', 400 )
          unless $self->conf->{yubikey2fUserCanRemoveKey};

        my $epoch = $req->param('epoch')
          or return $self->p->sendError( $req, '"epoch" parameter is missing',
            400 );

        # Read existing 2FDevices
        $self->logger->debug("Looking for 2F Devices...");
        my ( $_2fDevices, $UBKName );
        if ( $req->userData->{_2fDevices} ) {
            $_2fDevices = eval {
                from_json( $req->userData->{_2fDevices},
                    { allow_nonref => 1 } );
            };
            if ($@) {
                $self->logger->error("Corrupted session (_2fDevices): $@");
                return $self->p->sendError( $req, "Corrupted session", 500 );
            }
        }
        else {
            $self->logger->debug("No 2F Device found");
            $_2fDevices = [];
        }

        # Delete Yubikey device
        @$_2fDevices = map {
            if ( $_->{epoch} eq $epoch ) { $UBKName = $_->{name}; () }
            else                         { $_ }
        } @$_2fDevices;
        if ($UBKName) {
            $self->logger->debug(
"Delete 2F Device: { type => 'UBK', epoch => $epoch, name => $UBKName }"
            );
            $self->p->updatePersistentSession( $req,
                { _2fDevices => to_json($_2fDevices) } );
            $self->userLogger->notice(
                "Yubikey $UBKName unregistration succeeds for $user");
            return [
                200,
                [
                    'Content-Type'   => 'application/json',
                    'Content-Length' => 12,
                ],
                ['{"result":1}']
            ];
        }
        else {
            $self->p->sendError( $req, '2FDeviceNotFound', 400 );
        }
    }
    else {
        $self->logger->error("Unknown Yubikey action -> $action");
        return $self->p->sendError( $req, 'unknownAction', 400 );
    }
}

1;
