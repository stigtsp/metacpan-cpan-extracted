#!/usr/bin/perl

use strict;
use warnings;

use Acme::Text::Rhombus ':all';
use Test::More tests => 5;

my $rhombus0 = rhombus();

my $rhombus1 = rhombus_letter(
    lines   =>      31,
    letter  =>     'c',
    case    => 'upper',
    fillup  =>     '+',
    forward =>       1,
);
my $rhombus2 = rhombus_letter(
    lines   =>      15,
    letter  =>     'c',
    case    => 'lower',
    fillup  =>     '*',
    forward =>       0,
);
my $rhombus3 = rhombus_digit(
    lines   =>  31,
    digit   =>   3,
    fillup  => '+',
    forward =>   1,
);
my $rhombus4 = rhombus_digit(
    lines   =>  15,
    digit   =>   3,
    fillup  => '*',
    forward =>   0,
);

my @rhombuses = split /###\n/, do { local $/; <DATA> };

is($rhombus0, $rhombuses[0], 'rhombus()');
is($rhombus1, $rhombuses[1], 'rhombus_letter()');
is($rhombus2, $rhombuses[2], 'rhombus_letter()');
is($rhombus3, $rhombuses[3], 'rhombus_digit()');
is($rhombus4, $rhombuses[4], 'rhombus_digit()');

__DATA__
++++++++++++A++++++++++++
+++++++++++BBB+++++++++++
++++++++++CCCCC++++++++++
+++++++++DDDDDDD+++++++++
++++++++EEEEEEEEE++++++++
+++++++FFFFFFFFFFF+++++++
++++++GGGGGGGGGGGGG++++++
+++++HHHHHHHHHHHHHHH+++++
++++IIIIIIIIIIIIIIIII++++
+++JJJJJJJJJJJJJJJJJJJ+++
++KKKKKKKKKKKKKKKKKKKKK++
+LLLLLLLLLLLLLLLLLLLLLLL+
MMMMMMMMMMMMMMMMMMMMMMMMM
+NNNNNNNNNNNNNNNNNNNNNNN+
++OOOOOOOOOOOOOOOOOOOOO++
+++PPPPPPPPPPPPPPPPPPP+++
++++QQQQQQQQQQQQQQQQQ++++
+++++RRRRRRRRRRRRRRR+++++
++++++SSSSSSSSSSSSS++++++
+++++++TTTTTTTTTTT+++++++
++++++++UUUUUUUUU++++++++
+++++++++VVVVVVV+++++++++
++++++++++WWWWW++++++++++
+++++++++++XXX+++++++++++
++++++++++++Y++++++++++++
###
+++++++++++++++C+++++++++++++++
++++++++++++++DDD++++++++++++++
+++++++++++++EEEEE+++++++++++++
++++++++++++FFFFFFF++++++++++++
+++++++++++GGGGGGGGG+++++++++++
++++++++++HHHHHHHHHHH++++++++++
+++++++++IIIIIIIIIIIII+++++++++
++++++++JJJJJJJJJJJJJJJ++++++++
+++++++KKKKKKKKKKKKKKKKK+++++++
++++++LLLLLLLLLLLLLLLLLLL++++++
+++++MMMMMMMMMMMMMMMMMMMMM+++++
++++NNNNNNNNNNNNNNNNNNNNNNN++++
+++OOOOOOOOOOOOOOOOOOOOOOOOO+++
++PPPPPPPPPPPPPPPPPPPPPPPPPPP++
+QQQQQQQQQQQQQQQQQQQQQQQQQQQQQ+
RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
+SSSSSSSSSSSSSSSSSSSSSSSSSSSSS+
++TTTTTTTTTTTTTTTTTTTTTTTTTTT++
+++UUUUUUUUUUUUUUUUUUUUUUUUU+++
++++VVVVVVVVVVVVVVVVVVVVVVV++++
+++++WWWWWWWWWWWWWWWWWWWWW+++++
++++++XXXXXXXXXXXXXXXXXXX++++++
+++++++YYYYYYYYYYYYYYYYY+++++++
++++++++ZZZZZZZZZZZZZZZ++++++++
+++++++++AAAAAAAAAAAAA+++++++++
++++++++++BBBBBBBBBBB++++++++++
+++++++++++CCCCCCCCC+++++++++++
++++++++++++DDDDDDD++++++++++++
+++++++++++++EEEEE+++++++++++++
++++++++++++++FFF++++++++++++++
+++++++++++++++G+++++++++++++++
###
*******c*******
******bbb******
*****aaaaa*****
****zzzzzzz****
***yyyyyyyyy***
**xxxxxxxxxxx**
*wwwwwwwwwwwww*
vvvvvvvvvvvvvvv
*uuuuuuuuuuuuu*
**ttttttttttt**
***sssssssss***
****rrrrrrr****
*****qqqqq*****
******ppp******
*******o*******
###
+++++++++++++++3+++++++++++++++
++++++++++++++444++++++++++++++
+++++++++++++55555+++++++++++++
++++++++++++6666666++++++++++++
+++++++++++777777777+++++++++++
++++++++++88888888888++++++++++
+++++++++9999999999999+++++++++
++++++++000000000000000++++++++
+++++++11111111111111111+++++++
++++++2222222222222222222++++++
+++++333333333333333333333+++++
++++44444444444444444444444++++
+++5555555555555555555555555+++
++666666666666666666666666666++
+77777777777777777777777777777+
8888888888888888888888888888888
+99999999999999999999999999999+
++000000000000000000000000000++
+++1111111111111111111111111+++
++++22222222222222222222222++++
+++++333333333333333333333+++++
++++++4444444444444444444++++++
+++++++55555555555555555+++++++
++++++++666666666666666++++++++
+++++++++7777777777777+++++++++
++++++++++88888888888++++++++++
+++++++++++999999999+++++++++++
++++++++++++0000000++++++++++++
+++++++++++++11111+++++++++++++
++++++++++++++222++++++++++++++
+++++++++++++++3+++++++++++++++
###
*******3*******
******222******
*****11111*****
****0000000****
***999999999***
**88888888888**
*7777777777777*
666666666666666
*5555555555555*
**44444444444**
***333333333***
****2222222****
*****11111*****
******000******
*******9*******
