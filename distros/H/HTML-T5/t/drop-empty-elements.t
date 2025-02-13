#!perl -T

BEGIN
{
    $ENV{LC_ALL} = 'C';

    # See: https://github.com/shlomif/html-tidy5/issues/6
    $ENV{LANG} = 'en_US.UTF-8';
};


use 5.010001;
use warnings;
use strict;

use Test::More skip_all => "failure in recent libtidy 5";

use HTML::T5;

use lib 't';

use TidyTestUtils;

my $html = <<'HTML';
<!DOCTYPE html>
<html>
    <head>
        <title></title>
    </head>
    <body>
        <span class="empty"></span>
    </body>
</html>
HTML

subtest 'default constructor warns about empty spans' => sub {
    plan tests => 2;

    my $tidy = HTML::T5->new;
    isa_ok( $tidy, 'HTML::T5' );
    $tidy->parse( 'test', $html );

    messages_are( $tidy,
        [ 'test (7:9) Warning: trimming empty <span>' ],
    );
};

subtest 'drop_empty_elements => 1 gives message' => sub {
    plan tests => 2;

    my $tidy = HTML::T5->new( { drop_empty_elements => 1 } );
    isa_ok( $tidy, 'HTML::T5' );
    $tidy->parse( 'test', $html );

    messages_are( $tidy,
        [ 'test (7:9) Warning: trimming empty <span>' ],
    );
};

subtest 'drop_empty_elements => 0 gives no messages' => sub {
    plan tests => 2;

    my $tidy = HTML::T5->new( { drop_empty_elements => 0 } );
    isa_ok( $tidy, 'HTML::T5' );
    $tidy->parse( 'test', $html );

    messages_are( $tidy, [] );
};

exit 0;
