package Venus::Kind::Value;

use 5.018;

use strict;
use warnings;

use overload (
  '""' => 'explain',
  '~~' => 'explain',
  fallback => 1,
);

use Venus::Class;

base 'Venus::Kind';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';
with 'Venus::Role::Proxyable';
with 'Venus::Role::Pluggable';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    value => $data,
  };
}

# METHODS

sub cast {
  my ($self, @args) = @_;

  require Venus::Type;

  my $value = $self->can('value') ? $self->value : $self;

  return Venus::Type->new(value => $value)->cast(@args);
}

sub defined {
  my ($self) = @_;

  return int(CORE::defined($self->get));
}

sub explain {
  my ($self) = @_;

  return $self->get;
}

sub TO_JSON {
  my ($self) = @_;

  return $self->get;
}

1;



=head1 NAME

Venus::Kind::Value - Value Base Class

=cut

=head1 ABSTRACT

Value Base Class for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  base 'Venus::Kind::Value';

  package main;

  my $example = Example->new;

  # $example->defined;

=cut

=head1 DESCRIPTION

This package provides identity and methods common across all L<Venus> value
classes.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind>

=cut

=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Accessible>

L<Venus::Role::Buildable>

L<Venus::Role::Explainable>

L<Venus::Role::Pluggable>

L<Venus::Role::Valuable>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 cast

  cast(Str $kind) (Object | Undef)

The cast method converts L<"value"|Venus::Kind::Value> objects between
different I<"value"> object types, based on the name of the type provided. This
method will return C<undef> if the invocant is not a L<Venus::Kind::Value>.

I<Since C<0.08>>

=over 4

=item cast example 1

  package main;

  my $example = Example->new;

  my $cast = $example->cast;

  # bless({value => undef}, "Venus::Undef")

=back

=over 4

=item cast example 2

  package main;

  my $example = Example->new(
    value => 123.45,
  );

  my $cast = $example->cast('array');

  # bless({value => [123.45]}, "Venus::Array")

=back

=over 4

=item cast example 3

  package main;

  my $example = Example->new(
    value => 123.45,
  );

  my $cast = $example->cast('hash');

  # bless({value => {'123.45' => 123.45}, "Venus::Hash")

=back

=cut

=head2 defined

  defined() (Int)

The defined method returns truthy or falsy if the underlying value is
L</defined>.

I<Since C<0.01>>

=over 4

=item defined example 1

  package main;

  my $example = Example->new;

  my $defined = $example->defined;

  # 0

=back

=over 4

=item defined example 2

  package main;

  my $example = Example->new(time);

  my $defined = $example->defined;

  # 1

=back

=cut

=head2 explain

  explain() (Any)

The explain method returns the value set and is used in stringification
operations.

I<Since C<0.01>>

=over 4

=item explain example 1

  package main;

  my $example = Example->new('hello, there');

  my $explain = $example->explain;

  # "hello, there"

=back

=cut