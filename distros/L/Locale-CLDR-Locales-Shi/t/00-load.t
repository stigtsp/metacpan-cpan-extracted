#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::Shi, 'Can use locale file Locale::CLDR::Locales::Shi';
use ok Locale::CLDR::Locales::Shi::Tfng, 'Can use locale file Locale::CLDR::Locales::Shi::Tfng';
use ok Locale::CLDR::Locales::Shi::Latn, 'Can use locale file Locale::CLDR::Locales::Shi::Latn';
use ok Locale::CLDR::Locales::Shi::Latn::Ma, 'Can use locale file Locale::CLDR::Locales::Shi::Latn::Ma';
use ok Locale::CLDR::Locales::Shi::Tfng::Ma, 'Can use locale file Locale::CLDR::Locales::Shi::Tfng::Ma';

done_testing();
