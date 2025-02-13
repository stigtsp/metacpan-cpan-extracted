package Sah::Schema::perl::pod_filename;

use strict;
use warnings;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-12-01'; # DATE
our $DIST = 'Sah-Schemas-Perl'; # DIST
our $VERSION = '0.042'; # VERSION

our $schema = [str => {
    summary => 'A .pod filename, e.g. /path/Foo.pod',
    description => <<'_',

Use this schema if you want to accept a filesystem path containing Perl POD. The
value of this schema is in the convenience of CLI completion, as well as
coercion from POD name.

String containing filename of a Perl .pod file. For convenience, when value is
in the form of:

    Foo
    Foo.pod
    Foo::Bar
    Foo/Bar
    Foo/Bar.pod

and a matching .pod file is found in `@INC`, then it will be coerced (converted)
into the filesystem path of that .pod file, e.g.:

    /home/ujang/perl5/perlbrew/perls/perl-5.24.0/lib/site_perl/5.24.0/Foo/Bar.pod

To prevent such coercion, you can use prefixing path, e.g.:

    ./Foo::Bar
    ../Foo/Bar
    /path/to/Foo/Bar

This schema comes with convenience completion too.

_
    'x.perl.coerce_rules' => [
        'From_str::convert_perl_pod_to_path',
    ],
    'x.completion' => sub {
        require Complete::File;
        require Complete::Module;
        require Complete::Util;

        my %args = @_;
        my $word = $args{word};

        my @answers;
        push @answers, Complete::File::complete_file(word => $word);
        if ($word =~ m!\A\w*((?:::|/)\w+)*\z!) {
            push @answers, Complete::Module::complete_module(
                word => $word, find_pod=>1, find_pm=>0, find_pmc=>0);
        }

        Complete::Util::combine_answers(@answers);
    },

}];

1;
# ABSTRACT: A .pod filename, e.g. /path/Foo.pod

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::perl::pod_filename - A .pod filename, e.g. /path/Foo.pod

=head1 VERSION

This document describes version 0.042 of Sah::Schema::perl::pod_filename (from Perl distribution Sah-Schemas-Perl), released on 2021-12-01.

=head1 SYNOPSIS

To check data against this schema (requires L<Data::Sah>):

 use Data::Sah qw(gen_validator);
 my $validator = gen_validator("perl::pod_filename*");
 say $validator->($data) ? "valid" : "INVALID!";

 # Data::Sah can also create validator that returns nice error message string
 # and/or coerced value. Data::Sah can even create validator that targets other
 # language, like JavaScript. All from the same schema. See its documentation
 # for more details.

To validate function parameters against this schema (requires L<Params::Sah>):

 use Params::Sah qw(gen_validator);

 sub myfunc {
     my @args = @_;
     state $validator = gen_validator("perl::pod_filename*");
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
             schema => ['perl::pod_filename*'],
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

=head1 DESCRIPTION

Use this schema if you want to accept a filesystem path containing Perl POD. The
value of this schema is in the convenience of CLI completion, as well as
coercion from POD name.

String containing filename of a Perl .pod file. For convenience, when value is
in the form of:

 Foo
 Foo.pod
 Foo::Bar
 Foo/Bar
 Foo/Bar.pod

and a matching .pod file is found in C<@INC>, then it will be coerced (converted)
into the filesystem path of that .pod file, e.g.:

 /home/ujang/perl5/perlbrew/perls/perl-5.24.0/lib/site_perl/5.24.0/Foo/Bar.pod

To prevent such coercion, you can use prefixing path, e.g.:

 ./Foo::Bar
 ../Foo/Bar
 /path/to/Foo/Bar

This schema comes with convenience completion too.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Perl>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Perl>.

=head1 SEE ALSO

L<Sah::Schema::perl::filename>

L<Sah::Schema::perl::pod_or_pm_filename>

L<Sah::Schema::perl::pm_filename>

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
