package Sah::Schema::nonnegint;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-07-16'; # DATE
our $DIST = 'Sah-Schemas-Int'; # DIST
our $VERSION = '0.076'; # VERSION

our $schema = [int => {
    summary   => 'Non-negative integer (0, 1, 2, ...) [DEPRECATED]',
    min       => 0,
   description => <<'_',

This schema is DEPRECATED. Please use the new name `uint`.

See also `posint` for integers that start from 1.

_
    examples => [
        {data=>0 , valid=>1},
        {data=>1 , valid=>1},
        {data=>-1, valid=>0},
    ],
 }, {}];

1;
# ABSTRACT: Non-negative integer (0, 1, 2, ...) [DEPRECATED]

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::nonnegint - Non-negative integer (0, 1, 2, ...) [DEPRECATED]

=head1 VERSION

This document describes version 0.076 of Sah::Schema::nonnegint (from Perl distribution Sah-Schemas-Int), released on 2021-07-16.

=head1 SYNOPSIS

To check data against this schema (requires L<Data::Sah>):

 use Data::Sah qw(gen_validator);
 my $validator = gen_validator("nonnegint*");
 say $validator->($data) ? "valid" : "INVALID!";

 # Data::Sah can also create validator that returns nice error message string
 # and/or coerced value. Data::Sah can even create validator that targets other
 # language, like JavaScript. All from the same schema. See its documentation
 # for more details.

To validate function parameters against this schema (requires L<Params::Sah>):

 use Params::Sah qw(gen_validator);

 sub myfunc {
     my @args = @_;
     state $validator = gen_validator("nonnegint*");
     $validator->(\@args);
     ...
 }

To specify schema in L<Rinci> function metadata and use the metadata with
L<Perinci::CmdLine> to create a CLI:

 # in lib/MyApp.pm
 package MyApp;
 our %SPEC;
 $SPEC{myfunc} = {
     v => 1.1,
     summary => 'Routine to do blah ...',
     args => {
         arg1 => {
             summary => 'The blah blah argument',
             schema => ['nonnegint*'],
         },
         ...
     },
 };
 sub myfunc {
     my %args = @_;
     ...
 }
 1;

 # in myapp.pl
 package main;
 use Perinci::CmdLine::Any;
 Perinci::CmdLine::Any->new(url=>'MyApp::myfunc')->run;

 # in command-line
 % ./myapp.pl --help
 myapp - Routine to do blah ...
 ...

 % ./myapp.pl --version

 % ./myapp.pl --arg1 ...

Sample data:

 0  # valid

 1  # valid

 -1  # INVALID

=head1 DESCRIPTION

This schema is DEPRECATED. Please use the new name C<uint>.

See also C<posint> for integers that start from 1.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Int>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Int>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Int>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021, 2020, 2018, 2017, 2016, 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
