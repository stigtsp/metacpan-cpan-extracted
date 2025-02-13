package Venus::Role::Valuable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'attr';

# ATTRIBUTES

attr 'value';

# BUILDERS

sub BUILD {
  my ($self, $data) = @_;

  $self->value($self->default) if !exists $data->{value};
}

# METHODS

sub default {
  return;
}

# EXPORTS

sub EXPORT {
  ['value', 'default']
}

1;



=head1 NAME

Venus::Role::Valuable - Valuable Role

=cut

=head1 ABSTRACT

Valuable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  with 'Venus::Role::Valuable';

  package main;

  my $example = Example->new;

  # $example->value;

=cut

=head1 DESCRIPTION

This package modifies the consuming package and provides a C<value> attribute
which defaults to what's returned by the C<default> method.

=cut

=head1 ATTRIBUTES

This package has the following attributes:

=cut

=head2 value

  value(Any)

This attribute is read-write, accepts C<(Any)> values, and is optional.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 default

  default() (Any)

The default method returns the default value, i.e. C<undef>.

I<Since C<0.01>>

=over 4

=item default example 1

  package main;

  my $example = Example->new;

  my $default = $example->default;

  # undef

=back

=cut