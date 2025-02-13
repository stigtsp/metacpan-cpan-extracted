use strict;
use warnings;

use Test::More;
use SMS::Send;

my @drivers = SMS::Send->installed_drivers;

ok ( scalar (@drivers) >= 1, 'Found at least 1 driver' );
ok ( scalar (grep { $_ eq 'CZ::Bulkgate' } @drivers ) == 1, 'Found "CZ::Bulkgate" driver' );

done_testing;