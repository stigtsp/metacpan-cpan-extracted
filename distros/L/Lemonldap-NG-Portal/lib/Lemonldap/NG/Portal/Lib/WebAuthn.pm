package Lemonldap::NG::Portal::Lib::WebAuthn;

use strict;
use Mouse::Role;
use MIME::Base64 qw(encode_base64url decode_base64url);
use JSON qw(decode_json from_json to_json);
use Digest::SHA qw(sha256);
use URI;
use Carp;

our $VERSION = '2.0.12';

has rp_id    => ( is => 'rw', lazy    => 1, builder => "_build_rp_id" );
has origin   => ( is => 'rw', lazy    => 1, builder => "_build_origin" );
has type     => ( is => 'ro', default => 'WebAuthn' );
has verifier => ( is => 'rw', lazy    => 1, builder => "_build_verifier" );

sub _build_verifier {
    my $self = shift;
    return Authen::WebAuthn->new(
        rp_id  => $self->rp_id,
        origin => $self->origin,
    );
}

sub _build_rp_id {
    my ($self) = @_;

    # TODO make this configurable
    my $portal_uri = URI->new( $self->{conf}->{portal} );
    return $portal_uri->authority;
}

sub _build_origin {
    my ($self) = @_;
    my $portal_uri = URI->new( $self->{conf}->{portal} );
    return ( $portal_uri->scheme . "://" . $portal_uri->authority );
}

around 'init' => sub {
    my $orig = shift;
    my $self = shift;

    eval { require Authen::WebAuthn };
    if ($@) {
        $self->logger->error("Can't load WebAuthn library: $@");
        $self->error("Can't load WebAuthn library: $@");
        return 0;
    }

    return $orig->( $self, @_ );
};

sub getUserHandle {
    my ( $self, $req, $data ) = @_;
    return $data->{_webAuthnUserHandle};
}

sub setUserHandle {
    my ( $self, $req, $user_handle ) = @_;
    $self->p->updatePersistentSession( $req,
        { _webAuthnUserHandle => $user_handle } );
    return;
}

sub generateChallenge {
    my ( $self, $req, $data ) = @_;

    # Find webauthn devices for user
    my @webauthn_devices = $self->find2fByType( $req, $data, $self->type );
    unless (@webauthn_devices) {
        return;
    }

    my $challenge_base64 = encode_base64url( Crypt::URandom::urandom(32) );
    my $userVerification = $self->conf->{webauthn2fUserVerification};

    return {
        challenge        => $challenge_base64,
        allowCredentials => [
            map { { type => "public-key", id => $_->{_credentialId}, } }
              @webauthn_devices
        ],
        ( $userVerification ? ( userVerification => $userVerification ) : () ),
        extensions => {
            appid => $self->origin,
        },
    };
}

sub validateCredential {
    my ( $self, $req, $registration_options, $credential_json ) = @_;

    my $credential = from_json($credential_json);

    my $client_data_json_b64   = $credential->{response}->{clientDataJSON};
    my $attestation_object_b64 = $credential->{response}->{attestationObject};

    my $requested_uv =
      $registration_options->{authenticatorSelection}->{userVerification} || "";
    my $challenge_b64 = $registration_options->{challenge};

    my $token_binding_id_b64 = encode_base64url(
        $req->headers->header('Sec-Provided-Token-Binding-ID') );

    return $self->verifier->validate_registration(
        challenge_b64          => $challenge_b64,
        requested_uv           => $requested_uv,
        client_data_json_b64   => $client_data_json_b64,
        attestation_object_b64 => $attestation_object_b64,
        token_binding_id_b64   => $token_binding_id_b64
    );
}

sub validateAssertion {
    my ( $self, $req, $data, $signature_options, $credential_json ) = @_;

    my $user = $data->{ $self->conf->{whatToTrace} };
    $self->logger->debug("Get asserted credential $credential_json");
    my $credential = from_json($credential_json);

    my $credential_id = $credential->{id};
    croak("Empty credential id in credential response") unless $credential_id;

    # 5. If options.allowCredentials is not empty, verify that credential.id
    # identifies one of the public key credentials listed in
    # options.allowCredentials.
    my @allowed_credential_ids =
      map { $_->{id} } @{ $signature_options->{allowCredentials} };
    if ( @allowed_credential_ids
        and not grep { $_ eq $credential_id } @allowed_credential_ids )
    {
        croak("Received credential ID $credential_id was not requested");
    }

    # 6. Identify the user being authenticated and verify that this user is the
    # owner of the public key credential source credentialSource identified by
    # credential.id If the user was identified before the authentication
    # ceremony was initiated, e.g., via a username or cookie, verify that the
    # identified user is the owner of credentialSource.
    my @webauthn_devices = $self->find2fByType( $req, $data, $self->type );
    my @matching_credentials =
      grep { $_->{_credentialId} eq $credential_id } @webauthn_devices;
    if ( @matching_credentials < 1 ) {
        croak("Received credential ID $credential_id does not belong to user");
    }
    if ( @matching_credentials > 1 ) {
        croak("Found multiple credentials with ID $credential_id for user");
    }
    my $matching_credential = $matching_credentials[0];

    # If response.userHandle is present, let userHandle be its value.
    # Verify that userHandle also maps to the same user.
    if ( $credential->{response}->{userHandle} ) {
        my $user_handle         = $credential->{response}->{userHandle};
        my $current_user_handle = $self->getUserHandle( $req, $data );
        unless ( $user_handle eq $current_user_handle ) {
            croak(
"Received user handle ($user_handle) does not match current user ($current_user_handle)"
            );
        }
    }

    # TODO If the user was not identified before the authentication ceremony
    # was initiated, verify that response.userHandle is present, and that the
    # user identified by this value is the owner of credentialSource.
    # NOTE: irrelevant for now, take this into account when implementing
    # Auth::WebAuthn

    my $client_data_json_b64   = $credential->{response}->{clientDataJSON};
    my $authenticator_data_b64 = $credential->{response}->{authenticatorData};
    my $signature_b64          = $credential->{response}->{signature};
    my $extension_results      = $credential->{clientExtensionResults};
    my $requested_uv           = $signature_options->{userVerification} || "";

    my $token_binding_id_b64 = encode_base64url(
        $req->headers->header('Sec-Provided-Token-Binding-ID') );

    my $validation_result = $self->verifier->validate_assertion(
        challenge_b64          => $signature_options->{challenge},
        credential_pubkey_b64  => $matching_credential->{_credentialPublicKey},
        stored_sign_count      => $matching_credential->{_signCount},
        requested_uv           => $requested_uv,
        client_data_json_b64   => $client_data_json_b64,
        authenticator_data_b64 => $authenticator_data_b64,
        signature_b64          => $signature_b64,
        extension_results      => $extension_results,
        token_binding_id_b64   => $token_binding_id_b64,
    );

    if ( $validation_result->{success} == 1 ) {
        my $new_signature_count = $validation_result->{signature_count};
        $self->userLogger->info(
                "Successfully verified signature with count "
              . "$new_signature_count for $user" );

        # Update storedSignCount to be the value of authData.signCount
        $self->update2fDevice( $req, $data, $self->type,
            "_credentialId", $credential_id, "_signCount",
            $new_signature_count );
    }

    return $validation_result;
}

