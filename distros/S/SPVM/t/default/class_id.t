use lib "t/testlib";
use TestAuto;

use strict;
use warnings;

use Test::More;

use SPVM 'TestCase::ClassId';

# Start objects count
my $start_memory_blocks_count = SPVM::get_memory_blocks_count();

# Local variable
{
  ok(SPVM::TestCase::ClassId->basic);
}

# All object is freed
my $end_memory_blocks_count = SPVM::get_memory_blocks_count();
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;
