package Pod::PseudoPod::Book::Command::create;
# ABSTRACT: command module for C<ppbook create>

use strict;
use warnings;

use parent 'Pod::PseudoPod::Book::Command';

use File::Path 'make_path';
use File::Spec::Functions qw( catdir catfile );

sub execute
{
    my ($self, $opt, $args) = @_;

    die "No book name given\n" unless @$args == 1;
    my $book_dir = $args->[0];

    $self->make_paths( $book_dir );

    # the previous line implies the following, but it's idempotent
    $self->make_conf_file( $book_dir );
}

sub make_paths
{
    my ($self, $book_dir) = @_;

    make_path( $book_dir );
    my $conf              = $self->make_conf_file( $book_dir );
    my $layout_conf       = $conf->{layout};
    my $dir               = $layout_conf->{subchapter_directory};
    my $builddir          = $layout_conf->{chapter_build_directory};

    make_path map { catdir( $book_dir, $_ ) }
                $dir, 'images', map { catdir( 'build', $_ ) }
                                    $builddir, qw( latex html epub pdf );
}

sub make_conf_file
{
    my ($self, $conf_dir) = @_;
    my $conf_file         = catfile( $conf_dir, 'book.conf' );
    my $conf              = Config::Tiny->read( $conf_file );
    return $conf if $conf;

    my $config = Config::Tiny->new;
    $config->{_}{rootproperty} =
    {
        help => 'See perldoc Pod::PseudoPod::Book::Conf for details',
    };

    $config->{book} =
    {
        title             => '',
        language          => 'en',
        cover_image       => '',
        author_name       => '',
        copyright_year    => (localtime)[5] + 1900,
        filename_template => 'book',
        subtitle          => '',
        build_index       =>  1,
        build_credits     =>  0,
        ISBN10            => '',
        ISBN13            => '',
    };
    $config->{layout} =
    {
        chapter_name_prefix     => 'chapter',
        subchapter_directory    => 'sections',
        chapter_build_directory => 'pod',
    };

    $config->write( $conf_file );
    print "Please edit '$conf_file' to configure your book\n";
    print "See perldoc Pod::PseudoPod::Book::Conf for details\n";

    return $config;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Pod::PseudoPod::Book::Command::create - command module for C<ppbook create>

=head1 VERSION

version 1.20210620.2051

=head1 AUTHOR

chromatic <chromatic@wgz.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by chromatic.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
