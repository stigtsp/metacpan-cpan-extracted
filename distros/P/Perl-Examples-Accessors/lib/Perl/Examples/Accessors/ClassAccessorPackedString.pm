package Perl::Examples::Accessors::ClassAccessorPackedString;

our $DATE = '2021-08-03'; # DATE
our $VERSION = '0.132'; # VERSION

use Class::Accessor::PackedString {
    constructor => 'new',
    accessors => {
        attr1 => "f",
    },
};

1;
# ABSTRACT:

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Examples::Accessors::ClassAccessorPackedString

=head1 VERSION

This document describes version 0.132 of Perl::Examples::Accessors::ClassAccessorPackedString (from Perl distribution Perl-Examples-Accessors), released on 2021-08-03.

=head1 DESCRIPTION

This is an example of a class which uses L<Class::Accessor::PackedString>. It is
backed by a string.

=head1 ATTRIBUTES

=head2 attr1

A float.

=head1 METHODS

=head2 new([ %attrs ]) => obj

Constructor.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Perl-Examples-Accessors>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Perl-Examples-Accessors>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Perl-Examples-Accessors>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021, 2017, 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
