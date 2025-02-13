#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::Ii, 'Can use locale file Locale::CLDR::Locales::Ii';
use ok Locale::CLDR::Locales::Ii::Any::Cn, 'Can use locale file Locale::CLDR::Locales::Ii::Any::Cn';
use ok Locale::CLDR::Locales::Ii::Any, 'Can use locale file Locale::CLDR::Locales::Ii::Any';

done_testing();
