package Locale::CLDR::Transformations::Any::Beng::Ur;
# This file auto generated from Data/common/transforms/Bengali-ur.xml
#	on Mon 11 Apr  5:22:55 pm GMT

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

BEGIN {
	die "Transliteration requires Perl 5.18 or above"
		unless $^V ge v5.18.0;
}

no warnings 'experimental::regex_sets';
has 'transforms' => (
	is => 'ro',
	isa => ArrayRef,
	init_arg => undef,
	default => sub { [
		qr/(?^umi:\G[।-॥ঁ-ঃঅ-ঌএ-ঐও-নপ-রলশ-হ়-ৄে-ৈো-্ৗড়-ঢ়য়-ৣ০-৺ৎ])/,
		{
			type => 'transform',
			data => [
				{
					from => q(Any),
					to => q(NFD),
				},
				{
					from => q(Bengali),
					to => q(InterIndic),
				},
				{
					from => q(InterIndic),
					to => q(ur),
				},
				{
					from => q(Any),
					to => q(NFC),
				},
			]
		},
	] },
);

no Moo;

1;

# vim: tabstop=4
