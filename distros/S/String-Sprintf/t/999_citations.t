use strict;

use Test::More;

my $file = 'CITATION.cff';

SKIP: {
	my $rc = eval { require YAML; 1 };
	skip 'Need YAML to test CITATIONS.cff', 1 unless $rc;

	subtest citations => sub {
		ok( -e $file, "$file exists" );
		my $data = eval { YAML::LoadFile( $file ) };
		my $error = $@;
		ok( defined $data, "Loaded data from $file" ) or diag( "Error loading $file: $@" );
		};
	}

done_testing;
