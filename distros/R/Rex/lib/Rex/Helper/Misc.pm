#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Helper::Misc;

use 5.010001;
use strict;
use warnings;

our $VERSION = '1.13.4'; # VERSION

sub get_random {
  my $count = shift;
  my @chars = @_;

  my $ret = "";
  for ( 1 .. $count ) {
    $ret .= $chars[ int( rand( scalar(@chars) - 1 ) ) ];
  }

  return $ret;
}

1;
