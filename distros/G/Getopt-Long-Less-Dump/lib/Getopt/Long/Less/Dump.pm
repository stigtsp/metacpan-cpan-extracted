package Getopt::Long::Less::Dump;

our $DATE = '2017-10-02'; # DATE
our $VERSION = '0.001'; # VERSION

use 5.010001;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(dump_getopt_long_less_script);

our %SPEC;

$SPEC{dump_getopt_long_less_script} = {
    v => 1.1,
    summary => 'Run a Getopt::Long::Less-based script but only to '.
        'dump the spec',
    description => <<'_',

This function runs a CLI script that uses `Getopt::Long::Less` but
monkey-patches beforehand so that `run()` will dump the object and then exit.
The goal is to get the object without actually running the script.

This can be used to gather information about the script and then generate
documentation about it or do other things (e.g. `App::shcompgen` to generate a
completion script for the original script).

CLI script needs to use `Getopt::Long::Less`. This is detected currently by a
simple regex. If script is not detected as using `Getopt::Long::Less`, status
412 is returned.

Will return the `Getopt::Long::Less` specification.

_
    args => {
        filename => {
            summary => 'Path to the script',
            req => 1,
            pos => 0,
            schema => 'str*',
            cmdline_aliases => {f=>{}},
        },
        libs => {
            'x.name.is_plural' => 1,
            'x.name.singular' => 'lib',
            summary => 'Libraries to unshift to @INC when running script',
            schema  => ['array*' => of => 'str*'],
            cmdline_aliases => {I=>{}},
        },
        skip_detect => {
            schema => ['bool', is=>1],
            cmdline_aliases => {D=>{}},
        },
    },
};
sub dump_getopt_long_less_script {
    require Capture::Tiny;
    require Getopt::Long::Util;
    require UUID::Random;

    my %args = @_;

    my $filename = $args{filename} or return [400, "Please specify filename"];
    my $detres;
    if ($args{skip_detect}) {
        $detres = [200, "OK (skip_detect)", 1, {"func.module"=>"Getopt::Long::Less", "func.reason"=>"skip detect, forced"}];
    } else {
        $detres = Getopt::Long::Util::detect_getopt_long_script(
            filename => $filename);
        return $detres if $detres->[0] != 200;
        return [412, "File '$filename' is not script using Getopt::Long::Less (".
                    $detres->[3]{'func.reason'}.")"] unless $detres->[2];
    }

    my $libs = $args{libs} // [];

    my $tag = UUID::Random::generate();
    my @cmd = (
        $^X, (map {"-I$_"} @$libs),
        "-MGetopt::Long::Less::Patch::DumpAndExit=-tag,$tag",
        $filename,
        "--version",
    );
    my ($stdout, $stderr, $exit) = Capture::Tiny::capture(
        sub { local $ENV{GETOPT_LONG_LESS_DUMP} = 1; system @cmd },
    );

    my $spec;
    if ($stdout =~ /^# BEGIN DUMP $tag\s+(.*)^# END DUMP $tag/ms) {
        $spec = eval $1;
        if ($@) {
            return [500, "Script '$filename' looks like using ".
                        "Getopt::Long::Less, but I got an error in eval-ing ".
                            "captured option spec: $@, raw capture: <<<$1>>>"];
        }
        if (ref($spec) ne 'HASH') {
            return [500, "Script '$filename' looks like using ".
                        "Getopt::Long::Less, but I didn't get a hash option spec, ".
                            "raw capture: stdout=<<$stdout>>"];
        }
    } else {
        return [500, "Script '$filename' looks like using Getopt::Long::Less, ".
                    "but I couldn't capture option spec, raw capture: ".
                        "stdout=<<$stdout>>, stderr=<<$stderr>>"];
    }

    [200, "OK", $spec, {
        'func.detect_res' => $detres,
    }];
}

1;
# ABSTRACT: Run a Getopt::Long::Less-based script but only to dump the spec

__END__

=pod

=encoding UTF-8

=head1 NAME

Getopt::Long::Less::Dump - Run a Getopt::Long::Less-based script but only to dump the spec

=head1 VERSION

This document describes version 0.001 of Getopt::Long::Less::Dump (from Perl distribution Getopt-Long-Less-Dump), released on 2017-10-02.

=head1 FUNCTIONS


=head2 dump_getopt_long_less_script

Usage:

 dump_getopt_long_less_script(%args) -> [status, msg, result, meta]

Run a Getopt::Long::Less-based script but only to dump the spec.

This function runs a CLI script that uses C<Getopt::Long::Less> but
monkey-patches beforehand so that C<run()> will dump the object and then exit.
The goal is to get the object without actually running the script.

This can be used to gather information about the script and then generate
documentation about it or do other things (e.g. C<App::shcompgen> to generate a
completion script for the original script).

CLI script needs to use C<Getopt::Long::Less>. This is detected currently by a
simple regex. If script is not detected as using C<Getopt::Long::Less>, status
412 is returned.

Will return the C<Getopt::Long::Less> specification.

This function is not exported by default, but exportable.

Arguments ('*' denotes required arguments):

=over 4

=item * B<filename>* => I<str>

Path to the script.

=item * B<libs> => I<array[str]>

Libraries to unshift to @INC when running script.

=item * B<skip_detect> => I<bool>

=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (result) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)

=head1 ENVIRONMENT

=head2 GETOPT_LONG_LESS_DUMP => bool

Will be set to 1 when executing the script to be dumped.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Getopt-Long-Less-Dump>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Getopt-Long-Less-Dump>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Getopt-Long-Less-Dump>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
