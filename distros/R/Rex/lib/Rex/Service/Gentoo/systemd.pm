#
# Gentoo systemd support
#

package Rex::Service::Gentoo::systemd;

use 5.010001;
use strict;
use warnings;

our $VERSION = '1.13.4'; # VERSION

use Rex::Service::Redhat::systemd;
use base qw(Rex::Service::Redhat::systemd);

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = $proto->SUPER::new(@_);

  bless( $self, $proto );

  return $self;
}

1;
