use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Page::End;
use Test::More 'tests' => 5;
use Test::NoWarnings;
use Tags::Output::Raw;

# Test.
my $obj = Tags::HTML::Page::End->new;
isa_ok($obj, 'Tags::HTML::Page::End');

# Test.
$obj = Tags::HTML::Page::End->new(
	'tags' => Tags::Output::Raw->new,
);
isa_ok($obj, 'Tags::HTML::Page::End');

# Test.
eval {
	Tags::HTML::Page::End->new(
		'tags' => 'foo',
	);
};
is(
	$EVAL_ERROR,
	"Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Missing required parameter 'tags'.",
);
clean();

# Test.
eval {
	Tags::HTML::Page::End->new(
		'tags' => Tags::HTML::Page::End->new(
			'tags' => Tags::Output::Raw->new,
		),
	);
};
is(
	$EVAL_ERROR,
	"Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Bad 'Tags::Output' instance.",
);
clean();
