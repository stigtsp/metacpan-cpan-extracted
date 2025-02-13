package Data::Sah::Filter::perl::Unix::convert_unix_user_to_uid;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-07-29'; # DATE
our $DIST = 'Sah-Schemas-Unix'; # DIST
our $VERSION = '0.018'; # VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 1,
        summary => 'Convert Unix username into UID, fail when cannot convert',
        might_fail => 1,
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "$dt !~ ";
    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; if (\$tmp !~ /\\A[0-9]+\\z/) { my \@pw = getpwnam(\$tmp); \@pw ? [undef, \$pw[2]] : [\"Unknown Unix group '\$tmp'\", \$tmp] } else { [undef, \$tmp] } }",
    );

    $res;
}

1;
# ABSTRACT:

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Filter::perl::Unix::convert_unix_user_to_uid

=head1 VERSION

This document describes version 0.018 of Data::Sah::Filter::perl::Unix::convert_unix_user_to_uid (from Perl distribution Sah-Schemas-Unix), released on 2021-07-29.

=for Pod::Coverage ^(meta|filter)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Unix>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Unix>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Unix>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Data::Sah::Filter::perl::Unix::try_convert_unix_user_to_uid> which
leave string as-is when there is no associated UID for the username.

L<Data::Sah::Filter::perl::Unix::try_convert_unix_group_to_gid>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021, 2020, 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
