package Astro::FITS::CFITSIO::Simple::PrintStatus;

# ABSTRACT: generate a progress status update

use strict;
use warnings;

our $VERSION = '0.19';

sub new
{
  my ( $class, $what, $nrows ) = @_;

  # if a boolean (i.e. scalar)
  if ( ! ref $what )
  {
    # if its false, return undef
    return unless $what;

    # if its true, try to use Term::ProgressBar if it's available, else fall back
    # to our primitive efforts
    unless ( -1 == $what )
    {
      eval { require Term::ProgressBar }
        && return Astro::FITS::CFITSIO::Simple::PrintStatusProgressBar->new( $nrows );
    }

    # no, piggy back on glob support
    $what = \*STDERR;
  }

  # if a GLOB, create an IO::File object and use that
  if ( 'GLOB' eq ref $what )
  {
    require IO::File;
    my $fh = IO::File->new;
    $fh->fdopen( fileno($what), 'w' )
      or die( "unable to connect to status filehandle!\n" );

    return Astro::FITS::CFITSIO::Simple::PrintStatusObj->new( $fh, $nrows );
  }

  # if it's a subroutine
  elsif ( 'CODE' eq ref $what )
  {
    return Astro::FITS::CFITSIO::Simple::PrintStatusCode->new( $what, $nrows );
  }

  # according to the validate rules, this must be an object
  # with print and flush capabilities.
  else
  {
    return Astro::FITS::CFITSIO::Simple::PrintStatusObj->new( $what, $nrows );
  }
}

sub start {}

sub finish {}

sub next_update
{
  my ( $self, $rows ) = @_;

  my $pct_done = 100 * $rows / $self->{nrows};
  my $next = int( ( $pct_done + 1) / 100 * $self->{nrows} + 0.5 );

  $next = $self->{nrows}
    if $next > $self->{nrows};

  $next;

}

sub update
{
  my ( $self, $rows_done ) = @_;

  $self->output( $rows_done, $self->{nrows} );
}


{
  package Astro::FITS::CFITSIO::Simple::PrintStatusObj;
  our @ISA = qw/Astro::FITS::CFITSIO::Simple::PrintStatus/;

  sub new { bless {fh => $_[1], nrows => $_[2]}, $_[0] }


  sub start { my $self = shift;
              $self->{fh}->print( sprintf( "    " , shift) );
              $self->{fh}->flush;
            }

  sub output { my ( $self, $rows ) = @_;
               my $pct_done = int( 100 * $rows / $self->{nrows} );
               $self->{fh}->print( sprintf( "\b\b\b\b%3d%" , $pct_done) );
               $self->{fh}->flush;
               $self->next_update( $rows );
             }

  sub finish { my $self = shift;
               $self->output( $self->{nrows}, $self->{nrows} );
               $self->{fh}->print( "\n" );
               $self->{fh}->flush;
             }
}

{
  package Astro::FITS::CFITSIO::Simple::PrintStatusCode;
  our @ISA = qw/Astro::FITS::CFITSIO::Simple::PrintStatus/;

  sub new { bless {coderef => $_[1], nrows => $_[2]}, $_[0] }

  sub output { my ( $self, $rows, $nrows )  = @_;
               $self->{coderef}->($rows, $nrows);
               $self->next_update( $rows );
             };
}

{
  package Astro::FITS::CFITSIO::Simple::PrintStatusProgressBar;
  our @ISA = qw/Astro::FITS::CFITSIO::Simple::PrintStatus/;

  sub new { bless {nrows => $_[1]}, $_[0] }

  sub start
  {
    my $self = shift;

    require Term::ProgressBar;

    $self->{progress} =
      Term::ProgressBar->new( { count => $self->{nrows},
                                ETA => 'linear',
                              } )
      or die( "unable to create ProgressBar\n" );

    $self->{progress}->minor(0);
    $self->{next_update} = 0;
  }

  sub output
  {
    my ( $self, $row, $nrows ) = @_;

    $self->{progress}->update( $row );
  }

  sub finish
  {
    my $self = shift;

    $self->{progress}->update( $self->{nrows} );
  }
}

#
# This file is part of Astro-FITS-CFITSIO-Simple
#
# This software is Copyright (c) 2008 by Smithsonian Astrophysical Observatory.
#
# This is free software, licensed under:
#
#   The GNU General Public License, Version 3, June 2007
#

1;

__END__

=pod

=for :stopwords Diab Jerius Pete Ratzlaff Smithsonian Astrophysical Observatory

=head1 NAME

Astro::FITS::CFITSIO::Simple::PrintStatus - generate a progress status update

=head1 VERSION

version 0.19

=head1 DESCRIPTION

INTERNAL USE ONLY!  No warranty, may change, etc.

=head2 Methods

=over

=item new

  $status = Astro::FITS::CFITSIO::Simple::PrintStatus->new( $what );

Create a new object.  C<$what> may be one of the following:

=over

=item SCALAR

If this is non-zero, a progress indicator is written to STDERR.  If
B<Term::ProgressBar> is available, that is used, else a simple
percentile is output.  If this is zero, returns B<undef>.

=item GLOB

If it's a glob, it's assumed to be a filehandle glob, and output is
written to that filehandle.

=item CODEREF

If it's a code reference, it is called with three arguments

  rows read
  total number of rows

=item OBJECT

If it's an object, and it has B<print()> and B<flush()> methods,
it'll call those as appropriate.

=back

=item start

  $status->start( $nrows );

This preps the output and indicates the number of rows that will be written.

=item update

  $status->update( $rows_read );

This will cause output to be generated.  It returns the number of rows that
will cause an actual change in the output.  It is usually used as such:

  $next_update = 0;
  $ps->start();
  for ( 0..$nmax )
  {
    # do stuff

    $next_update = $ps->update( $_ )
      if $_ >= $next_update;
  }
  $ps->finish
    if $nmax >= $next_update;

=item finish

  $status->finish;

This should be called after all of the rows have been written.

=back

=for Pod::Coverage next_update

=head1 SUPPORT

=head2 Bugs

Please report any bugs or feature requests to bug-astro-fits-cfitsio-simple@rt.cpan.org  or through the web interface at: https://rt.cpan.org/Public/Dist/Display.html?Name=Astro-FITS-CFITSIO-Simple

=head2 Source

Source is available at

  https://gitlab.com/djerius/astro-fits-cfitsio-simple

and may be cloned from

  https://gitlab.com/djerius/astro-fits-cfitsio-simple.git

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Astro::FITS::CFITSIO::Simple|Astro::FITS::CFITSIO::Simple>

=back

=head1 AUTHORS

=over 4

=item *

Diab Jerius <djerius@cpan.org>

=item *

Pete Ratzlaff

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2008 by Smithsonian Astrophysical Observatory.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
