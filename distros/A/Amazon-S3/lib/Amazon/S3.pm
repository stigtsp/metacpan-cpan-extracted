package Amazon::S3;

use strict;
use warnings;

use Amazon::S3::Bucket;
use Amazon::S3::Constants qw{:all};
use Amazon::S3::Logger;
use Amazon::S3::Signature::V4;

use Carp;
use Data::Dumper;
use Digest::HMAC_SHA1;
use Digest::MD5 qw{md5_hex};
use English qw{-no_match_vars};
use HTTP::Date;
use LWP::UserAgent::Determined;
use MIME::Base64 qw{encode_base64 decode_base64};
use Scalar::Util qw{ reftype blessed };
use List::Util qw{ any };
use URI::Escape qw{uri_escape_utf8};
use XML::Simple qw{XMLin};

use parent qw{Class::Accessor::Fast};

__PACKAGE__->mk_accessors(
  qw{
    aws_access_key_id
    aws_secret_access_key
    token
    buffer_size
    cache_signer
    credentials
    dns_bucket_names
    digest
    err
    errstr
    error
    host
    last_request
    last_response
    logger
    log_level
    retry
    _region
    secure
    _signer
    timeout
    ua
  }
);

our $VERSION = '0.55'; ## no critic (ValuesAndExpressions::RequireInterpolationOfMetachars)

