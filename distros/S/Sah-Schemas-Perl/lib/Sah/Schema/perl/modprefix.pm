package Sah::Schema::perl::modprefix;

use strict;
use warnings;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-12-01'; # DATE
our $DIST = 'Sah-Schemas-Perl'; # DIST
our $VERSION = '0.042'; # VERSION

our $schema = [str => {
    summary => 'Perl module prefix, e.g. Foo::Bar::',
    description => <<'_',

Perl module prefix, e.g. `Foo::Bar::`. An empty prefix ('') is also allowed.

Contains coercion rule so you can also input:

    Foo-Bar
    Foo-Bar-
    Foo-Bar
    Foo/Bar
    Foo/Bar/
    Foo::Bar

and it will be normalized into `Foo::Bar::`.

_
    match => '\A(?:[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*::)?\z',

    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modprefix',
    ],

    # provide a default completion which is from list of installed perl prefixes
    'x.completion' => 'perl_modprefix',

    examples => [
        {value=>'', valid=>1},
        {value=>'::', valid=>0},
        {value=>'Foo::', valid=>1},
        {value=>'Foo::Bar', valid=>1, validated_value=>'Foo::Bar::'},
        {value=>'Foo::Bar::', valid=>1},
        {value=>'::Foo', valid=>0},
        {value=>'Foo', valid=>1, validated_value=>'Foo::'},
        {value=>'Foo/', valid=>1, validated_value=>'Foo::'},
        {value=>'Foo-', valid=>1, validated_value=>'Foo::'},
    ],

}];

1;
# ABSTRACT: Perl module prefix, e.g. Foo::Bar::

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::perl::modprefix - Perl module prefix, e.g. Foo::Bar::

=head1 VERSION

This document describes version 0.042 of Sah::Schema::perl::modprefix (from Perl distribution Sah-Schemas-Perl), released on 2021-12-01.

=head1 SYNOPSIS

To check data against this schema (requires L<Data::Sah>):

 use Data::Sah qw(gen_validator);
 my $validator = gen_validator("perl::modprefix*");
 say $validator->($data) ? "valid" : "INVALID!";

 # Data::Sah can also create validator that returns nice error message string
 # and/or coerced value. Data::Sah can even create validator that targets other
 # language, like JavaScript. All from the same schema. See its documentation
 # for more details.

To validate function parameters against this schema (requires L<Params::Sah>):

 use Params::Sah qw(gen_validator);

 sub myfunc {
     my @args = @_;
     state $validator = gen_validator("perl::modprefix*");
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
             schema => ['perl::modprefix*'],
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

 ""  # valid

 "::"  # INVALID

 "Foo::"  # valid

 "Foo::Bar"  # valid, becomes "Foo::Bar::"

 "Foo::Bar::"  # valid

 "::Foo"  # INVALID

 "Foo"  # valid, becomes "Foo::"

 "Foo/"  # valid, becomes "Foo::"

 "Foo-"  # valid, becomes "Foo::"

=head1 DESCRIPTION

Perl module prefix, e.g. C<Foo::Bar::>. An empty prefix ('') is also allowed.

Contains coercion rule so you can also input:

 Foo-Bar
 Foo-Bar-
 Foo-Bar
 Foo/Bar
 Foo/Bar/
 Foo::Bar

and it will be normalized into C<Foo::Bar::>.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Perl>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Perl>.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 CONTRIBUTING


To contribute, you can send patches by email/via RT, or send pull requests on
GitHub.

Most of the time, you don't need to build the distribution yourself. You can
simply modify the code, then test via:

 % prove -l

If you want to build the distribution (e.g. to try to install it locally on your
system), you can install L<Dist::Zilla>,
L<Dist::Zilla::PluginBundle::Author::PERLANCAR>, and sometimes one or two other
Dist::Zilla plugin and/or Pod::Weaver::Plugin. Any additional steps required
beyond that are considered a bug and can be reported to me.

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021, 2020, 2019, 2018, 2017, 2016 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Perl>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut
