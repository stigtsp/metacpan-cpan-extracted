=encoding utf8

=head1

Locale::CLDR::Locales::Sw::Any::Ug - Package for language Swahili

=cut

package Locale::CLDR::Locales::Sw::Any::Ug;
# This file auto generated from Data/common/main/sw_UG.xml
#	on Mon 11 Apr  5:38:59 pm GMT

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

extends('Locale::CLDR::Locales::Sw::Any');
has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'UGX' => {
			symbol => 'USh',
		},
	} },
);


no Moo;

1;

# vim: tabstop=4
