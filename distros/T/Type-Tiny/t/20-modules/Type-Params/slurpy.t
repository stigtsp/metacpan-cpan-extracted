=pod

=encoding utf-8

=head1 PURPOSE

Test L<Type::Params> usage with slurpy parameters.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013-2014, 2017-2022 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

use strict;
use warnings;

use Test::More;
use Test::Fatal;

use Type::Params qw(compile);
use Types::Standard -types, "slurpy";

my $chk = compile(Str, slurpy HashRef[Int]);

is_deeply(
	[ $chk->("Hello", foo => 1, bar => 2) ],
	[ "Hello", { foo => 1, bar => 2 } ]
);

is_deeply(
	[ $chk->("Hello", { foo => 1, bar => 2 }) ],
	[ "Hello", { foo => 1, bar => 2 } ]
);

like(
	exception { $chk->("Hello", foo => 1, bar => 2.1) },
	qr{did not pass type constraint "HashRef\[Int\]" \(in \$SLURPY\)},
);

my $chk2 = compile(Str, slurpy HashRef);

is_deeply(
	[ $chk2->("Hello", foo => 1, bar => 2) ],
	[ "Hello", { foo => 1, bar => 2 } ]
);

is_deeply(
	[ $chk2->("Hello", { foo => 1, bar => 2 }) ],
	[ "Hello", { foo => 1, bar => 2 } ]
);

like(
	exception { $chk2->("Hello", foo => 1, "bar") },
	qr{^Odd number of elements in HashRef},
);

my $chk3 = compile(Str, slurpy Map);

like(
	exception { $chk3->("Hello", foo => 1, "bar") },
	qr{^Odd number of elements in Map},
);

my $chk4 = compile(Str, slurpy Tuple[Str, Int, Str]);

is_deeply(
	[ $chk4->("Hello", foo => 1, "bar") ],
	[ Hello => [qw/ foo 1 bar /] ],
);


{
	my $check;
	sub xyz {
		$check ||= compile( Int, Slurpy[HashRef] );
		my ($num, $hr) = $check->(@_);
		return [ $num, $hr ];
	}
	
	is_deeply( xyz( 5,   foo => 1, bar => 2   ), [ 5, { foo => 1, bar => 2 } ] );
	is_deeply( xyz( 5, { foo => 1, bar => 2 } ), [ 5, { foo => 1, bar => 2 } ] );
}

note compile( { want_source => 1 }, Int, Slurpy[HashRef] );

{
	my $check;
	sub xyz2 {
		$check ||= compile( Int, HashRef, { slurpy => 1 } );
		my ($num, $hr) = $check->(@_);
		return [ $num, $hr ];
	}
	
	is_deeply( xyz2( 5,   foo => 1, bar => 2   ), [ 5, { foo => 1, bar => 2 } ] );
	is_deeply( xyz2( 5, { foo => 1, bar => 2 } ), [ 5, { foo => 1, bar => 2 } ] );
}

{
	my $check;
	sub xyz3 {
		$check ||= compile( Int, HashRef, { slurpy => 1 } );
		my ($num, $hr) = $check->(@_);
		return [ $num, $hr ];
	}
	
	is_deeply( xyz3( 5,   foo => 1, bar => 2   ), [ 5, { foo => 1, bar => 2 } ] );
	is_deeply( xyz3( 5, { foo => 1, bar => 2 } ), [ 5, { foo => 1, bar => 2 } ] );
}

{
	my $check;
	sub xyz4 {
		$check ||= compile( Int, ( Slurpy[HashRef] )->where( '1' ) );
		my ($num, $hr) = $check->(@_);
		return [ $num, $hr ];
	}
	
	is_deeply( xyz4( 5,   foo => 1, bar => 2   ), [ 5, { foo => 1, bar => 2 } ] );
	is_deeply( xyz4( 5, { foo => 1, bar => 2 } ), [ 5, { foo => 1, bar => 2 } ] );
}

note compile( { want_source => 1 }, Int, HashRef, { slurpy => 1 } );

done_testing;

