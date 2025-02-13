#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::Ml, 'Can use locale file Locale::CLDR::Locales::Ml';
use ok Locale::CLDR::Locales::Ml::Any::In, 'Can use locale file Locale::CLDR::Locales::Ml::Any::In';
use ok Locale::CLDR::Locales::Ml::Any, 'Can use locale file Locale::CLDR::Locales::Ml::Any';

done_testing();
