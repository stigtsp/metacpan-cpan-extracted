#!/usr/bin/perl

use v5.14;
use warnings;

use Test::More;

package TestParser {
   use base qw( Parser::MGC );

   sub parse
   {
      my $self = shift;

      my @tokens;
      push @tokens, $self->expect( qr/[a-z]+/ ) while !$self->at_eos;

      return \@tokens;
   }
}

my $parser = TestParser->new;

my @strings = (
   "here is a list ",
   "of some more ",
   "tokens"
);

is_deeply( $parser->from_reader( sub { return shift @strings } ),
   [qw( here is a list of some more tokens )],
   'tokens from reader' );

done_testing;
