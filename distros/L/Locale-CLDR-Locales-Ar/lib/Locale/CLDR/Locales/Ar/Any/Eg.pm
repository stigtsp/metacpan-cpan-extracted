=encoding utf8

=head1

Locale::CLDR::Locales::Ar::Any::Eg - Package for language Arabic

=cut

package Locale::CLDR::Locales::Ar::Any::Eg;
# This file auto generated from Data/common/main/ar_EG.xml
#	on Mon 11 Apr  5:23:37 pm GMT

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

extends('Locale::CLDR::Locales::Ar::Any');
has 'display_name_language' => (
	is			=> 'ro',
	isa			=> CodeRef,
	init_arg	=> undef,
	default		=> sub { 
		 sub {
			 my %languages = (
				'da' => 'الدنماركية',

			);
			if (@_) {
				return $languages{$_[0]};
			}
			return \%languages;
		}
	},
);

has 'default_numbering_system' => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> 'arab',
);

no Moo;

1;

# vim: tabstop=4