sub decode_credential {
    my ( $self, $json ) = @_;
    my $credential = decode_json($json);

    # Decode ClientDataJSON
    if ( $credential->{response}->{clientDataJSON} ) {
        $credential->{response}->{clientDataJSON} = decode_json(
            decode_base64url( $credential->{response}->{clientDataJSON} ) );
    }

    # Decode attestation object
    if ( $credential->{response}->{attestationObject} ) {
        $credential->{response}->{attestationObject} =
          getAttestationObject( $credential->{response}->{attestationObject} );
    }

    # Decode authenticator data
    if ( $credential->{response}->{authenticatorData} ) {
        $credential->{response}->{authenticatorData} =
          getAuthData(
            decode_base64url( $credential->{response}->{authenticatorData} ) );
    }

    # Decode rawID
    if ( $credential->{rawId} ) {
        $credential->{rawId} = decode_base64url( $credential->{rawId} );
    }

    return $credential;
}

sub update2fDevice {
    my ( $self, $req, $info, $type, $key, $value, $update_key, $update_value )
      = @_;

    my $user = $info->{ $self->conf->{whatToTrace} };

    my $_2fDevices = $self->get2fDevices( $req, $info );
    return 0 unless $_2fDevices;

    my @found =
      grep { $_->{type} eq $type and $_->{$key} eq $value } @{$_2fDevices};

    for my $device (@found) {
        $device->{$update_key} = $update_value;
    }

    if (@found) {
        $self->p->updatePersistentSession( $req,
            { _2fDevices => to_json($_2fDevices) }, $user );
        return 1;
    }
    return 0;
}

sub add2fDevice {
    my ( $self, $req, $info, $device ) = @_;

    my $_2fDevices = $self->get2fDevices( $req, $info );

    push @{$_2fDevices}, $device;
    $self->logger->debug(
        "Append 2F Device: { type => 'Webauthn', name => $device->{name} }");
    $self->p->updatePersistentSession( $req,
        { _2fDevices => to_json($_2fDevices) } );
    return 1;
}

sub del2fDevice {
    my ( $self, $req, $info, $type, $epoch ) = @_;

    my $_2fDevices = $self->get2fDevices( $req, $info );
    return 0 unless $_2fDevices;

    my @updated_2fDevices =
      grep { not( $_->{type} eq $type and $_->{epoch} eq $epoch ) }
      @{$_2fDevices};
    $self->logger->debug(
        "Deleted 2F Device: { type => $type, epoch => $epoch }");
    $self->p->updatePersistentSession( $req,
        { _2fDevices => to_json( [@updated_2fDevices] ) } );
    return 1;
}

sub find2fByKey {
    my ( $self, $req, $info, $type, $key, $value ) = @_;

    my $_2fDevices = $self->get2fDevices( $req, $info );
    return unless $_2fDevices;

    my @found =
      grep { $_->{type} eq $type and $_->{$key} eq $value } @{$_2fDevices};
    return @found;
}

## @method get2fDevices($req, $info)
# Validate logout request
# @param req Request object
# @param info HashRef of session data
# @return undef or ArrayRef of second factors

sub get2fDevices {
    my ( $self, $req, $info ) = @_;

    my $_2fDevices;
    if ( $info->{_2fDevices} ) {
        $_2fDevices =
          eval { from_json( $info->{_2fDevices}, { allow_nonref => 1 } ); };
        if ($@) {
            $self->logger->error("Corrupted session (_2fDevices): $@");
            return;
        }
    }
    else {
        # Return new ArrayRef
        return [];
    }
    if ( ref($_2fDevices) eq "ARRAY" ) {
        return $_2fDevices;
    }
    else {
        return;
    }
}

sub find2fByType {
    my ( $self, $req, $info, $type ) = @_;

    my $_2fDevices = $self->get2fDevices( $req, $info );
    return unless $_2fDevices;

    return @{$_2fDevices} unless $type;
    my @found = grep { $_->{type} eq $type } @{$_2fDevices};
    return @found;
}

1;
