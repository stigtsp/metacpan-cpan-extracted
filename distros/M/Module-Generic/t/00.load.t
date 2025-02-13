# -*- perl -*-
BEGIN
{
    use strict;
    use lib './lib';
    use Test::More qw( no_plan );
    use File::Find;
    our @modules;
    File::Find::find(sub
    {
        next unless( /\.pm$/ );
        # print( "Checking file '$_' ($File::Find::name)\n" );
        $_ = $File::Find::name;
        s,^./lib/,,;
        s,\.pm$,,;
        s,/,::,g;
        push( @modules, $_ );
    }, qw( ./lib ) );
    our $DEBUG = exists( $ENV{AUTHOR_TESTING} ) ? $ENV{AUTHOR_TESTING} : 0;
};

BEGIN
{
    diag( "Checking module $_" ) if( $DEBUG );
    use_ok( $_ ) for( sort( @modules ) );
};

done_testing();

# To generate the list of modules:
# find ./lib -type f -name "*.pm" -print | xargs perl -lE 'my @f=sort(@ARGV); for(@f) { s,./lib/,,; s,\.pm$,,; s,/,::,g; substr( $_, 0, 0, q{use_ok( ''} ); $_ .= q{'' );}; say $_; }'
