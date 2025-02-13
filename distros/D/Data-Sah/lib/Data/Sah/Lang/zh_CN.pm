package Data::Sah::Lang::zh_CN;

use 5.010;
use strict;
use utf8;
use warnings;

use Tie::IxHash;

# currently incomplete

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-12-01'; # DATE
our $DIST = 'Data-Sah'; # DIST
our $VERSION = '0.911'; # VERSION

our %translations;
tie %translations, 'Tie::IxHash', (

    # punctuations

    q[ ], # inter-word boundary
    q[],

    q[, ],
    q[，],

    q[: ],
    q[：],

    q[. ],
    q[。],

    q[(],
    q[（],

    q[)],
    q[）],

    # modal verbs

    q[must],
    q[必须],

    q[must not],
    q[必须不],

    q[should],
    q[应],

    q[should not],
    q[应不],

    # field/fields/argument/arguments

    q[field],
    q[字段],

    q[fields],
    q[字段],

    q[argument],
    q[参数],

    q[arguments],
    q[参数],

    # multi

    q[%s and %s],
    q[%s和%s],

    q[%s or %s],
    q[%s或%s],

    q[one of %s],
    q[这些值%s之一],

    q[all of %s],
    q[所有这些值%s],

    q[%(modal_verb)s satisfy all of the following],
    q[%(modal_verb)s满足所有这些条件],

    q[%(modal_verb)s satisfy one of the following],
    q[%(modal_verb)s满足这些条件之一],

    q[%(modal_verb)s satisfy none of the following],
    q[%(modal_verb_neg)s满足所有这些条件],

    # type: BaseType

    # type: Sortable

    # type: Comparable

    # type: HasElems

    # type: num

    # type: int

    q[integer],
    q[整数],

    q[integers],
    q[整数],

    q[%(modal_verb)s be divisible by %s],
    q[%(modal_verb)s被%s整除],

    q[%(modal_verb)s leave a remainder of %2$s when divided by %1$s],
    q[除以%1$s时余数%(modal_verb)s为%2$s],

    # messages for compiler
);

1;
# ABSTRACT: zh_CN locale

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Lang::zh_CN - zh_CN locale

=head1 VERSION

This document describes version 0.911 of Data::Sah::Lang::zh_CN (from Perl distribution Data-Sah), released on 2021-12-01.

=for Pod::Coverage .+

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Data-Sah>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Data-Sah>.

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

This software is copyright (c) 2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2012 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Data-Sah>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut
