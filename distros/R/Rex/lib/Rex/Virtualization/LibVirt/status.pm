#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Virtualization::LibVirt::status;

use 5.010001;
use strict;
use warnings;

our $VERSION = '1.13.4'; # VERSION

use Rex::Virtualization::LibVirt::info;

sub execute {
  my ( $class, $arg1, %opt ) = @_;

  my $info = Rex::Virtualization::LibVirt::info->execute($arg1);
  if ( $info->{State} eq "shut off" ) {
    return "stopped";
  }

  return "running";
}

1;
