use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/List/SomeUtils/XS.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/Functions.t',
    't/Import.t',
    't/ab.t',
    't/lib/LSU/Test/Functions.pm',
    't/lib/LSU/Test/Import.pm',
    't/lib/LSU/Test/XS.pm',
    't/lib/LSU/Test/ab.pm',
    't/lib/Test/LSU.pm',
    't/xs-only.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
