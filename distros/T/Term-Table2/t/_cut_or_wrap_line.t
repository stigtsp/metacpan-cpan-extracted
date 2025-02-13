#!/usr/bin/env perl

use v5.14;
use warnings FATAL => qw(all);

package Term::Table2;

use Test2::V0 -target => 'Term::Table2';

my $table = bless({'table_width' => 5}, $CLASS);

$table->{':split_offset'} = 2;
$table->{'broad_row'}     = WRAP;
is([$table->_cut_or_wrap_line('0123456789')], ['23456', '789'],
   'Non-zero offset, line is too long and must be wrapped');

$table->{':split_offset'} = 0;
$table->{'broad_row'}     = CUT;
is([$table->_cut_or_wrap_line('0123456789')], ['01234'],
   'Non-zero offset, line is too long and must be cut off');

$table->{':split_offset'} = 0;
$table->{'broad_row'}     = WRAP;
is([$table->_cut_or_wrap_line('012')],        ['012'],
   'Non-zero offset, line is not too long');

done_testing();