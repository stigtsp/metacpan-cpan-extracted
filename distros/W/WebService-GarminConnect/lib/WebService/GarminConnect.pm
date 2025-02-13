package WebService::GarminConnect;

use 5.006;
use warnings FATAL => 'all';
use strict;
use Carp;
use LWP::UserAgent;
use URI;
use JSON;
use Data::Dumper;

our $VERSION = '1.0.9'; # VERSION

=head1 NAME

WebService::GarminConnect - Access data from Garmin Connect

=head1 VERSION

version 1.0.9

=head1 SYNOPSIS

With WebService::GarminConnect, you can search the activities stored on the
Garmin Connect site.

    use WebService::GarminConnect;

    my $gc = WebService::GarminConnect->new( username => 'myuser',
                                             password => 'password' );
    my @activities = $gc->activities( limit => 20 );
    foreach my $a ( @activities ) {
      my $name = $a->{name};
      ...
    }

=head1 FUNCTIONS

=head2 new( %options )

Creates a new WebService::GarminConnect object. One or more options may be
specified:

=over

=item username

(Required) The Garmin Connect username to use for searches.

=item password

(Required) The user's Garmin Connect password.

=item loginurl

(Optional) Override the default login URL for Garmin Connect.

=item searchurl

(Optional) Override the default search URL for Garmin Connect.

=back

=cut

sub new {
  my $self = shift;
  my %options = @_;

  # Check for mandatory options
  foreach my $required_option ( qw( username password ) ) {
    croak "option \"$required_option\" is required"
      unless defined $options{$required_option};
  }

  return bless {
    username  => $options{username},
    password  => $options{password},
    loginurl  => $options{loginurl} || 'https://sso.garmin.com/sso/signin',
    searchurl => $options{searchurl} || 'https://connect.garmin.com/modern/proxy/activitylist-service/activities/search/activities',
  }, $self;
}

sub _login {
  my $self = shift;

  # Bail out if we're already logged in.
  return if defined $self->{is_logged_in};

  my $ua = LWP::UserAgent->new(agent => 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko');
  $ua->cookie_jar( {} );
  push @{ $ua->requests_redirectable }, 'POST';

  # Retrieve the login page
  my %params = (
    service   => "https://connect.garmin.com/post-auth/login",
    gauthHost => "https://sso.garmin.com/sso",
    clientId  => "GarminConnect",
    consumeServiceTicket => "false",
  );
  my $uri = URI->new($self->{loginurl});
  $uri->query_form(%params);
  my $response = $ua->get($uri);
  croak "Can't retrieve login page: " . $response->status_line
    unless $response->is_success;

  # Get sso ticket
  $uri = URI->new("https://sso.garmin.com/sso/login");
  $uri->query_form(%params);
  $response = $ua->post($uri, origin => 'https://sso.garmin.com',
    content => {
      username => $self->{username},
      password => $self->{password},
      _eventId => "submit",
      embed    => "true",
  });
  croak "Can't retrieve sso page: " . $response->status_line
    unless $response->is_success;
  if ($response->content =~ />sendEvent\('FAIL'\)/) {
    croak "invalid login";
  }
  if ($response->content =~ />sendEvent\('ACCOUNT_LOCKED'\)/) {
    croak "account locked";
  }
  if ($response->content =~ /renewPassword/) {
    croak "renew password";
  }
  if ($response->content !~ /\?ticket=([^"]+)"/) {
    croak "no service ticket in response";
  }
  my $ticket=$1;

  #$uri = URI->new('https://connect.garmin.com/post-auth/login?ticket=$1');
  $uri = URI->new("https://connect.garmin.com/modern/?ticket=$ticket");
  $response = $ua->get($uri);
  croak "Can't retrieve post-auth page: " . $response->status_line
    unless $response->is_success;

  # Record our logged-in status so future calls will skip login.
  $self->{useragent} = $ua;
  $self->{is_logged_in} = 1;
}

=head2 activities( %search_criteria )

Returns a list of activities matching the requested criteria. If no criteria
are specified, returns all the user's activities. Possible criteria:

=over

=item limit

(Optional) The maximum number of activities to return. If not specified,
all the user's activities will be returned.

=item pagesize

(Optional) The number of activities to return in each call to Garmin
Connect. (One call to this subroutine may call Garmin Connect several
times to retrieve all the requested activities.) Defaults to 50.

=back

=cut

sub activities {
  my $self = shift;
  my %opts = @_;
  my $json = JSON->new();

  # Ensure we are logged in
  $self->_login();
  my $ua = $self->{useragent};

  # We can only fetch a fixed number of activities at a time.
  my @activities;
  my $start = 0;
  my $pagesize = 50;
  if( defined $opts{pagesize} ) {
    if( $opts{pagesize} > 0 && $opts{pagesize} < 50 ) {
      $pagesize = $opts{pagesize};
    }
  }

  # Special case when the limit is smaller than one page.
  if( defined $opts{limit} ) {
    if( $opts{limit} < $pagesize ) {
      $pagesize = $opts{limit};
    }
  }

  my $data = [];
  do {
    # Make a search request
    my $searchurl = $self->{searchurl} .
      "?start=$start&limit=$pagesize";

    my $headers = [
      'NK' => 'NT',
    ];
    my $request = HTTP::Request->new('GET', $searchurl, $headers);
    my $response = $ua->request($request);
    croak "Can't make search request: " . $response->status_line
      unless $response->is_success;

    # Parse the JSON search results
    $data = $json->decode($response->content);

    # Add this set of activities to the list.
    foreach my $activity ( @{$data} ) {
      if( defined $opts{limit} ) {
        # add this activity only if we're under the limit
        if( @activities < $opts{limit} ) {
          push @activities, { activity => $activity };
        } else {
          $data = []; # stop retrieving more activities
          last;
	}
      } else {
        push @activities, { activity => $activity };
      }
    }

    # Increment the start offset for the next request.
    $start += $pagesize;

  } while( @{$data} > 0 );

  return @activities;
}

=head1 AUTHOR

Joel Loudermilk, C<< <joel at loudermilk.org> >>

=head1 BUGS

Please report any bugs or feature requests to L<https://github.com/jlouder/garmin-connect-perl/issues>.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::GarminConnect


You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService-GarminConnect>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService-GarminConnect>

=item * Search CPAN

L<http://search.cpan.org/dist/WebService-GarminConnect>

=item * GitHub Repository

L<https://github.com/jlouder/garmin-connect-perl>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2015 Joel Loudermilk.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see L<http://www.gnu.org/licenses/>.

=cut

1; # End of WebService::GarminConnect
