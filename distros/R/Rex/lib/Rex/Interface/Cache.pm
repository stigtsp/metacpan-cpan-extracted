#
# (c) Jan Gehring <jan.gehring@gmail.com>
#
# vim: set ts=2 sw=2 tw=0:
# vim: set expandtab:

package Rex::Interface::Cache;

use 5.010001;
use strict;
use warnings;

our $VERSION = '1.13.4'; # VERSION

sub create {
  my ( $class, $type ) = @_;

  unless ($type) {
    $type = Rex::Config->get_cache_type;
  }

  my $class_name = "Rex::Interface::Cache::$type";
  eval "use $class_name;";
  if ($@) { die("Error loading connection interface $type.\n$@"); }

  return $class_name->new;
}

1;
