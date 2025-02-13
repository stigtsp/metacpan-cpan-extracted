use warnings;
use strict;

BEGIN {
	if("$]" < 5.011) {
		require Test::More;
		Test::More::plan(skip_all => "no array keys on this Perl");
	}
}

use Test::More tests => 8;

our @t;

use Array::Base +3;

@t = ();
is_deeply [ scalar keys @t ], [ 0 ];
is_deeply [ keys @t ], [];

@t = qw(a b c d e f);
is_deeply [ scalar keys @t ], [ 6 ];
is_deeply [ keys @t ], [ 3, 4, 5, 6, 7, 8 ];

SKIP: {
	skip "no lexical \$_ on this perl", 4
		if "$]" < 5.009001 || "$]" >= 5.023004;
	eval q{
		no warnings "$]" >= 5.017009 ? "experimental" :
						"deprecated";
		my $_;

		@t = ();
		is_deeply [ scalar keys @t ], [ 0 ];
		is_deeply [ keys @t ], [];

		@t = qw(a b c d e f);
		is_deeply [ scalar keys @t ], [ 6 ];
		is_deeply [ keys @t ], [ 3, 4, 5, 6, 7, 8 ];
	};
}

1;
