package XML::Grammar::Screenplay::ToTEI;
$XML::Grammar::Screenplay::ToTEI::VERSION = 'v0.16.0';
use strict;
use warnings;

use MooX 'late';

use XML::GrammarBase::Role::RelaxNG v0.2.2;
use XML::GrammarBase::Role::XSLT v0.2.2;

with ('XML::GrammarBase::Role::RelaxNG');
with XSLT(output_format => 'tei');

has '+module_base' => (default => 'XML-Grammar-Fiction');
has '+rng_schema_basename' => (default => 'screenplay-xml.rng');

has '+to_tei_xslt_transform_basename' =>
(
    default => 'screenplay-xml-to-tei.xslt',
);


sub translate_to_tei
{
    my ($self, $args) = @_;

    return $self->perform_xslt_translation(
        {output_format => 'tei', %{$args}}
    );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

XML::Grammar::Screenplay::ToTEI

=head1 VERSION

version v0.16.0

=head1 NAME

XML::Grammar::Screenplay::ToTEI - module that converts the Screenplay
XML to TEI (Text Encoding Initiative).

=head1 VERSION

version v0.16.0

=head2 new()

Accepts no arguments so far. May take some time as the grammar is compiled
at that point.

=head2 meta()

Internal - (to settle pod-coverage).

=head2 xslt_transform_basename()

Inherited - (to settle pod-coverage).

=head2 $converter->translate_to_tei({source => {file => $filename}, output => "string" })

Does the actual conversion. $filename is the filename to translate (currently
the only available source).

The C<'output'> key specifies the return value. A value of C<'string'> returns
the XML as a string, and a value of C<'xml'> returns the XML as an
L<XML::LibXML> DOM object.

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<https://metacpan.org/release/XML-Grammar-Fiction>

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/XML-Grammar-Fiction>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<https://rt.cpan.org/Public/Dist/Display.html?Name=XML-Grammar-Fiction>

=item *

AnnoCPAN

The AnnoCPAN is a website that allows community annotations of Perl module documentation.

L<http://annocpan.org/dist/XML-Grammar-Fiction>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/XML-Grammar-Fiction>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.cpanauthors.org/dist/XML-Grammar-Fiction>

=item *

CPAN Testers

The CPAN Testers is a network of smoke testers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/X/XML-Grammar-Fiction>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=XML-Grammar-Fiction>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=XML::Grammar::Fiction>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-xml-grammar-fiction at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/Public/Bug/Report.html?Queue=XML-Grammar-Fiction>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<http://bitbucket.org/shlomif/perl-XML-Grammar-Fiction>

  hg clone ssh://hg@bitbucket.org/shlomif/perl-XML-Grammar-Fiction

=head1 AUTHOR

Shlomi Fish <shlomif@cpan.org>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=XML-Grammar-Fiction> or by email
to
L<bug-xml-grammar-fiction@rt.cpan.org|mailto:bug-xml-grammar-fiction@rt.cpan.org>.

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2007 by Shlomi Fish.

This is free software, licensed under:

  The MIT (X11) License

=cut
