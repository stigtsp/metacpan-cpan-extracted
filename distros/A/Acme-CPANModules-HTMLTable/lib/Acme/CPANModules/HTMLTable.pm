package Acme::CPANModules::HTMLTable;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-02-16'; # DATE
our $DIST = 'Acme-CPANModules-HTMLTable'; # DIST
our $VERSION = '0.001'; # VERSION

use 5.010001;
use strict;
use warnings;
#use utf8;

sub _make_table {
    my ($cols, $rows, $celltext) = @_;
    my $res = [];
    push @$res, [];
    for (0..$cols-1) { $res->[0][$_] = "col" . ($_+1) }
    for my $row (1..$rows) {
        push @$res, [ map { $celltext // "row$row.$_" } 1..$cols ];
    }
    $res;
}

our $LIST = {
    summary => 'Modules that generate HTML tables',
    entry_features => {
    },
    entries => [
        {
            module => 'Text::Table::Any',
            description => <<'_',

This is a common frontend for many text table modules as backends,
L<Text::Table::HTML> being one.

_
            bench_code => sub {
                my ($table) = @_;
                Text::Table::Any::table(rows=>$table, header_row=>1, backend=>'Text::Table::HTML');
            },
            features => {
            },
        },

        {
            module => 'Text::Table::HTML',
            bench_code => sub {
                my ($table) = @_;
                Text::Table::HTML::table(rows=>$table, header_row=>1);
            },
            features => {
            },
        },

        {
            module => 'Text::Table::HTML::DataTables',
            bench_code => sub {
                my ($table) = @_;
                Text::Table::HTML::DataTables::table(rows=>$table, header_row=>1);
            },
            features => {
            },
        },

        {
            module => 'Text::Table::Manifold',
            bench_code => sub {
                my ($table) = @_;
                my $t = Text::Table::Manifold->new(format => Text::Table::Manifold::format_html_table());
                $t->headers($table->[0]);
                $t->data([ @{$table}[1 .. $#{$table}] ]);
                join("\n", @{$t->render(padding => 1)}) . "\n";
            },
            features => {
            },
        },

    ], # entries

    bench_datasets => [
        {name=>'tiny (1x1)'          , argv => [_make_table( 1, 1)],},
        {name=>'small (3x5)'         , argv => [_make_table( 3, 5)],},
        {name=>'wide (30x5)'         , argv => [_make_table(30, 5)],},
        {name=>'long (3x300)'        , argv => [_make_table( 3, 300)],},
        {name=>'large (30x300)'      , argv => [_make_table(30, 300)],},
    ],

};

1;
# ABSTRACT: Modules that generate HTML tables

__END__

=pod

=encoding UTF-8

=head1 NAME

Acme::CPANModules::HTMLTable - Modules that generate HTML tables

=head1 VERSION

This document describes version 0.001 of Acme::CPANModules::HTMLTable (from Perl distribution Acme-CPANModules-HTMLTable), released on 2021-02-16.

=head1 SYNOPSIS

To run benchmark with default option:

 % bencher --cpanmodules-module HTMLTable

To run module startup overhead benchmark:

 % bencher --module-startup --cpanmodules-module HTMLTable

For more options (dump scenario, list/include/exclude/add participants, list/include/exclude/add datasets, etc), see L<bencher> or run C<bencher --help>.

=head1 BENCHMARKED MODULES

Version numbers shown below are the versions used when running the sample benchmark.

L<Text::Table::Any> 0.100

L<Text::Table::HTML> 0.003

L<Text::Table::HTML::DataTables> 0.007

L<Text::Table::Manifold> 1.03

=head1 BENCHMARK PARTICIPANTS

=over

=item * Text::Table::Any (perl_code)

L<Text::Table::Any>



=item * Text::Table::HTML (perl_code)

L<Text::Table::HTML>



=item * Text::Table::HTML::DataTables (perl_code)

L<Text::Table::HTML::DataTables>



=item * Text::Table::Manifold (perl_code)

L<Text::Table::Manifold>



=back

=head1 BENCHMARK DATASETS

=over

=item * tiny (1x1)

=item * small (3x5)

=item * wide (30x5)

=item * long (3x300)

=item * large (30x300)

=back

=head1 SAMPLE BENCHMARK RESULTS

Run on: perl: I<< v5.30.0 >>, CPU: I<< Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (2 cores) >>, OS: I<< GNU/Linux Ubuntu version 19.10 >>, OS kernel: I<< Linux version 5.3.0-64-generic >>.

Benchmark with default options (C<< bencher --cpanmodules-module HTMLTable >>):

 #table1#
 {dataset=>"large (30x300)"}
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+-----------+---------+
 | participant                   | rate (/s) | time (ms) | pct_faster_vs_slowest | pct_slower_vs_fastest |  errors   | samples |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+-----------+---------+
 | Text::Table::Manifold         |        15 |      65   |                 0.00% |               738.63% |   0.00015 |      20 |
 | Text::Table::HTML::DataTables |       120 |       8.1 |               694.41% |                 5.57% | 6.2e-05   |      20 |
 | Text::Table::HTML             |       130 |       7.7 |               736.70% |                 0.23% | 1.8e-05   |      20 |
 | Text::Table::Any              |       130 |       7.7 |               738.63% |                 0.00% | 1.1e-05   |      20 |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+-----------+---------+

 #table2#
 {dataset=>"long (3x300)"}
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+-----------+---------+
 | participant                   | rate (/s) | time (ms) | pct_faster_vs_slowest | pct_slower_vs_fastest |  errors   | samples |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+-----------+---------+
 | Text::Table::Manifold         |       100 |      9    |                 0.00% |               857.44% |   0.00012 |      20 |
 | Text::Table::HTML::DataTables |       960 |      1    |               737.72% |                14.29% | 6.1e-06   |      20 |
 | Text::Table::Any              |      1100 |      0.92 |               845.63% |                 1.25% | 4.5e-06   |      20 |
 | Text::Table::HTML             |      1100 |      0.91 |               857.44% |                 0.00% | 1.8e-06   |      20 |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+-----------+---------+

 #table3#
 {dataset=>"small (3x5)"}
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+
 | participant                   | rate (/s) | time (μs) | pct_faster_vs_slowest | pct_slower_vs_fastest |  errors | samples |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+
 | Text::Table::Manifold         |      4400 |       230 |                 0.00% |               963.57% | 2.7e-07 |      20 |
 | Text::Table::HTML::DataTables |     15000 |        68 |               234.83% |               217.64% | 9.2e-08 |      27 |
 | Text::Table::Any              |     37000 |        27 |               741.94% |                26.32% |   2e-07 |      20 |
 | Text::Table::HTML             |     47000 |        21 |               963.57% |                 0.00% |   8e-08 |      20 |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+

 #table4#
 {dataset=>"tiny (1x1)"}
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+
 | participant                   | rate (/s) | time (μs) | pct_faster_vs_slowest | pct_slower_vs_fastest |  errors | samples |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+
 | Text::Table::Manifold         |      9200 |   110     |                 0.00% |              1940.27% | 4.7e-07 |      21 |
 | Text::Table::HTML::DataTables |     20000 |    49     |               120.82% |               823.96% | 5.3e-08 |      20 |
 | Text::Table::Any              |    135600 |     7.377 |              1372.90% |                38.52% | 2.3e-10 |      21 |
 | Text::Table::HTML             |    190000 |     5.3   |              1940.27% |                 0.00% | 6.7e-09 |      20 |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+

 #table5#
 {dataset=>"wide (30x5)"}
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+
 | participant                   | rate (/s) | time (μs) | pct_faster_vs_slowest | pct_slower_vs_fastest |  errors | samples |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+
 | Text::Table::Manifold         |       820 |      1200 |                 0.00% |               720.08% | 9.4e-06 |      20 |
 | Text::Table::HTML::DataTables |      4770 |       210 |               484.83% |                40.23% | 1.6e-07 |      20 |
 | Text::Table::Any              |      6620 |       151 |               711.10% |                 1.11% | 5.2e-08 |      21 |
 | Text::Table::HTML             |      6690 |       149 |               720.08% |                 0.00% | 4.6e-08 |      27 |
 +-------------------------------+-----------+-----------+-----------------------+-----------------------+---------+---------+


Benchmark module startup overhead (C<< bencher --cpanmodules-module HTMLTable --module-startup >>):

 #table6#
 +-------------------------------+-----------+-------------------+-----------------------+-----------------------+----------+---------+
 | participant                   | time (ms) | mod_overhead_time | pct_faster_vs_slowest | pct_slower_vs_fastest |  errors  | samples |
 +-------------------------------+-----------+-------------------+-----------------------+-----------------------+----------+---------+
 | Text::Table::Manifold         |      85   |              77.5 |                 0.00% |              1039.21% |   0.0002 |      20 |
 | Text::Table::HTML             |       9.1 |               1.6 |               830.21% |                22.47% | 2.7e-05  |      20 |
 | Text::Table::HTML::DataTables |       9.1 |               1.6 |               831.24% |                22.33% | 1.5e-05  |      20 |
 | Text::Table::Any              |       8.1 |               0.6 |               945.19% |                 9.00% | 4.8e-05  |      20 |
 | perl -e1 (baseline)           |       7.5 |               0   |              1039.21% |                 0.00% | 3.5e-05  |      21 |
 +-------------------------------+-----------+-------------------+-----------------------+-----------------------+----------+---------+


To display as an interactive HTML table on a browser, you can add option C<--format html+datatables>.

=head1 ACME::MODULES ENTRIES

=over

=item * L<Text::Table::Any>

This is a common frontend for many text table modules as backends,
L<Text::Table::HTML> being one.


=item * L<Text::Table::HTML>

=item * L<Text::Table::HTML::DataTables>

=item * L<Text::Table::Manifold>

=back

=head1 FAQ

=head2 What is an Acme::CPANModules::* module?

An Acme::CPANModules::* module, like this module, contains just a list of module
names that share a common characteristics. It is a way to categorize modules and
document CPAN. See L<Acme::CPANModules> for more details.

=head2 What are ways to use this Acme::CPANModules module?

Aside from reading this Acme::CPANModules module's POD documentation, you can
install all the listed modules (entries) using L<cpanmodules> CLI (from
L<App::cpanmodules> distribution):

    % cpanmodules ls-entries HTMLTable | cpanm -n

or L<Acme::CM::Get>:

    % perl -MAcme::CM::Get=HTMLTable -E'say $_->{module} for @{ $LIST->{entries} }' | cpanm -n

or directly:

    % perl -MAcme::CPANModules::HTMLTable -E'say $_->{module} for @{ $Acme::CPANModules::HTMLTable::LIST->{entries} }' | cpanm -n

This Acme::CPANModules module contains benchmark instructions. You can run a
benchmark for some/all the modules listed in this Acme::CPANModules module using
the L<bencher> CLI (from L<Bencher> distribution):

    % bencher --cpanmodules-module HTMLTable

This Acme::CPANModules module also helps L<lcpan> produce a more meaningful
result for C<lcpan related-mods> command when it comes to finding related
modules for the modules listed in this Acme::CPANModules module.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Acme-CPANModules-HTMLTable>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Acme-CPANModules-HTMLTable>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://github.com/perlancar/perl-Acme-CPANModules-HTMLTable/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Acme::CPANModules::TextTable>

L<Acme::CPANModules> - about the Acme::CPANModules namespace

L<cpanmodules> - CLI tool to let you browse/view the lists

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
