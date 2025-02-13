use lib "t/testlib";
use TestAuto;

use strict;
use warnings;

use Test::More;

use SPVM 'TestCase::Allow';



# Start objects count
my $start_memory_blocks_count = SPVM::get_memory_blocks_count();

# Array
{
  ok(SPVM::TestCase::Allow->allow_test);
}

# All object is freed
my $end_memory_blocks_count = SPVM::get_memory_blocks_count();
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;
