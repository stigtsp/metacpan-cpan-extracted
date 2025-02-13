=encoding utf8

=head1

Locale::CLDR::Locales::Ff::Latn::Ng - Package for language Fulah

=cut

package Locale::CLDR::Locales::Ff::Latn::Ng;
# This file auto generated from Data/common/main/ff_Latn_NG.xml
#	on Mon 11 Apr  5:27:54 pm GMT

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

extends('Locale::CLDR::Locales::Ff::Latn');
has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'NGN' => {
			symbol => '₦',
		},
	} },
);


no Moo;

1;

# vim: tabstop=4