########################################################################
sub new {
########################################################################
  my ( $class, @args ) = @_;

  my %options = ref $args[0] ? %{ $args[0] } : @args;

  $options{timeout}          //= $DEFAULT_TIMEOUT;
  $options{secure}           //= $TRUE;
  $options{host}             //= $DEFAULT_HOST;
  $options{dns_bucket_names} //= $TRUE;
  $options{cache_signer}     //= $FALSE;
  $options{retry}            //= $FALSE;

  $options{_region} = delete $options{region};
  $options{_signer} = delete $options{signer};

  # convenience for level => 'debug' & for consistency with Amazon::Credentials
  if ( delete $options{debug} ) {
    $options{level} = 'debug';
  }

  # save this for later
  my $level = $options{level};
  $options{log_level} = delete $options{level};

  my $self = $class->SUPER::new( \%options );

  # setup logger
  if ( blessed( $self->logger ) ) {

    # get level from your logger, if you didn't pass one
    if ( $self->get_logger->can('level') ) {
      if ( !$level ) {
        $level = $self->get_logger->level();
      } ## end if ( !$level )
    } ## end if ( $self->get_logger...)
  } ## end if ( blessed( $self->logger...))
  else {

    $self->logger( bless { log_level => $level // $DEFAULT_LOG_LEVEL },
      'Amazon::S3::Logger' );
  } ## end else [ if ( blessed( $self->logger...))]

  $self->get_logger->debug(
    sub {
      my %safe_options = %options;

      if ( $safe_options{aws_secret_access_key} ) {
        $safe_options{aws_secret_access_key} = '****';
        $safe_options{aws_access_key_id}     = '****';
      } ## end if ( $safe_options{aws_secret_access_key...})

      return Dumper( [ 'options: ', \%safe_options ] );
    }
  );

  if ( !$self->credentials ) {

    croak 'No aws_access_key_id'
      if !$self->aws_access_key_id;

    croak 'No aws_secret_access_key'
      if !$self->aws_secret_access_key;

    # encrypt credentials
    $self->aws_access_key_id( _encrypt( $self->aws_access_key_id ) );
    $self->aws_secret_access_key( _encrypt( $self->aws_secret_access_key ) );
    $self->token( _encrypt( $self->token ) );
  } ## end if ( !$self->credentials)

  my $ua;

  if ( $self->retry ) {
    $ua = LWP::UserAgent::Determined->new(
      keep_alive            => $KEEP_ALIVE_CACHESIZE,
      requests_redirectable => [qw(GET HEAD DELETE)],
    );

    $ua->timing( join $COMMA, map { 2**$_ } 0 .. 5 );
  } ## end if ( $self->retry )
  else {
    $ua = LWP::UserAgent->new(
      keep_alive            => $KEEP_ALIVE_CACHESIZE,
      requests_redirectable => [qw(GET HEAD DELETE)],
    );
  } ## end else [ if ( $self->retry ) ]

  $ua->timeout( $self->timeout );
  $ua->env_proxy;
  $self->ua($ua);

  $self->region( $self->_region // 'us-east-1' );

  if ( !$self->_signer && $self->cache_signer ) {
    $self->_signer( $self->signer );
  }

  $self->turn_on_special_retry();

  return $self;
} ## end sub new

########################################################################
{
  my $encryption_key;

########################################################################
  sub _encrypt {
########################################################################
    my ($text) = @_;

    return $text if !$text;

    if ( !defined $encryption_key ) {
      eval {
        require Crypt::Blowfish;
        require Crypt::CBC;
      };

      if ($EVAL_ERROR) {
        $encryption_key = $EMPTY;
      }
      else {
        $encryption_key = md5_hex( rand $PID );
      }
    }

    return $text
      if !$encryption_key;

    my $cipher = Crypt::CBC->new(
      -pass        => $encryption_key,
      -cipher      => 'Crypt::Blowfish',
      -nodeprecate => $TRUE,
    );

    return $cipher->encrypt($text);
  }

########################################################################
  sub _decrypt {
########################################################################
    my ($secret) = @_;

    return $secret
      if !$secret || !$encryption_key;

    my $cipher = Crypt::CBC->new(
      -pass   => $encryption_key,
      -cipher => 'Crypt::Blowfish'
    );

    return $cipher->decrypt($secret);
  }

}

########################################################################
sub get_bucket_location {
########################################################################
  my ( $self, $bucket ) = @_;

  my $region;

  if ( !ref $bucket || ref $bucket !~ /Amazon::S3::Bucket/xsm ) {
    $bucket = Amazon::S3::Bucket->new( bucket => $bucket, account => $self );
  }

  return $bucket->get_location_constraint // 'us-east-1';
}

########################################################################
sub get_default_region {
########################################################################
  my ($self) = @_;

  my $region = $ENV{AWS_REGION} || $ENV{AWS_DEFAULT_REGION};
  return $region
    if $region;

  my $url
    = 'http://169.254.169.254/latest/meta-data/placement/availability-zone';

  my $request = HTTP::Request->new( 'GET', $url );

  my $ua = LWP::UserAgent->new;
  $ua->timeout(0);

  my $response = eval { return $ua->request($request); };

  if ( $response && $response->is_success ) {
    if ( $response->content =~ /\A([[:lower:]]+[-][[:lower:]]+[-]\d+)/xsm ) {
      $region = $1;
    }
  }

  return $region || 'us-east-1';
}

# Amazon::Credentials compatibility methods
########################################################################
sub get_aws_access_key_id {
########################################################################
  my ($self) = @_;

  return _decrypt( $self->aws_access_key_id );
}

########################################################################
sub get_aws_secret_access_key {
########################################################################
  my ($self) = @_;

  return _decrypt( $self->aws_secret_access_key );
}

########################################################################
sub get_token {
########################################################################
  my ($self) = @_;

  return _decrypt( $self->token );
}

########################################################################
sub turn_on_special_retry {
########################################################################
  my ($self) = @_;

  if ( $self->retry ) {

    # In the field we are seeing issue of Amazon returning with a 400
    # code in the case of timeout.  From AWS S3 logs: REST.PUT.PART
    # Backups/2017-05-04/<account>.tar.gz "PUT
    # /Backups<path>?partNumber=27&uploadId=<id> - HTTP/1.1" 400
    # RequestTimeout 360 20971520 20478 - "-" "libwww-perl/6.15"
    my $http_codes_hr = $self->ua->codes_to_determinate();
    $http_codes_hr->{400} = 1;
  }

  return;
}

########################################################################
sub turn_off_special_retry {
########################################################################
  my ($self) = @_;

  if ( $self->retry ) {

    # In the field we are seeing issue with Amazon returning a 400
    # code in the case of timeout.  From AWS S3 logs: REST.PUT.PART
    # Backups/2017-05-04/<account>.tar.gz "PUT
    # /Backups<path>?partNumber=27&uploadId=<id> - HTTP/1.1" 400
    # RequestTimeout 360 20971520 20478 - "-" "libwww-perl/6.15"
    my $http_codes_hr = $self->ua->codes_to_determinate();
    delete $http_codes_hr->{400};
  }

  return;
}

########################################################################
sub region {
########################################################################
  my ( $self, @args ) = @_;

  if (@args) {
    $self->_region( $args[0] );
  } ## end if (@args)

  $self->get_logger->debug(
    sub { return 'region: ' . ( $self->_region // $EMPTY ) } );

  if ( $self->_region ) {
    my $host = $self->host;
    $self->get_logger->debug( sub { return 'host: ' . $self->host } );

    if ( $host =~ /\As3[.](.*)?amazonaws/xsm ) {
      $self->host( sprintf 's3.%s.amazonaws.com', $self->_region );
    } ## end if ( $host =~ /\As3[.](.*)?amazonaws/xsm)
  } ## end if ( $self->_region )

  return $self->_region;
} ## end sub region

########################################################################
sub buckets {
########################################################################
  my ( $self, $verify_region ) = @_;

  # The "default" region for Amazon is us-east-1
  # This is the region to set it to for listing buckets
  # You may need to reset the signer's endpoint to 'us-east-1'

  # temporarily cache signer
  my $region = $self->_region;

  $self->reset_signer_region('us-east-1'); # default region for buckets op

  my $r = $self->_send_request(
    { method  => 'GET',
      path    => $EMPTY,
      headers => {},
      region  => 'us-east-1',
    }
  );

  return if $self->_remember_errors($r);

  my $owner_id          = $r->{Owner}{ID};
  my $owner_displayname = $r->{Owner}{DisplayName};

  my @buckets;

  if ( ref $r->{Buckets} ) {
    my $buckets = $r->{Buckets}{Bucket};

    if ( !ref $buckets || reftype($buckets) ne 'ARRAY' ) {
      $buckets = [$buckets];
    } ## end if ( !ref $buckets || ...)

    foreach my $node ( @{$buckets} ) {
      push @buckets,
        Amazon::S3::Bucket->new(
        { bucket        => $node->{Name},
          creation_date => $node->{CreationDate},
          account       => $self,
          buffer_size   => $self->buffer_size,
          verify_region => $verify_region // $FALSE,
        }
        );

    } ## end foreach my $node ( @{$buckets...})
  } ## end if ( ref $r->{Buckets})

  $self->reset_signer_region($region); # restore original region

  return {
    owner_id          => $owner_id,
    owner_displayname => $owner_displayname,
    buckets           => \@buckets,
  };
} ## end sub buckets

########################################################################
sub reset_signer_region {
########################################################################
  my ( $self, $region ) = @_;

  # reset signer's region, if the region wasn't us-east-1...note this
  # is probably not needed anymore since bucket operations now send
  # the region of the bucket to the signer
  if ( $self->cache_signer ) {
    if ( $self->region && $self->region ne 'us-east-1' ) {
      if ( $self->signer->can('region') ) {
        $self->signer->region($region);
      }
    }
  }
  else {
    $self->region($region);
  }

  return $self->region;
}

########################################################################
sub add_bucket {
########################################################################
  my ( $self, $conf ) = @_;

  my $region = $conf->{location_constraint} // $conf->{region}
    // $self->region;

  if ( $region && $region eq 'us-east-1' ) {
    undef $region;
  }

  my $bucket = $conf->{bucket};

  croak 'must specify bucket'
    if !$bucket;

  my %header_ref;

  if ( $conf->{acl_short} ) {
    $self->_validate_acl_short( $conf->{acl_short} );

    $header_ref{'x-amz-acl'} = $conf->{acl_short};
  } ## end if ( $conf->{acl_short...})

  my $xml = <<'XML';
<CreateBucketConfiguration>
  <LocationConstraint>%s</LocationConstraint>
</CreateBucketConfiguration>
XML

  my $data = defined $region ? sprintf $xml, $region : $EMPTY;

  my $retval = $self->_send_request_expect_nothing(
    { method  => 'PUT',
      path    => "$bucket/",
      headers => \%header_ref,
      data    => $data,
      region  => $region,
    }
  );

  my $bucket_obj = $retval ? $self->bucket($bucket) : undef;

  return $bucket_obj;
} ## end sub add_bucket

########################################################################
sub bucket {
########################################################################
  my ( $self, @args ) = @_;

  my ( $bucketname, $region, $verify_region );

  if ( ref $args[0] && reftype( $args[0] ) eq 'HASH' ) {
    ( $bucketname, $region, $verify_region )
      = @{ $args[0] }{qw{bucket region verify_region}};
  }
  else {
    ( $bucketname, $region ) = @args;
  }

  # only set to default region if a region wasn't passed or region
  # verification not requested
  if ( !$region && !$verify_region ) {
    $region = $self->region;
  }

  return Amazon::S3::Bucket->new(
    { bucket        => $bucketname,
      account       => $self,
      region        => $region,
      verify_region => $verify_region,
    }
  );
} ## end sub bucket

########################################################################
sub delete_bucket {
########################################################################
  my ( $self, $conf ) = @_;

  my $bucket;
  my $region;

  if ( eval { return $conf->isa('Amazon::S3::Bucket'); } ) {
    $bucket = $conf->bucket;
    $region = $conf->region;
  } ## end if ( eval { return $conf...})
  else {
    $bucket = $conf->{bucket};
    $region = $conf->{region} || $self->get_bucket_location($bucket);
  } ## end else [ if ( eval { return $conf...})]

  croak 'must specify bucket'
    if !$bucket;

  return $self->_send_request_expect_nothing(
    { method  => 'DELETE',
      path    => $bucket . $SLASH,
      headers => {},
      region  => $region,
    }
  );
} ## end sub delete_bucket

########################################################################
sub list_bucket_v2 {
########################################################################
  my ( $self, $conf ) = @_;

  $conf->{'list-type'} = '2';

  goto &list_bucket;
} ## end sub list_bucket_v2

########################################################################
sub list_bucket {
########################################################################
  my ( $self, $conf ) = @_;

  my $bucket = delete $conf->{bucket};

  croak 'must specify bucket' if !$bucket;

  $conf ||= {};

  my $path = $bucket . $SLASH;

  if ( %{$conf} ) {
    $path .= $QUESTION_MARK . join $AMPERSAND,
      map { $_ . $EQUAL_SIGN . $self->_urlencode( $conf->{$_} ) }
      keys %{$conf};
  } ## end if ( %{$conf} )

  my $r = $self->_send_request(
    { method  => 'GET',
      path    => $path,
      headers => {},
      region  => $self->region
    }
  );

  return if $self->_remember_errors($r);

  $self->get_logger->debug( sub { return Dumper($r); } );

  my ( $marker, $next_marker ) = qw{ Marker NextMarker };

  if ( $conf->{'list-type'} && $conf->{'list-type'} eq '2' ) {
    $marker      = 'ContinuationToken';
    $next_marker = 'NextContinuationToken';
  } ## end if ( $conf->{'list-type'...})

  my $return = {
    bucket       => $r->{Name},
    prefix       => $r->{Prefix}       // $EMPTY,
    marker       => $r->{$marker}      // $EMPTY,
    next_marker  => $r->{$next_marker} // $EMPTY,
    max_keys     => $r->{MaxKeys},
    is_truncated => (
      ( defined $r->{IsTruncated} && scalar $r->{IsTruncated} eq 'true' )
      ? $TRUE
      : $FALSE
    ),
  };

  my @keys;

  foreach my $node ( @{ $r->{Contents} } ) {
    my $etag = $node->{ETag};

    if ( defined $etag ) {
      $etag =~ s{(^"|"$)}{}gxsm;
    } ## end if ( defined $etag )

    push @keys,
      {
      key               => $node->{Key},
      last_modified     => $node->{LastModified},
      etag              => $etag,
      size              => $node->{Size},
      storage_class     => $node->{StorageClass},
      owner_id          => $node->{Owner}{ID},
      owner_displayname => $node->{Owner}{DisplayName},
      };
  } ## end foreach my $node ( @{ $r->{...}})
  $return->{keys} = \@keys;

  if ( $conf->{delimiter} ) {
    my @common_prefixes;
    my $strip_delim = qr/$conf->{delimiter}$/xsm;

    foreach my $node ( $r->{CommonPrefixes} ) {
      if ( ref $node ne 'ARRAY' ) {
        $node = [$node];
      } ## end if ( ref $node ne 'ARRAY')

      foreach my $n ( @{$node} ) {
        next if !exists $n->{Prefix};
        my $prefix = $n->{Prefix};

        # strip delimiter from end of prefix
        if ($prefix) {
          $prefix =~ s/$strip_delim//xsm;
        } ## end if ($prefix)

        push @common_prefixes, $prefix;
      } ## end foreach my $n ( @{$node} )
    } ## end foreach my $node ( $r->{CommonPrefixes...})
    $return->{common_prefixes} = \@common_prefixes;
  } ## end if ( $conf->{delimiter...})

  return $return;
} ## end sub list_bucket

########################################################################
sub list_bucket_all_v2 {
########################################################################
  my ( $self, $conf ) = @_;
  $conf ||= {};

  $conf->{'list-type'} = '2';

  return $self->list_bucket_all($conf);
} ## end sub list_bucket_all_v2

########################################################################
sub list_bucket_all {
########################################################################
  my ( $self, $conf ) = @_;
  $conf ||= {};

  my $bucket = $conf->{bucket};

  croak 'must specify bucket'
    if !$bucket;

  my $response = $self->list_bucket($conf);
  croak 'The server has stopped responding'
    if !$response;

  return $response
    if !$response->{is_truncated};

  my $all = $response;

  while ($TRUE) {
    my $next_marker = $response->{next_marker}
      || $response->{keys}->[-1]->{key};

    $conf->{marker} = $next_marker;
    $conf->{bucket} = $bucket;

    $response = $self->list_bucket($conf);
    croak 'The server has stopped responding'
      if !$response;

    push @{ $all->{keys} }, @{ $response->{keys} };

    last if !$response->{is_truncated};
  } ## end while ($TRUE)

  delete $all->{is_truncated};
  delete $all->{next_marker};

  return $all;
} ## end sub list_bucket_all

########################################################################
sub get_credentials {
########################################################################
  my ($self) = @_;

  my $aws_access_key_id;
  my $aws_secret_access_key;
  my $token;

  if ( $self->credentials ) {
    $aws_access_key_id     = $self->credentials->get_aws_access_key_id;
    $aws_secret_access_key = $self->credentials->get_aws_secret_access_key;
    $token                 = $self->credentials->get_token;
  } ## end if ( $self->credentials)
  else {
    $aws_access_key_id     = $self->aws_access_key_id;
    $aws_secret_access_key = $self->aws_secret_access_key;
    $token                 = $self->token;
  } ## end else [ if ( $self->credentials)]

  return ( $aws_access_key_id, $aws_secret_access_key, $token );
} ## end sub get_credentials

# Log::Log4perl compatibility routines
########################################################################
sub get_logger {
########################################################################
  my ($self) = @_;

  return $self->logger;
} ## end sub get_logger

########################################################################
sub level {
########################################################################
  my ( $self, @args ) = @_;

  if (@args) {
    $self->log_level( $args[0] );

    $self->get_logger->level( uc $args[0] );
  } ## end if (@args)

  return $self->get_logger->level;
} ## end sub level

########################################################################
sub signer {
########################################################################
  my ($self) = @_;

  return $self->_signer
    if $self->_signer;

  my $creds = $self->credentials ? $self->credentials : $self;

  my $signer = Amazon::S3::Signature::V4->new(
    { access_key_id => $creds->get_aws_access_key_id,
      secret        => $creds->get_aws_secret_access_key,
      region        => $self->region || $self->get_default_region,
      service       => 's3',
      $self->get_token ? ( security_token => $creds->get_token ) : (),
    }
  );

  if ( $self->cache_signer ) {
    $self->_signer($signer);
  }

  return $signer;
}

########################################################################
sub _validate_acl_short {
########################################################################
  my ( $self, $policy_name ) = @_;

  if ( !any { $policy_name eq $_ }
    qw(private public-read public-read-write authenticated-read) ) {
    croak "$policy_name is not a supported canned access policy";
  } ## end if ( !any { $policy_name...})

  return;
} ## end sub _validate_acl_short

# Determine if a bucket can used as subdomain for the host
# Specifying the bucket in the URL path is being deprecated
# So, if the bucket name is suitable, we need to put it
# as a subdomain to the host, instead. Currently buckets with
# periods in their names cannot be handled in that manner
# due to SSL certificate issues, they will have to remain in
# the url path instead
sub _can_bucket_be_subdomain {
  my ($bucketname) = @_;

  if ( length $bucketname > $MAX_BUCKET_NAME_LENGTH - 1 ) {
    return $FALSE;
  } ## end if ( length $bucketname...)

  if ( length $bucketname < $MIN_BUCKET_NAME_LENGTH ) {
    return $FALSE;
  }

  return $FALSE if $bucketname !~ m{\A[[:lower:]][[:lower:]\d-]*\z}xsm;
  return $FALSE if $bucketname !~ m{[[:lower:]\d]\z}xsm;

  return $TRUE;
}

# make the HTTP::Request object

########################################################################
sub _make_request {
########################################################################
  my ( $self, @args ) = @_;
  my ( $method, $path, $headers, $data, $metadata, $region );

  if ( ref $args[0] && reftype( $args[0] ) eq 'HASH' ) {
    ( $method, $path, $headers, $data, $metadata, $region )
      = @{ $args[0] }{qw{method path headers data metadata region}};
  }
  else {
    ( $method, $path, $headers, $data, $metadata, $region ) = @args;
  }

  # reset region on every call...every bucket can have it's own region
  $self->region( $region // $self->_region );

  croak 'must specify method'
    if !$method;

  croak 'must specify path'
    if !defined $path;

  $headers ||= {};

  $metadata ||= {};

  $data //= $EMPTY;

  my $http_headers = $self->_merge_meta( $headers, $metadata );

  my $protocol = $self->secure ? 'https' : 'http';

  my $host = $self->host;

  $path =~ s/\A\///xsm;
  my $url = "$protocol://$host/$path";

  if ( $path =~ m{\A([^/?]+)(.*)}xsm
    && $self->dns_bucket_names
    && _can_bucket_be_subdomain($1) ) {
    $url = "$protocol://$1.$host$2";
  }

  my $request = HTTP::Request->new( $method, $url, $http_headers );

  $self->last_request($request);

  $request->content($data);

  $self->signer->region($region); # always set regional endpoint for signing

  $self->signer->sign($request);

  $self->get_logger->trace( sub { return Dumper( [$request] ); } );

  return $request;
} ## end sub _make_request

# $self->_send_request($HTTP::Request)
# $self->_send_request(@params_to_make_request)
########################################################################
sub _send_request {
########################################################################
  my ( $self, @args ) = @_;

  my $request;

  if ( @args == 1 && ref $args[0] =~ /HTTP::Request/xsm ) {
    $request = $args[0];
  }
  else {
    $request = $self->_make_request(@args);
  }

  my $response = $self->_do_http($request);

  $self->get_logger->debug( Dumper( [$response] ) );

  $self->last_response($response);

  my $content = $response->content;

  if ( $response->code !~ /\A2\d\d\z/xsm ) {
    $self->_remember_errors( $response->content, 1 );
    return;
  }

  if ( $content && $response->content_type eq 'application/xml' ) {
    $content = $self->_xpc_of_content($content);
  } ## end if ( $content && $response...)

  return $content;
} ## end sub _send_request

#
# This is the necessary to find the region for a specific bucket
# and set the signer object to use that region when signing requests
########################################################################
sub adjust_region {
########################################################################
  my ( $self, $bucket, $called_from_redirect ) = @_;

  my $request
    = HTTP::Request->new( 'GET', 'https://' . $bucket . $DOT . $self->host );
  $self->{'signer'}->sign($request);

  # We have to turn off our special retry since this will deliberately trigger that code
  $self->turn_off_special_retry();

  # If the bucket name has a period in it, the certificate validation
  # will fail since it will expect a certificate for a subdomain.
  # Setting it to verify against the expected host guards against
  # that while still being secure since we will have verified
  # the response as coming from the expected server.
  $self->ua->ssl_opts( SSL_verifycn_name => $self->host );

  my $response = $self->_do_http($request);

  # Turn this off, since all other requests have the bucket after
  # the host in the URL, and the host may change depending on the region
  $self->ua->ssl_opts( SSL_verifycn_name => undef );

  $self->turn_on_special_retry();

  # If No error, then nothing to do
  return 1 if $response->is_success();

  # If the error is due to the wrong region, then we will get
  # back a block of XML with the details
  if ( $response->content_type eq 'application/xml' and $response->content ) {

    my $error_hash = $self->_xpc_of_content( $response->content );

    if (  $error_hash->{'Code'} eq 'PermanentRedirect'
      and $error_hash->{'Endpoint'} ) {

      # Don't recurse through multiple redirects
      return if $called_from_redirect;

      # With a permanent redirect error, they are telling us the explicit
      # host to use.  The endpoint will be in the form of bucket.host
      my $host = $error_hash->{'Endpoint'};

      # Remove the bucket name from the front of the host name
      # All the requests will need to be of the form https://host/bucket
      $host =~ s/\A$bucket[.]//xsm;
      $self->host($host);

      # We will need to call ourselves again in order to trigger the
      # AuthorizationHeaderMalformed error in order to get the region
      return $self->adjust_region( $bucket, 1 );
    }

    if (  $error_hash->{'Code'} eq 'AuthorizationHeaderMalformed'
      and $error_hash->{'Region'} ) {

      # Set the signer to use the correct reader evermore
      $self->{'signer'}{'endpoint'} = $error_hash->{'Region'};

      # Only change the host if we haven't been called as a redirect
      # where an exact host has been given
      if ( !$called_from_redirect ) {
        $self->host( 's3-' . $error_hash->{'Region'} . '.amazonaws.com' );
      }

      return 1;
    }

    if ( $error_hash->{'Code'} eq 'IllegalLocationConstraintException' ) {

      # This is hackish; but in this case the region name only appears in the message
      if ( $error_hash->{'Message'} =~ /The (\S+) location/xsm ) {
        my $region = $1;

        # Correct the region for the signer
        $self->{'signer'}{'endpoint'} = $region;

        # Set the proper host for the region
        $self->host( 's3.' . $region . '.amazonaws.com' );

        return 1;
      }
    }

  }

  # Some other error
  $self->_remember_errors( $response->content, 1 );
  return;
}

########################################################################
sub reset_errors {
########################################################################
  my ($self) = @_;

  $self->err(undef);
  $self->errstr(undef);
  $self->error(undef);

  return $self;
}

########################################################################
sub _do_http {
########################################################################
  my ( $self, $request, $filename ) = @_;

  # convenient time to reset any error conditions
  $self->reset_errors;

  my $response = $self->ua->request( $request, $filename );

  # For new buckets at non-standard locations, amazon will sometimes
  # respond with a temporary redirect.  In this case it is necessary
  # to try again with the new URL
  if ( $response->code =~ /\A3/xsm and defined $response->header('Location') )
  {

    $self->get_logger->debug(
      'Redirecting to:  ' . $response->header('Location') );

    $request->uri( $response->header('Location') );
    $response = $self->ua->request( $request, $filename );
  }

  $self->get_logger->debug( Dumper( [$response] ) );

  $self->last_response($response);

  return $response;
}

# Call this if handling any temporary redirect issues
# (Like needing to probe with a HEAD request when file handle are involved)

########################################################################
sub _do_http_no_redirect {
########################################################################
  my ( $self, $request, $filename ) = @_;

  # convenient time to reset any error conditions
  $self->reset_errors;

  my $response = $self->ua->request( $request, $filename );
  $self->get_logger->debug( Dumper( [$response] ) );

  $self->last_response($response);

  return $response;
} ## end sub _do_http

########################################################################
sub _send_request_expect_nothing {
########################################################################
  my ( $self, @args ) = @_;

  my $request = $self->_make_request(@args);

  my $response = $self->_do_http($request);

  my $content = $response->content;

  return $TRUE
    if $response->code =~ /^2\d\d$/xsm;

  # anything else is a failure, and we save the parsed result
  $self->_remember_errors( $response->content, $TRUE );

  return $FALSE;
} ## end sub _send_request_expect_nothing

# Send a HEAD request first, to find out if we'll be hit with a 307 redirect.
# Since currently LWP does not have true support for 100 Continue, it simply
# slams the PUT body into the socket without waiting for any possible redirect.
# Thus when we're reading from a filehandle, when LWP goes to reissue the request
# having followed the redirect, the filehandle's already been closed from the
# first time we used it. Thus, we need to probe first to find out what's going on,
# before we start sending any actual data.
########################################################################
sub _send_request_expect_nothing_probed {
########################################################################
  my ( $self, @args ) = @_;

  my ( $method, $path, $conf, $value, $region );

  if ( @args == 1 && ref $args[0] ) {
    ( $method, $path, $conf, $value, $region )
      = @{ $args[0] }{qw{method path headers data region}};
  }
  else {
    ( $method, $path, $conf, $value, $region )
      = @{ $args[0] }{qw{method path headers data region}};
  }

  $region = $region // $self->region;

  my $request = $self->_make_request(
    { method => 'HEAD',
      path   => $path,
      region => $region
    }
  );

  my $override_uri = undef;

  my $old_redirectable = $self->ua->requests_redirectable;
  $self->ua->requests_redirectable( [] );

  my $response = $self->_do_http_no_redirect($request);

  if ( $response->code =~ /^3/xsm ) {
    if ( defined $response->header('Location') ) {
      $override_uri = $response->header('Location');
    } ## end if ( $response->code =~...)
    else {
      $self->_croak_if_response_error($response);
    }

    $self->get_logger->debug( 'setting override URI to ', $override_uri );
  }

  $request = $self->_make_request(
    { method  => $method,
      path    => $path,
      headers => $conf,
      data    => $value,
      region  => $region
    }
  );

  if ( defined $override_uri ) {
    $request->uri($override_uri);
  } ## end if ( defined $override_uri)

  $response = $self->_do_http_no_redirect($request);

  $self->ua->requests_redirectable($old_redirectable);

  my $content = $response->content;

  return $TRUE
    if $response->code =~ /^2\d\d$/xsm;

  # anything else is a failure, and we save the parsed result
  $self->_remember_errors( $response->content, $TRUE );

  return $FALSE;
} ## end sub _send_request_expect_nothing_probed

########################################################################
sub _croak_if_response_error {
########################################################################
  my ( $self, $response ) = @_;

  if ( $response->code !~ /^2\d\d$/xsm ) {
    $self->err('network_error');

    $self->errstr( $response->status_line );

    croak sprintf 'Amazon::S3: Amazon responded with %s ',
      $response->status_line;
  } ## end if ( $response->code !~...)

  return;
} ## end sub _croak_if_response_error

########################################################################
sub _xpc_of_content {
########################################################################
  my ( $self, $src, $keep_root ) = @_;

  my $xml_hr;

  eval {
    $xml_hr = XMLin(
      $src,
      'SuppressEmpty' => $EMPTY,
      'ForceArray'    => ['Contents'],
      'KeepRoot'      => $keep_root
    );
  };

  if ($EVAL_ERROR) {
    confess "Error parsing $src:  $EVAL_ERROR";
  }

  return $xml_hr;
} ## end sub _xpc_of_content

# returns 1 if errors were found
########################################################################
sub _remember_errors {
########################################################################
  my ( $self, $src, $keep_root ) = @_;

  return $TRUE if !$src; # this should not happen

  if ( !ref $src && $src !~ /^[[:space:]]*</xsm ) { # if not xml
    ( my $code = $src ) =~ s/^[[:space:]]*[(][\d]*[)].*$/$1/xsm;

    $self->err($code);
    $self->errstr($src);

    return $TRUE;
  } ## end if ( !ref $src && $src...)

  my $r = ref $src ? $src : $self->_xpc_of_content( $src, $keep_root );

  $self->error($r);

  # apparently buckets() does not keep_root
  if ( $r->{Error} ) {
    $r = $r->{Error};
  } ## end if ( $r->{Error} )

  if ( $r->{Code} ) {
    $self->err( $r->{Code} );
    $self->errstr( $r->{Message} );

    return $TRUE;
  } ## end if ( $r->{Code} )

  return $FALSE;
} ## end sub _remember_errors

#
# Deprecated - this adds a header for the old V2 auth signatures
#
########################################################################
sub _add_auth_header {
########################################################################
  my ( $self, $headers, $method, $path ) = @_;

  my ( $aws_access_key_id, $aws_secret_access_key, $token )
    = $self->get_credentials;

  if ( not $headers->header('Date') ) {
    $headers->header( Date => time2str(time) );
  } ## end if ( not $headers->header...)

  if ($token) {
    $headers->header( $AMAZON_HEADER_PREFIX . 'security-token', $token );
  } ## end if ($token)

  my $canonical_string = $self->_canonical_string( $method, $path, $headers );
  $self->get_logger->trace( Dumper( [$headers] ) );
  $self->get_logger->trace("canonical string: $canonical_string\n");

  my $encoded_canonical
    = $self->_encode( $aws_secret_access_key, $canonical_string );

  $headers->header(
    Authorization => "AWS $aws_access_key_id:$encoded_canonical" );

  return;
} ## end sub _add_auth_header

# generates an HTTP::Headers objects given one hash that represents http
# headers to set and another hash that represents an object's metadata.
########################################################################
sub _merge_meta {
########################################################################
  my ( $self, $headers, $metadata ) = @_;

  $headers  ||= {};
  $metadata ||= {};

  my $http_header = HTTP::Headers->new;

  while ( my ( $k, $v ) = each %{$headers} ) {
    $http_header->header( $k => $v );
  } ## end while ( my ( $k, $v ) = each...)

  while ( my ( $k, $v ) = each %{$metadata} ) {
    $http_header->header( "$METADATA_PREFIX$k" => $v );
  } ## end while ( my ( $k, $v ) = each...)

  return $http_header;
} ## end sub _merge_meta

# generate a canonical string for the given parameters.  expires is optional and is
# only used by query string authentication.
########################################################################
sub _canonical_string {
########################################################################
  my ( $self, $method, $path, $headers, $expires ) = @_;

  # initial / meant to force host/bucket-name instead of DNS based name
  $path =~ s/^\///xsm;

  my %interesting_headers = ();

  while ( my ( $key, $value ) = each %{$headers} ) {
    my $lk = lc $key;

    if ( $lk eq 'content-md5'
      or $lk eq 'content-type'
      or $lk eq 'date'
      or $lk =~ /^$AMAZON_HEADER_PREFIX/xsm ) {
      $interesting_headers{$lk} = $self->_trim($value);
    } ## end if ( $lk eq 'content-md5'...)
  } ## end while ( my ( $key, $value...))

  # these keys get empty strings if they don't exist
  $interesting_headers{'content-type'} ||= $EMPTY;
  $interesting_headers{'content-md5'}  ||= $EMPTY;

  # just in case someone used this.  it's not necessary in this lib.
  if ( $interesting_headers{'x-amz-date'} ) {
    $interesting_headers{'date'} = $EMPTY;
  } ## end if ( $interesting_headers...)

  # if you're using expires for query string auth, then it trumps date
  # (and x-amz-date)
  if ($expires) {
    $interesting_headers{'date'} = $expires;
  } ## end if ($expires)

  my $buf = "$method\n";

  foreach my $key ( sort keys %interesting_headers ) {
    if ( $key =~ /^$AMAZON_HEADER_PREFIX/xsm ) {
      $buf .= "$key:$interesting_headers{$key}\n";
    } ## end if ( $key =~ /^$AMAZON_HEADER_PREFIX/xsm)
    else {
      $buf .= "$interesting_headers{$key}\n";
    } ## end else [ if ( $key =~ /^$AMAZON_HEADER_PREFIX/xsm)]
  } ## end foreach my $key ( sort keys...)

  # don't include anything after the first ? in the resource...
  #  $path =~ /^([^?]*)/xsm;
  #  $buf .= "/$1";
  $path =~ /\A([^?]*)/xsm;
  $buf .= "/$1";

  # ...unless there any parameters we're interested in...
  if ( $path =~ /[&?](acl|torrent|location|uploads|delete)($|=|&)/xsm ) {
    #  if ( $path =~ /[&?](acl|torrent|location|uploads|delete)([=&])?/xsm ) {
    $buf .= "?$1";
  } ## end if ( $path =~ ...)
  elsif ( my %query_params = URI->new($path)->query_form ) {
    # see if the remaining parsed query string provides us with any
    # query string or upload id

    if ( $query_params{partNumber} && $query_params{uploadId} ) {
      # re-evaluate query string, the order of the params is important
      # for request signing, so we can't depend on URI to do the right
      # thing
      $buf .= sprintf '?partNumber=%s&uploadId=%s',
        $query_params{partNumber},
        $query_params{uploadId};
    } ## end if ( $query_params{partNumber...})
    elsif ( $query_params{uploadId} ) {
      $buf .= sprintf '?uploadId=%s', $query_params{uploadId};
    } ## end elsif ( $query_params{uploadId...})
  } ## end elsif ( my %query_params ...)

  return $buf;
} ## end sub _canonical_string

########################################################################
sub _trim {
########################################################################
  my ( $self, $value ) = @_;

  $value =~ s/^\s+//xsm;
  $value =~ s/\s+$//xsm;

  return $value;
} ## end sub _trim

# finds the hmac-sha1 hash of the canonical string and the aws secret access key and then
# base64 encodes the result (optionally urlencoding after that).
########################################################################
sub _encode {
########################################################################
  my ( $self, $aws_secret_access_key, $str, $urlencode ) = @_;

  my $hmac = Digest::HMAC_SHA1->new($aws_secret_access_key);
  $hmac->add($str);

  my $b64 = encode_base64( $hmac->digest, $EMPTY );

  return $urlencode ? $self->_urlencode($b64) : return $b64;
} ## end sub _encode

########################################################################
sub _urlencode {
########################################################################
  my ( $self, $unencoded ) = @_;

  return uri_escape_utf8( $unencoded, '^A-Za-z0-9\-\._~\x2f' );
} ## end sub _urlencode

1;

__END__

=pod

=head1 NAME

Amazon::S3 - A portable client library for working with and
managing Amazon S3 buckets and keys.

=begin markdown

![Amazon::S3](https://github.com/rlauer6/perl-amazon-s3/actions/workflows/build.yml/badge.svg?event=push)

=end markdown

=head1 SYNOPSIS

  #!/usr/bin/perl
  use warnings;
  use strict;

  use Amazon::S3;
  
  use vars qw/$OWNER_ID $OWNER_DISPLAYNAME/;
  
  my $aws_access_key_id     = "Fill me in!";
  my $aws_secret_access_key = "Fill me in too!";
  
  my $s3 = Amazon::S3->new(
      {   aws_access_key_id     => $aws_access_key_id,
          aws_secret_access_key => $aws_secret_access_key,
          retry                 => 1
      }
  );
  
  my $response = $s3->buckets;
  
  # create a bucket
  my $bucket_name = $aws_access_key_id . '-net-amazon-s3-test';
  my $bucket = $s3->add_bucket( { bucket => $bucket_name } )
      or die $s3->err . ": " . $s3->errstr;
  
  # store a key with a content-type and some optional metadata
  my $keyname = 'testing.txt';
  my $value   = 'T';
  $bucket->add_key(
      $keyname, $value,
      {   content_type        => 'text/plain',
          'x-amz-meta-colour' => 'orange',
      }
  );
  
  # list keys in the bucket
  $response = $bucket->list
      or die $s3->err . ": " . $s3->errstr;
  print $response->{bucket}."\n";
  for my $key (@{ $response->{keys} }) {
        print "\t".$key->{key}."\n";  
  }

  # delete key from bucket
  $bucket->delete_key($keyname);
  
  # delete bucket
  $bucket->delete_bucket;

=head1 DESCRIPTION

C<Amazon::S3> provides a portable client interface to Amazon Simple
Storage System (S3).

I<This module is rather dated. For a much more robust and modern
implementation of an S3 interface try C<Net::Amazon::S3>.
C<Amazon::S3> ostensibly was intended to be a drop-in replacement for
C<Net:Amazon::S3> that "traded some performance in return for
portability". That statement is no longer accurate as
C<Net::Amazon::S3> implements much more of the S3 API and may have
changed the interface in ways that might break your
applications. However, C<Net::Amazon::S3> is today dependent on
C<Moose> which may in fact level the playing field in terms of
performance penalties that may have been introduced by
C<Amazon::S3>. YMMV, however, this module may still appeal to some
that favor simplicity of the interface and a lower number of
dependencies. Below is the original description of the module.>

=over 10

Amazon S3 is storage for the Internet. It is designed to
make web-scale computing easier for developers. Amazon S3
provides a simple web services interface that can be used to
store and retrieve any amount of data, at any time, from
anywhere on the web. It gives any developer access to the
same highly scalable, reliable, fast, inexpensive data
storage infrastructure that Amazon uses to run its own
global network of web sites. The service aims to maximize
benefits of scale and to pass those benefits on to
developers.

To sign up for an Amazon Web Services account, required to
use this library and the S3 service, please visit the Amazon
Web Services web site at http://www.amazonaws.com/.

You will be billed accordingly by Amazon when you use this
module and must be responsible for these costs.

To learn more about Amazon's S3 service, please visit:
http://s3.amazonaws.com/.

The need for this module arose from some work that needed
to work with S3 and would be distributed, installed and used
on many various environments where compiled dependencies may
not be an option. L<Net::Amazon::S3> used L<XML::LibXML>
tying it to that specific and often difficult to install
option. In order to remove this potential barrier to entry,
this module is forked and then modified to use L<XML::SAX>
via L<XML::Simple>.

=back

=head1 LIMITATIONS AND DIFFERENCES WITH EARLIER VERSIONS

As noted, this module is no longer a I<drop-in> replacement for
C<Net::Amazon::S3> and has limitations and differences that may make
the use of this module in your applications questionable.

=over 5

=item MINIMUM PERL

Technically, this module should run on versions 5.10 and above,
however some of the dependencies may require higher versions of
C<perl> or install new versions some dependencies that conflict with
other versions of dependencies...it's a crapshoot when dealing with
older C<perl> version and CPAN modules.

You may however, be able to build this module by installing older
versions of those dependencies and take your chances that those older
versions provide enough working features to support C<Amazon::S3>. It
is likely they do...and this module has recently been tested on
version 5.10.0 C<perl> using some older CPAN modules to resolve
dependency issues.

To build this module on an earlier version of C<perl> you may need to
downgrade some modules.  In particular I have found this recipe to
work for building and testing on 5.10.0.

In this order install:

 HTML::HeadParser 2.14
 LWP 6.13
 Amazon::S3 0.55

...other versions I<may> work...YMMV.

=item * API Signing

Making calls to AWS APIs requires that the calls be signed.  Amazon
has added a new signing method (Signature Version 4) to increase
security around their APIs. This module no longer utilizes Signature
Version V2.

B<New regions after January 30, 2014 will only support Signature Version 4.>

See L</Signature Version V4> below for important details.>

=over 10

=item Signature Version 4

L<https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html>

I<IMPORTANT NOTE:>

Unlike Signature Version 2, Version 4 requires a regional
parameter. This implies that you need to supply the bucket's region
when signing requests for any API call that involves a specific
bucket. Starting with version 0.55 of this module,
C<Amazon::S3::Bucket> provides a new method (C<region()> and accepts
in the constructor a C<region> parameter.  If a region is not
supplied, the region for the bucket will be set to the region set in
the C<account> object (C<Amazon::S3>) that you passed to the bucket's
new constructor.  Alternatively, you can request that the bucket's new
constructor determine the bucket's region for you by calling the
C<get_location_constraint()> method.

When signing API calls, the region for the specific bucket will be
used. For calls that are not regional (C<buckets()>, e.g.) the default
region ('us-east-1') will be used.

=item Signature Version 2

L<https://docs.aws.amazon.com/AmazonS3/latest/userguide/RESTAuthentication.html>

=back

=item * New APIs

This module does not support some of the newer API method calls
for S3 added after the initial creation of this interface.

=item * Multipart Upload Support

There is limited testing for multipart uploads.

For more information regarding multi-part uploads visit the link below.

L<https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html>

=back

=head1 METHODS AND SUBROUTINES

=head2 new 

Create a new S3 client object. Takes some arguments:

=over

=item credentials (optional)

Reference to a class (like C<Amazon::Credentials>) that can provide
credentials via the methods:

 get_aws_access_key_id()
 get_aws_secret_access_key()
 get_token()

If you do not provide a credential class you must provide the keys
when you instantiate the object. See below.

I<You are strongly encourage to use a class that provides getters. If
you choose to provide your credentials to this class then they will be
stored in this object. If you dump the class you will likely expose
those credentials.>

=item aws_access_key_id

Use your Access Key ID as the value of the AWSAccessKeyId parameter
in requests you send to Amazon Web Services (when required). Your
Access Key ID identifies you as the party responsible for the
request.

=item aws_secret_access_key 

Since your Access Key ID is not encrypted in requests to AWS, it
could be discovered and used by anyone. Services that are not free
require you to provide additional information, a request signature,
to verify that a request containing your unique Access Key ID could
only have come from you.

B<DO NOT INCLUDE THIS IN SCRIPTS OR APPLICATIONS YOU
DISTRIBUTE. YOU'LL BE SORRY.>

I<Consider using a credential class as described above to provide
credentials, otherwise this class will store your credentials for
signing the requests. If you dump this object to logs your credentials
could be discovered.>

=item token

An optional temporary token that will be inserted in the request along
with your access and secret key.  A token is used in conjunction with
temporary credentials when your EC2 instance has
assumed a role and you've scraped the temporary credentials from
I<http://169.254.169.254/latest/meta-data/iam/security-credentials>

=item secure

Set this to a true value if you want to use SSL-encrypted connections
when connecting to S3. Starting in version 0.49, the default is true.

default: true

=item timeout

Defines the time, in seconds, your script should wait or a
response before bailing.

default: 30s

=item retry

Enables or disables the library to retry upon errors. This
uses exponential backoff with retries after 1, 2, 4, 8, 16,
32 seconds, as recommended by Amazon.

default: off

=item host

Defines the S3 host endpoint to use.

default: s3.amazonaws.com

Note that requests are made to domain buckets when possible.  You can
prevent that behavior if either the bucket name does conform to DNS
bucket naming conventions or you preface the bucket name with '/'.

If you set a region then the host name will be modified accordingly if
it is an Amazon endpoint.

=item region

The AWS region you where your bucket is located.

default: us-east-1

=item buffer_size

The default buffer size when reading or writing files.

default: 4096

=back

=head2 signer

Sets or retrieves the signer object. API calls must be signed using
your AWS credentials. By default, starting with version 0.54 the
module will use L<Net::Amazon::Signature::V4> as the signer and
instantiate a signer object in the constructor. Note however, that
signers need your credentials and they I<will> get stored by that
class, making them susceptible to inadvertant exfiltration. You have a
few options here:

=over 5

=item 1. Use your own signer.

You may have noticed that you can also provide your own credentials
object forcing this module to use your object for retrieving
credentials. Likewise, you can use your own signer so that this
module's signer never sees or stores those credentials.

=item 2. Pass the credentials object and set C<cache_signer> to a
false value.

If you pass a credentials object and set C<cache_signer> to a false
value, the module will use the credentials object to retrieve
credentials and create a new signer each time an API call is made that
requires signing. This prevents your credentials from being stored
inside of the signer class.

I<Note that using your own credentials object that stores your
credentials in plaintext is also going to expose your credentials when
someone dumps the class.>

=item 3. Pass credentials, set C<cache_signer> to a false value.

Unfortunately, while this will prevent L<Net::Amazon::Signature::V4>
from hanging on to your credentials, you credentials will be stored in
the L<Amazon::S3> object.

Starting with version 0.55 of this module, if you have installed
L<Crypt::CBC> and L<Crypt::Blowfish>, your credentials will be
encrypted using a random key created when the class is
instantiated. While this is more secure than leaving them in
plaintext, if the key is discovered (the key however is not stored in
the object's hash) and the object is dumped, your I<encrypted>
credentials can be exposed.

=item 4. Use very granular credentials for bucket access only.

Use credentials that only allow access to a bucket or portions of a
bucket required for your application. This will at least limit the
I<blast radius> of any potential security breach.

=item 5. Do nothing...send the credentials, use the default signer.

In this case, both the L<Amazon::S3> class and the
L<Net::Amazon::Signature::V4> have your credentials. Caveat Emptor.

See Also L<Amazon::Credentials> for more information about safely
storing your credentials and preventing exfiltration.

=back

=head2 region

Sets the region for the for the API calls. This will also be the
default when instantiating the bucket object unless you pass the
region parameter in the C<bucket> method or use the C<verify_region>
flag that will I<always> verify the region of the bucket using the
C<get_location_constraint> method.

default: us-east-1

=head2 buckets

 buckets([verify-region])

=over

=item verify-region (optional)

C<verify-region> is a boolean value that indicates if the
bucket's region should be verified when the bucket object is
instantiated.

If set to true, this method will call the C<bucket> method with
C<verify_region> set to true causing the constructor to call the
C<get_location_constraint> for each bucket to set the bucket's
region. This will cause a significant decrease in the peformance of
the C<buckets()> method. Setting the region for each bucket is
necessary since API operations on buckets require the region of the
bucket when signing API requests. If all of your buckets are in the
same region and you have passed a region parameter to your S3 object,
then that region will be used when calling the constructor of your
bucket objects.

default: false

=back

Returns a HASHREF containging the metadata for all of the buckets
owned by the accout or (see below) or C<undef> on
error.

=over

=item owner_id

The owner ID of the bucket's owner.

=item owner_display_name

The name of the owner account. 

=item buckets

Any ARRAYREF of L<Amazon::S3::Bucket> objects for the 
account.

=back

=head2 add_bucket

 add_bucket(bucket-configuration)

C<bucket-configuration> is a reference to a hash with bucket configuration
parameters.

=over

=item bucket

The name of the bucket. See L<Bucket name
rules|https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html>
for more details on bucket naming rules.

=item acl_short (optional)

See the set_acl subroutine for documenation on the acl_short options

=item location_constraint

=item region

The region the bucket is to be created in.

=back

Returns a L<Amazon::S3::Bucket> object on success or C<undef> on failure.

=head2 bucket

 bucket(bucket, [region])

 bucket({ bucket => bucket-name, verify_region => boolean, region => region });

Takes a scalar argument or refernce to a hash of arguments.

You can pass the region or set C<verify_region> indicating that
you want the bucket constructor to detemine the bucket region.

If you do not pass the region or set the C<verify_region> value, the
region will be set to the default region set in your C<Amazon::S3>
object.

See L<Amazon::S3::Bucket> for a complete description of the C<bucket>
method.

=head2 delete_bucket

Takes either a L<Amazon::S3::Bucket> object or a HASHREF containing:

=over

=item bucket

The name of the bucket to remove

=item region

Region the bucket is located in. If not provided, the method will
determine the bucket's region by calling C<get_bucket_location>.

=back

Returns a boolean indicating the success of failure of the API
call. Check C<err> or C<errstr> for error messages.

Note from the L<Amazon's documentation|https://docs.aws.amazon.com/AmazonS3/latest/userguide/BucketRestrictions.html>

=over 10

If a bucket is empty, you can delete it. After a bucket is deleted,
the name becomes available for reuse. However, after you delete the
bucket, you might not be able to reuse the name for various reasons.

For example, when you delete the bucket and the name becomes available
for reuse, another AWS account might create a bucket with that
name. In addition, B<some time might pass before you can reuse the name
of a deleted bucket>. If you want to use the same bucket name, we
recommend that you don't delete the bucket.

=back

=head2 dns_bucket_names

Set or get a boolean that indicates whether to use DNS bucket
names.

default: true

=head2 list_bucket, list_bucket_v2

List all keys in this bucket.

Takes a HASHREF of arguments:

=over

=item bucket

REQUIRED. The name of the bucket you want to list keys on.

=item prefix

Restricts the response to only contain results that begin with the
specified prefix. If you omit this optional argument, the value of
prefix for your query will be the empty string. In other words, the
results will be not be restricted by prefix.

=item delimiter

If this optional, Unicode string parameter is included with your
request, then keys that contain the same string between the prefix
and the first occurrence of the delimiter will be rolled up into a
single result element in the CommonPrefixes collection. These
rolled-up keys are not returned elsewhere in the response.  For
example, with prefix="USA/" and delimiter="/", the matching keys
"USA/Oregon/Salem" and "USA/Oregon/Portland" would be summarized
in the response as a single "USA/Oregon" element in the CommonPrefixes
collection. If an otherwise matching key does not contain the
delimiter after the prefix, it appears in the Contents collection.

Each element in the CommonPrefixes collection counts as one against
the MaxKeys limit. The rolled-up keys represented by each CommonPrefixes
element do not.  If the Delimiter parameter is not present in your
request, keys in the result set will not be rolled-up and neither
the CommonPrefixes collection nor the NextMarker element will be
present in the response.

NOTE: CommonPrefixes isn't currently supported by Amazon::S3. 

=item max-keys 

This optional argument limits the number of results returned in
response to your query. Amazon S3 will return no more than this
number of results, but possibly less. Even if max-keys is not
specified, Amazon S3 will limit the number of results in the response.
Check the IsTruncated flag to see if your results are incomplete.
If so, use the Marker parameter to request the next page of results.
For the purpose of counting max-keys, a 'result' is either a key
in the 'Contents' collection, or a delimited prefix in the
'CommonPrefixes' collection. So for delimiter requests, max-keys
limits the total number of list results, not just the number of
keys.

=item marker

This optional parameter enables pagination of large result sets.
C<marker> specifies where in the result set to resume listing. It
restricts the response to only contain results that occur alphabetically
after the value of marker. To retrieve the next page of results,
use the last key from the current page of results as the marker in
your next request.

See also C<next_marker>, below. 

If C<marker> is omitted,the first page of results is returned. 

=back

Returns C<undef> on error and a HASHREF of data on success:

The HASHREF looks like this:

  {
        bucket       => $bucket_name,
        prefix       => $bucket_prefix, 
        marker       => $bucket_marker, 
        next_marker  => $bucket_next_available_marker,
        max_keys     => $bucket_max_keys,
        is_truncated => $bucket_is_truncated_boolean
        keys          => [$key1,$key2,...]
   }

Explanation of bits of that:

=over

=item is_truncated

B flag that indicates whether or not all results of your query were
returned in this response. If your results were truncated, you can
make a follow-up paginated request using the Marker parameter to
retrieve the rest of the results.

=item next_marker 

A convenience element, useful when paginating with delimiters. The
value of C<next_marker>, if present, is the largest (alphabetically)
of all key names and all CommonPrefixes prefixes in the response.
If the C<is_truncated> flag is set, request the next page of results
by setting C<marker> to the value of C<next_marker>. This element
is only present in the response if the C<delimiter> parameter was
sent with the request.

=back

Each key is a HASHREF that looks like this:

     {
        key           => $key,
        last_modified => $last_mod_date,
        etag          => $etag, # An MD5 sum of the stored content.
        size          => $size, # Bytes
        storage_class => $storage_class # Doc?
        owner_id      => $owner_id,
        owner_displayname => $owner_name
    }

=head2 get_bucket_location

 get_bucket_location(bucket-name)
 get_bucket_locaiton(bucket-obj)

This is a convenience routines for the C<get_location_constraint()> of
the bucket object.  This method will, however return the default
region of 'us-east-1' when C<get_location_constraint()> returns a null
value.

 my $region = $s3->get_bucket_location('my-bucket');

Starting with version 0.55, C<Amazon::S3::Bucket> will call this
C<get_location_constraint()> to determine the region for the
bucket. You can get the region for the bucket by using the C<region()>
method of the bucket object.

  my $bucket = $s3->bucket('my-bucket');
  my $bucket_region = $bucket->region;

=head2 get_logger

Returns the logger object. If you did not set a logger when you
created the object then the an instance of C<Amazon::S3::Logger> is
returned. You can log to STDERR using this logger. For example:

 $s3->get_logger->debug('this is a debug message');

 $s3->get_logger->trace(sub { return Dumper([$response]) });

=head2 list_bucket_all, list_bucket_all_v2

List all keys in this bucket without having to worry about
'marker'. This is a convenience method, but may make multiple requests
to S3 under the hood.

Takes the same arguments as list_bucket.

I<You are encouraged to use the newer C<list_bucket_all_v2> method.>

=head2 err

The S3 error code for the last error encountered.

=head2 errstr

A human readable error string for the last error encountered.

=head2 error

The decoded XML string as a hash object of the last error.

=head2 last_response

Returns the last L<HTTP::Response> object.

=head2 last_request

Returns the last L<HTTP::Request> object.

=head2 level

Set the logging level.

default: error

=head2 turn_on_special_retry

Called to add extra retry codes if retry has been set

=head2 turn_off_special_retry

Called to turn off special retry codes when we are deliberately triggering them

=head1 ABOUT

This module contains code modified from Amazon that contains the
following notice:

  #  This software code is made available "AS IS" without warranties of any
  #  kind.  You may copy, display, modify and redistribute the software
  #  code either by itself or as incorporated into your code; provided that
  #  you do not remove any proprietary notices.  Your use of this software
  #  code is at your own risk and you waive any claim against Amazon
  #  Digital Services, Inc. or its affiliates with respect to your use of
  #  this software code. (c) 2006 Amazon Digital Services, Inc. or its
  #  affiliates.

=head1 TESTING

Testing S3 is a tricky thing. Amazon wants to charge you a bit of 
money each time you use their service. And yes, testing counts as using.
Because of this, the application's test suite skips anything approaching 
a real test unless you set these environment variables:

=over 

=item AMAZON_S3_EXPENSIVE_TESTS

Doesn't matter what you set it to. Just has to be set

=item AMAZON_S3_HOST

Sets the host to use for the API service.

default: s3.amazonaws.com

Note that if this value is set, DNS bucket name usage will be disabled
for testing. Most likely, if you set this variable, you are using a
mocking service and your bucket names are probably not resolvable. You
can override this behavior by setting C<AWS_S3_DNS_BUCKET_NAMES> to any
value.

=item AWS_S3_DSN_BUCKET_NAMES

Set this to any value to override the default behavior of disabling
DNS bucket names during testing.

=item AWS_ACCESS_KEY_ID 

Your AWS access key

=item AWS_ACCESS_KEY_SECRET

Your AWS sekkr1t passkey. Be forewarned that setting this environment variable
on a shared system might leak that information to another user. Be careful.

=item AMAZON_S3_SKIP_ACL_TESTS

Doesn't matter what you set it to. Just has to be set if you want
to skip ACLs tests.

=item AMAZON_S3_SKIP_REGION_CONSTRAINT_TEST

Doesn't matter what you set it to. Just has to be set if you want
to skip region constraint test.

=item AMAZON_S3_MINIO

Doesn't matter what you set it to. Just has to be set if you want
to skip tests that would fail on minio.

=item AMAZON_S3_LOCALSTACK

Doesn't matter what you set it to. Just has to be set if you want
to skip tests that would fail on LocalStack.

=item AMAZON_S3_REGIONS

A comma delimited list of regions to use for testing. The default will
only test creating a bucket in the local region.

=back

I<Consider using an S3 mocking service like C<minio> or C<LocalStack>
if you want to create real tests for your applications or this module.>

=head1 ADDITIONAL INFORMATION

=head2 LOGGING AND DEBUGGING

Additional debugging information can be output to STDERR by setting
the C<level> option when you instantiate the C<Amazon::S3>
object. Levels are represented as a string.  The valid levels are:

 fatal
 error
 warn
 info
 debug
 trace

You can set an optionally pass in a logger that implements a subset of
the C<Log::Log4perl> interface.  Your logger should support at least
these method calls. If you do not supply a logger the default logger
(C<Amazon::S3::Logger>) will be used.

 get_logger()
 fatal()
 error()
 warn()
 info()
 debug()
 trace()
 level()

At the C<trace> level, every HTTP request and response will be output
to STDERR.  At the C<debug> level information regarding the higher
level methods will be output to STDERR.  There currently is no
additional information logged at lower levels.

=head2 S3 LINKS OF INTEREST

=over 5

=item L<Bucket restrictions and limitations|https://docs.aws.amazon.com/AmazonS3/latest/userguide/BucketRestrictions.html>

=item L<Bucket naming rules|https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html>

=item L<Amazon S3 REST API|https://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html>

=item L<Authenticating Requests (AWS Signature Version 4)|https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html>

=item L<Authenticating Requests (AWS Signature Version 2)|https://docs.aws.amazon.com/AmazonS3/latest/userguide/RESTAuthentication.html>

=back

=head1 SUPPORT

Bugs should be reported via the CPAN bug tracker at

<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Amazon-S3>

For other issues, contact the author.

=head1 AUTHOR

Original author: Timothy Appnel <tima@cpan.org>

Current maintainer: Rob Lauer <bigfoot@cpan.org>

=head1 SEE ALSO

L<Amazon::S3::Bucket>, L<Net::Amazon::S3>

=head1 COPYRIGHT AND LICENCE

This module was initially based on L<Net::Amazon::S3> 0.41, by
Leon Brocard. Net::Amazon::S3 was based on example code from
Amazon with this notice:

I<This software code is made available "AS IS" without warranties of any
kind.  You may copy, display, modify and redistribute the software
code either by itself or as incorporated into your code; provided that
you do not remove any proprietary notices.  Your use of this software
code is at your own risk and you waive any claim against Amazon
Digital Services, Inc. or its affiliates with respect to your use of
this software code. (c) 2006 Amazon Digital Services, Inc. or its
affiliates.>

The software is released under the Artistic License. The
terms of the Artistic License are described at
http://www.perl.com/language/misc/Artistic.html. Except
where otherwise noted, C<Amazon::S3> is Copyright 2008, Timothy
Appnel, tima@cpan.org. All rights reserved.
