#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::Sk, 'Can use locale file Locale::CLDR::Locales::Sk';
use ok Locale::CLDR::Locales::Sk::Any::Sk, 'Can use locale file Locale::CLDR::Locales::Sk::Any::Sk';
use ok Locale::CLDR::Locales::Sk::Any, 'Can use locale file Locale::CLDR::Locales::Sk::Any';

done_testing();
