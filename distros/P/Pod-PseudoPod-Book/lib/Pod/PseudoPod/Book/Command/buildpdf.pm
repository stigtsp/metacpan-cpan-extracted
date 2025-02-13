package Pod::PseudoPod::Book::Command::buildpdf;
# ABSTRACT: command module for C<ppbook buildpdf>

use strict;
use warnings;

use parent 'Pod::PseudoPod::Book::Command';
use Path::Class;
use File::chdir;
use File::Copy;

sub execute
{
    my ($self, $opt, $args) = @_;
    my %sizes               = map { $_ => 1 } qw( letter a4 6x9 5x8 );
    my $conf                = $self->config;
    my $size                = 'letter';
    my $latex_dir           = dir(qw( build latex ));
    my $pdf_dir             = $latex_dir->parent->subdir( 'pdf' )->absolute;
    my $filename_template   = $conf->{book}{filename_template};

    for my $arg (@$args)
    {
        next unless exists $sizes{$arg};
        $size = $arg;
    }

    push @CWD, "$latex_dir";
    my $tex_file = $filename_template . '_' . $size . '.tex';
    my $idx_file = $filename_template . '_' . $size . '.idx';
    my $ind_file = $filename_template . '_' . $size . '.ind';
    unlink $idx_file;

    die "No LaTeX file found at '$tex_file'\n" unless -e $tex_file;
    my @pdf_args = ( pdflatex => "-output-directory=$pdf_dir", $tex_file );
    die "pdflatex failed for $tex_file: $!"  if system @pdf_args;

    if ($conf->{book}{build_index})
    {
        copy "$pdf_dir/$idx_file", $idx_file;
        my @idx_args = ( makeindex => $idx_file, $idx_file );
        die "makeindex failed for $pdf_dir/$idx_file: $!" if system @idx_args;
        die "pdflatex failed for $tex_file: $!"  if system @pdf_args;
        unlink $idx_file;
    }

    pop @CWD;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Pod::PseudoPod::Book::Command::buildpdf - command module for C<ppbook buildpdf>

=head1 VERSION

version 1.20210620.2051

=head1 AUTHOR

chromatic <chromatic@wgz.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by chromatic.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
