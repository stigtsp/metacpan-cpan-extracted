package App::lcpan::Cmd::dists_by_dep_count;

use 5.010;
use strict;
use warnings;

use Function::Fallback::CoreOrPP qw(clone_list);

require App::lcpan;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2022-03-27'; # DATE
our $DIST = 'App-lcpan'; # DIST
our $VERSION = '1.070'; # VERSION

our %SPEC;

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'List "heavy" distributions (ranked by number of dependencies)',
    args => {
        %App::lcpan::common_args,
        %App::lcpan::fauthor_args,
        clone_list(%App::lcpan::deps_phase_args),
        clone_list(%App::lcpan::deps_rel_args),
        n => {
            summary => 'Return at most this number of results',
            schema => 'posint*',
        },
    },
};
delete $SPEC{'handle_cmd'}{args}{phase}{default};
delete $SPEC{'handle_cmd'}{args}{rel}{default};
sub handle_cmd {
    my %args = @_;

    my $state = App::lcpan::_init(\%args, 'ro');
    my $dbh = $state->{dbh};

    my @where;
    my @binds;
    if ($args{author}) {
        push @where, "(file.author=?)";
        push @binds, $args{author};
    }
    if ($args{phase} && $args{phase} ne 'ALL') {
        push @where, "(dep.phase=?)";
        push @binds, $args{phase};
    }
    if ($args{rel} && $args{rel} ne 'ALL') {
        push @where, "(dep.rel=?)";
        push @binds, $args{rel};
    }
    push @where, "file.is_latest_dist";
    @where = (1) if !@where;

    my $sql = "SELECT
  file.dist_name dist,
  file.cpanid author,
  COUNT(DISTINCT dep.module_id) AS dep_count
FROM dep
LEFT JOIN file ON dep.file_id=file.id
WHERE ".join(" AND ", @where)."
GROUP BY dep.file_id
ORDER BY dep_count DESC
".($args{n} ? "LIMIT ".(0+$args{n}) : "");

    my @res;
    my $sth = $dbh->prepare($sql);
    $sth->execute(@binds);
    while (my $row = $sth->fetchrow_hashref) {
        push @res, $row;
    }

    require Data::TableData::Rank;
    Data::TableData::Rank::add_rank_column_to_table(table => \@res, data_columns => ['dep_count']);

    my $resmeta = {};
    $resmeta->{'table.fields'} = [qw/rank dist author dep_count/];
    [200, "OK", \@res, $resmeta];
}

1;
# ABSTRACT: List "heavy" distributions (ranked by number of dependencies)

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::dists_by_dep_count - List "heavy" distributions (ranked by number of dependencies)

=head1 VERSION

This document describes version 1.070 of App::lcpan::Cmd::dists_by_dep_count (from Perl distribution App-lcpan), released on 2022-03-27.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [$status_code, $reason, $payload, \%result_meta]

List "heavy" distributions (ranked by number of dependencies).

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<author> => I<str>

Filter by author.

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. E<sol>pathE<sol>toE<sol>cpan.

Defaults to C<~/cpan>.

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

=item * B<n> => I<posint>

Return at most this number of results.

=item * B<phase> => I<str>

=item * B<rel> => I<str>

=item * B<use_bootstrap> => I<bool> (default: 1)

Whether to use bootstrap database from App-lcpan-Bootstrap.

If you are indexing your private CPAN-like repository, you want to turn this
off.


=back

Returns an enveloped result (an array).

First element ($status_code) is an integer containing HTTP-like status code
(200 means OK, 4xx caller error, 5xx function error). Second element
($reason) is a string containing error message, or something like "OK" if status is
200. Third element ($payload) is the actual result, but usually not present when enveloped result is an error response ($status_code is not 2xx). Fourth
element (%result_meta) is called result metadata and is optional, a hash
that contains extra information, much like how HTTP response headers provide additional metadata.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-lcpan>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-lcpan>.

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

This software is copyright (c) 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-lcpan>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut
