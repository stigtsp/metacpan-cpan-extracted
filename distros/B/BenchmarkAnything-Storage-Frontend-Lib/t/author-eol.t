
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    print qq{1..0 # SKIP these tests are for testing by the author\n};
    exit
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.18

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/BenchmarkAnything/Storage/Frontend/Lib.pm',
    't/00-compile.t',
    't/author-eol.t',
    't/author-no-tabs.t',
    't/author-pod-syntax.t',
    't/benchmarkanything-2.cfg',
    't/benchmarkanything-3.cfg',
    't/benchmarkanything-mysql.cfg',
    't/benchmarkanything.cfg',
    't/cfg.t',
    't/lib.t',
    't/query-benchmark-anything-01-expectedresult.json',
    't/query-benchmark-anything-01.json',
    't/query-benchmark-anything-02-expectedresult.json',
    't/query-benchmark-anything-02.json',
    't/query-benchmark-anything-03-expectedresult.json',
    't/query-benchmark-anything-03.json',
    't/query-benchmark-anything-04-expectedresult.json',
    't/query-benchmark-anything-04.json',
    't/release-pod-coverage.t',
    't/valid-benchmark-anything-data-01.json',
    't/valid-benchmark-anything-data-02.json'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
