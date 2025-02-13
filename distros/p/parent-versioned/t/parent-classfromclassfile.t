#!/usr/bin/perl -w

use strict;
use Test::More tests => 3;
use lib 't/lib';

use_ok('parent::versioned');

# Tests that a bare (non-double-colon) class still loads
# and does not get treated as a file:
eval q{package Test1; require Dummy; use parent::versioned -norequire, 'Dummy::InlineChild'; };
is $@, '', "Loading an unadorned class works";
isn't $INC{"Dummy.pm"}, undef, 'We loaded Dummy.pm';
