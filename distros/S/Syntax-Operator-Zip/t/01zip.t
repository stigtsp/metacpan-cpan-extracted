#!/usr/bin/perl

use v5.14;
use warnings;

use Test::More;

use Syntax::Operator::Zip;
BEGIN { plan skip_all => "No PL_infix_plugin" unless XS::Parse::Infix::HAVE_PL_INFIX_PLUGIN; }

# List literals
is_deeply( [ qw( one two three ) Z ( 1 .. 3 ) ],
   [ [ one => 1 ], [ two => 2 ], [ three => 3 ] ],
   'basic zip' );

is_deeply( [ qw( one two ) Z ( 1 .. 3 ) ],
   [ [ one => 1 ], [ two => 2 ], [ undef, 3 ] ],
   'zip fills in blanks of LHS' );
is_deeply( [ qw( one two three ) Z ( 1 .. 2 ) ],
   [ [ one => 1 ], [ two => 2 ], [ three => undef ] ],
   'zip fills in blanks of RHS' );

# Counts in scalar context
{
   my $count = (1..3) Z (4..6);
   is( $count, 3, 'zip counts in scalar context' );

   is( scalar( ('a'..'f') Z ('Z') ), 6, 'zip counts longest list on LHS' );
   is( scalar( ('z') Z ('A'..'F') ), 6, 'zip counts longest list on RHS' );
}

# Returned values are copies, not aliases
{
   my @n = (1..3);
   $_->[0]++ for @n Z ("x")x3;
   is_deeply( \@n, [1..3], 'zip returns copies of arguments' );
}

done_testing;
