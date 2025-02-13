#!/usr/bin/env perl
# -*- cperl; cperl-indent-level: 4 -*-
# Copyright (C) 2021, Roland van Ipenburg
use strict;
use warnings;
use utf8;
use 5.014000;

use Test::More;
use Test::NoWarnings;

our $VERSION = 'v1.0.4';

my @metars = (
## no critic (ProhibitMagicNumbers)
    [
        'KFDY 251450Z 21012G21KT 8SM OVC065 04/M01 A3010 RMK 57014',
        8, 'Visibility of 8SM is 8',
    ],
    [
        'KFDY 251450Z 21012G21KT 3/4SM OVC065 04/M01 A3010 RMK 57014',
        .75, 'Visibility of 3/4SM is 0.75',
    ],
    [
        'KFDY 251450Z 21012G21KT 1 1/4SM OVC065 04/M01 A3010 RMK 57014',
        1.25, 'Visibility of 1 1/4SM is 1.25',
    ],
## use critic
);

Test::More::plan 'tests' => ( 0 + @metars ) + 1;

require Geo::METAR::Deduced;
my $m = Geo::METAR::Deduced->new();
foreach my $metar (@metars) {
    $m->metar( @{$metar}[0] );
    Test::More::is( $m->visibility()->mile(), @{$metar}[1], @{$metar}[2] );
}
