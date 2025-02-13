package Lemonldap::NG::Portal::2F::Mail2F;

use strict;
use Mouse;
use Lemonldap::NG::Portal::Main::Constants qw(
  PE_OK
  PE_ERROR
  PE_BADOTP
  PE_FORMEMPTY
  PE_SENDRESPONSE
  PE_MUSTHAVEMAIL
);

our $VERSION = '2.0.12';

extends qw(
  Lemonldap::NG::Portal::Main::SecondFactor
  Lemonldap::NG::Portal::Lib::SMTP
);

# INITIALIZATION

has prefix => ( is => 'rw', default => 'mail' );
has random => (
    is      => 'rw',
    default => sub {
        return Lemonldap::NG::Common::Crypto::srandom();
    }
);

has ott => (
    is      => 'rw',
    lazy    => 1,
    default => sub {
        my $ott =
          $_[0]->{p}->loadModule('Lemonldap::NG::Portal::Lib::OneTimeToken');
        $ott->timeout( $_[0]->{conf}->{mail2fTimeout}
              || $_[0]->{conf}->{formTimeout} );
        return $ott;
    }
);

has sessionKey => (
    is      => 'rw',
    lazy    => 1,
    default => sub {
        return $_[0]->{conf}->{mail2fSessionKey}
          || $_[0]->{conf}->{mailSessionKey};
    }
);

sub init {
    my ($self) = @_;
    $self->{conf}->{mail2fCodeRegex} ||= '\d{6}';
    unless ( $self->sessionKey ) {
        $self->error("Missing session key parameter, aborting");
        return 0;
    }
    $self->prefix( $self->conf->{sfPrefix} )
      if ( $self->conf->{sfPrefix} );
    return $self->SUPER::init();
}

sub run {
    my ( $self, $req, $token ) = @_;

    my $checkLogins = $req->param('checkLogins');
    $self->logger->debug("Mail2F: checkLogins set") if $checkLogins;

    my $stayconnected = $req->param('stayconnected');
    $self->logger->debug("Mail2F: stayconnected set") if $stayconnected;

    my $code = $self->random->randregex( $self->conf->{mail2fCodeRegex} );
    $self->logger->debug("Generated two-factor code: $code");
    $self->ott->updateToken( $token, __mail2fcode => $code );

    my $dest = $req->{sessionInfo}->{ $self->sessionKey };
    unless ($dest) {
        $self->logger->error( "Could not find mail attribute for login "
              . $req->{sessionInfo}->{_user} );
        return PE_MUSTHAVEMAIL;
    }

    # Build mail content
    my $tr      = $self->translate($req);
    my $subject = $self->conf->{mail2fSubject};

    unless ($subject) {
        $subject = 'mail2fSubject';
        $tr->( \$subject );
    }
    my ( $body, $html );
    if ( $self->conf->{mail2fBody} ) {

        # We use a specific text message, no html
        $body = $self->conf->{mail2fBody};

        # Replace variables in body
        $body =~ s/\$code/$code/g;
        $body =~ s/\$(\w+)/$req->{sessionInfo}->{$1} || ''/ge;

    }
    else {

        # Use HTML template
        $body = $self->loadMailTemplate(
            $req,
            'mail_2fcode',
            filter => $tr,
            params => {
                code => $code,
            },
        );
        $html = 1;
    }

    # Send mail
    unless ( $self->send_mail( $dest, $subject, $body, $html ) ) {
        $self->logger->error( 'Unable to send 2F code mail to ' . $dest );
        return PE_ERROR;
    }

    # Prepare form
    my $tmp = $self->p->sendHtml(
        $req,
        'ext2fcheck',
        params => {
            MAIN_LOGO => $self->conf->{portalMainLogo},
            SKIN      => $self->p->getSkin($req),
            TOKEN     => $token,
            PREFIX    => $self->prefix,
            TARGET    => '/'
              . $self->prefix
              . '2fcheck?skin='
              . $self->p->getSkin($req),
            LEGEND        => 'enterMail2fCode',
            CHECKLOGINS   => $checkLogins,
            STAYCONNECTED => $stayconnected
        }
    );
    $req->response($tmp);
    return PE_SENDRESPONSE;
}

sub verify {
    my ( $self, $req, $session ) = @_;
    my $usercode;
    unless ( $usercode = $req->param('code') ) {
        $self->logger->error('Mail2F: no code');
        return PE_FORMEMPTY;
    }
    my $savedcode = $session->{__mail2fcode};

    unless ($savedcode) {
        $self->logger->error(
            'Unable to find generated 2F code in token session');
        return PE_ERROR;
    }

    $self->logger->debug(
        "Verifying Mail 2F code: $usercode against $savedcode");

    return PE_OK if ( $usercode eq $savedcode );

    $self->userLogger->warn( 'Second factor failed for '
          . $session->{ $self->conf->{whatToTrace} } );
    return PE_BADOTP;
}

1;
