use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'bin/parse-syslog-line.pl',
    'lib/Parse/Syslog/Line.pm',
    't/00-compile.t',
    't/00-load.t',
    't/01-parse.t',
    't/02-functions.t',
    't/03-datetime-calculations.t',
    't/bin/create_test_entry.pl',
    't/data/064eaadcacdcfe59b91cf280f1a25bc9.yaml',
    't/data/0cf67252f51bc98c6302cf2d11832db2.yaml',
    't/data/0e03a69469bdfe47db4dff53681ae434.yaml',
    't/data/21a3db207b78320769f2cb316dd03f60.yaml',
    't/data/2e86b433376740f804c3339840271863.yaml',
    't/data/3a7ef75494efe41176b9d57a06517a54.yaml',
    't/data/3ca7dfaa06c1fd7138e9d7fd75ca49e7.yaml',
    't/data/40688f8e14cf650c369aec8a86e43e96.yaml',
    't/data/4209c3f669b2a1ae81a0db4e8f4c5dd5.yaml',
    't/data/4bab0b1bd6e18f35fcee6fecf1522030.yaml',
    't/data/67b8ab574fc3a9a9fd6a0bdaf1231b14.yaml',
    't/data/6f833459bced8cdc42950602d7798680.yaml',
    't/data/7af843bd9c3dad1a054d79ac3f3589c3.yaml',
    't/data/83fa7359bc8057bac3f2c4acc452740d.yaml',
    't/data/86a4626fee7782296c09fa39a08ff2d1.yaml',
    't/data/8e44959d30eba57a6feb950e286c977b.yaml',
    't/data/8f4e966ac5cadf8171739d472b814c61.yaml',
    't/data/90b344da741283aed6558f915732b421.yaml',
    't/data/90ff8b49f7fe0526b986d116f4e0c43f.yaml',
    't/data/a3f74b54b664d2f0903f2cb8a110b4cd.yaml',
    't/data/adb23949c66b74145bc0f8084e7307a1.yaml',
    't/data/bb8856f6a2f36d1ff8f747b8f280b3a6.yaml',
    't/data/c06ac2c4540f4e87bd5bb3c70ac39cb0.yaml',
    't/data/c1352d43776bbf2acfb45344101cd74b.yaml',
    't/data/e86919071a958d4f24bc13751c2cab47.yaml',
    't/data/f94cae02dd7ef975df7bfd365109690c.yaml'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
