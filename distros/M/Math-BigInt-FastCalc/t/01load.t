# -*- mode: perl; -*-

use strict;             # restrict unsafe constructs
use warnings;           # enable optional warnings

use Test::More tests => 2;

BEGIN {
    use_ok('Math::BigInt');
    use_ok('Math::BigInt::FastCalc');
};

my @mods = ('Math::BigInt',
            'Math::BigInt::Calc',
            'Math::BigInt::FastCalc',
            );

diag("");
diag("Testing with Perl $], $^X");
diag("");
diag(sprintf("%12s %s\n", 'Version', 'Module'));
diag(sprintf("%12s %s\n", '-------', '------'));
for my $mod (@mods) {
    my $ver = $mod -> VERSION();
    my $str = defined($ver) ? $ver : 'undef';
    diag(sprintf("%12s %s\n", $str, $mod));
}
diag("");
