package Mail::LMLM::Types::Ezmlm;
$Mail::LMLM::Types::Ezmlm::VERSION = '0.6807';
use strict;
use warnings;

use Mail::LMLM::Types::Base;

use vars qw(@ISA);

@ISA = qw(Mail::LMLM::Types::Base);

sub group_form
{
    my $self = shift;

    my $add = shift;

    return ( ( $self->get_group_base() . ( $add ? ( "-" . $add ) : "" ) ),
        $self->get_hostname() );
}

sub _get_subscribe_address
{
    my $self = shift;

    return $self->group_form("subscribe");
}

sub _get_unsubscribe_address
{
    my $self = shift;

    return $self->group_form("unsubscribe");
}

sub _get_post_address
{
    my $self = shift;

    return $self->group_form();
}

sub _get_owner_address
{
    my $self = shift;

    return $self->group_form("owner");
}

sub render_something_with_email_addr
{
    my $self = shift;

    my $htmler         = shift;
    my $begin_msg      = shift;
    my $address_method = shift;

    $htmler->para($begin_msg);
    $htmler->indent_inc();
    $htmler->start_para();
    $htmler->email_address( $self->$address_method() );
    $htmler->end_para();
    $htmler->indent_dec();

    return 0;
}

sub render_subscribe
{
    my $self = shift;

    my $htmler = shift;

    return $self->render_something_with_email_addr( $htmler,
        "Send an empty mail message to the following address: ",
        \&_get_subscribe_address );
}

sub render_unsubscribe
{
    my $self = shift;

    my $htmler = shift;

    return $self->render_something_with_email_addr( $htmler,
        "Send an empty mail message to the following address: ",
        \&_get_unsubscribe_address );
}

sub render_post
{
    my $self = shift;

    my $htmler = shift;

    return $self->render_something_with_email_addr( $htmler,
        "Send your messages to the following address: ",
        \&_get_post_address );
}

sub render_owner
{
    my $self = shift;

    my $htmler = shift;

    return $self->render_something_with_email_addr( $htmler,
        "Send messages to the mailing-list owner to the following address: ",
        \&_get_owner_address );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Mail::LMLM::Types::Ezmlm - mailing list type for ezmlm-based mailing lists.

=head1 VERSION

version 0.6807

=head1 METHODS

=head2 group_form

Creates a group-based form (like C<mygroup-subscribe@myhost.tld> or
C<mygroup-owner@myhost.tld>) for the mailing list.

=head2 render_something_with_email_addr

Internal method.

=head2 render_subscribe

Over-rides the equivalent from L<Mail::LMLM::Types::Base>.

=head2 render_unsubscribe

Over-rides the equivalent from L<Mail::LMLM::Types::Base>.

=head2 render_post

Over-rides the equivalent from L<Mail::LMLM::Types::Base>.

=head2 render_owner

Over-rides the equivalent from L<Mail::LMLM::Types::Base>.

=head1 SEE ALSO

L<Mail::LMLM::Types::Base>

=head1 AUTHOR

Shlomi Fish, L<http://www.shlomifish.org/>.

=for :stopwords cpan testmatrix url bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<https://metacpan.org/release/Mail-LMLM>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<https://rt.cpan.org/Public/Dist/Display.html?Name=Mail-LMLM>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.cpanauthors.org/dist/Mail-LMLM>

=item *

CPAN Testers

The CPAN Testers is a network of smoke testers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/M/Mail-LMLM>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=Mail-LMLM>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=Mail::LMLM>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-mail-lmlm at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/Public/Bug/Report.html?Queue=Mail-LMLM>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/shlomif/perl-mail-lmlm>

  git clone git://github.com/shlomif/perl-mail-lmlm.git

=head1 AUTHOR

Shlomi Fish

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/shlomif/perl-mail-lmlm/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2020 by Shlomi Fish.

This is free software, licensed under:

  The MIT (X11) License

=cut
