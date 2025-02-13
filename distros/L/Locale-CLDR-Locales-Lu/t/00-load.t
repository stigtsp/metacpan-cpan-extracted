#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::Lu, 'Can use locale file Locale::CLDR::Locales::Lu';
use ok Locale::CLDR::Locales::Lu::Any::Cd, 'Can use locale file Locale::CLDR::Locales::Lu::Any::Cd';
use ok Locale::CLDR::Locales::Lu::Any, 'Can use locale file Locale::CLDR::Locales::Lu::Any';

done_testing();
