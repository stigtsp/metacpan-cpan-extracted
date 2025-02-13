use strict;
use warnings;
package Data::InputMonster::Util 0.011;
# ABSTRACT: handy routines for use with the input monster
use Sub::Exporter::Util qw(curry_method);

use Sub::Exporter -setup => {
  exports => {
    dig => curry_method,
  },
};

#pod =head1 DESCRIPTION
#pod
#pod These methods, which provide some helpers for use with InputMonster, can be
#pod exported as routines upon request.
#pod
#pod =cut

#pod =method dig
#pod
#pod   my $source = dig( [ $key1, $key2, $key2 ]);
#pod   my $source = dig( sub { ... } );
#pod
#pod A C<dig> source looks through the input using the given locator.  If it's a
#pod coderef, the code is called and passed the input.  If it's an arrayref, each
#pod entry is used, in turn, to subscript the input as a deep data structure.  If
#pod it's a plain scalar, it's treated like a one-element arrayref would have been.
#pod
#pod For example, given:
#pod
#pod   $input  = [ { ... }, { ... }, { foo => [ { bar => 13, baz => undef } ] } ];
#pod   $source = dig( [ qw( 2 foo 0 bar ) ] );
#pod
#pod The source would find 13.
#pod
#pod =cut

sub dig {
  my ($self, $locator) = @_;
  
  Carp::confess("no locator given") unless defined $locator;

  $locator = [ $locator ] unless ref $locator;

  if (ref $locator eq 'CODE') {
    return sub { $locator->($_[1]) };
  } elsif (ref $locator eq 'ARRAY') {
    return sub {
      my ($monster, $input) = @_;
      my $next = $input;

      for my $k (@$locator) {
        return unless my $ref = ref $next;
        return unless $ref and (($ref eq 'ARRAY') or ($ref eq 'HASH'));

        return if $ref eq 'ARRAY' and $k !~ /\A-?\d+\z/;
        $next = $next->[ $k ] if $ref eq 'ARRAY';
        $next = $next->{ $k } if $ref eq 'HASH';
      }

      return $next;
    };
  }

  Carp::confess("locator must be either a code or array reference");
}

'hi, domm!';

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::InputMonster::Util - handy routines for use with the input monster

=head1 VERSION

version 0.011

=head1 DESCRIPTION

These methods, which provide some helpers for use with InputMonster, can be
exported as routines upon request.

=head1 PERL VERSION SUPPORT

This code is effectively abandonware.  Although releases will sometimes be made
to update contact info or to fix packaging flaws, bug reports will mostly be
ignored.  Feature requests are even more likely to be ignored.  (If someone
takes up maintenance of this code, they will presumably remove this notice.)

=head1 METHODS

=head2 dig

  my $source = dig( [ $key1, $key2, $key2 ]);
  my $source = dig( sub { ... } );

A C<dig> source looks through the input using the given locator.  If it's a
coderef, the code is called and passed the input.  If it's an arrayref, each
entry is used, in turn, to subscript the input as a deep data structure.  If
it's a plain scalar, it's treated like a one-element arrayref would have been.

For example, given:

  $input  = [ { ... }, { ... }, { foo => [ { bar => 13, baz => undef } ] } ];
  $source = dig( [ qw( 2 foo 0 bar ) ] );

The source would find 13.

=head1 AUTHOR

Ricardo SIGNES <rjbs@semiotic.systems>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
