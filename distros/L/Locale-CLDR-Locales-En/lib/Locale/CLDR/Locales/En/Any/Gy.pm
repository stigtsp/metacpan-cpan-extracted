=encoding utf8

=head1

Locale::CLDR::Locales::En::Any::Gy - Package for language English

=cut

package Locale::CLDR::Locales::En::Any::Gy;
# This file auto generated from Data/common/main/en_GY.xml
#	on Mon 11 Apr  5:27:04 pm GMT

use strict;
use warnings;
use version;

our $VERSION = version->declare('v0.34.1');

use v5.10.1;
use mro 'c3';
use utf8;
use if $^V ge v5.12.0, feature => 'unicode_strings';
use Types::Standard qw( Str Int HashRef ArrayRef CodeRef RegexpRef );
use Moo;

extends('Locale::CLDR::Locales::En::Any::001');
has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'GYD' => {
			symbol => '$',
		},
	} },
);


has 'time_zone_names' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default	=> sub { {
		'Guyana' => {
			short => {
				'standard' => q#GYT#,
			},
		},
	 } }
);
no Moo;

1;

# vim: tabstop=4
