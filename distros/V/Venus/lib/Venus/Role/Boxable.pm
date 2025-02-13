package Venus::Role::Boxable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub box {
  my ($self, $method, @args) = @_;

  require Venus::Box;

  my $value = $method ? $self->$method(@args) : $self;

  return Venus::Box->new(value => $value);
}

# EXPORTS

sub EXPORT {
  ['box']
}

1;



=head1 NAME

Venus::Role::Boxable - Boxable Role

=cut

=head1 ABSTRACT

Boxable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  with 'Venus::Role::Boxable';

  attr 'text';

  package main;

  my $example = Example->new(text => 'hello, world');

  # $example->box('text')->lc->ucfirst->concat('.')->unbox->get;

  # "Hello, world."

=cut

=head1 DESCRIPTION

This package modifies the consuming package and provides a method for boxing
itself. This makes it possible to chain method calls across objects and values.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 box

  box(Str | CodeRef $method, Any @args) (Self)

The box method returns the invocant boxed, i.e. encapsulated, using
L<Venus::Box>. This method supports dispatching, i.e. providing a method name
and arguments whose return value will be acted on by this method.

I<Since C<0.01>>

=over 4

=item box example 1

  package main;

  my $example = Example->new(text => 'hello, world');

  my $box = $example->box;

  # bless({ value => bless(..., "Example") }, "Venus::Box")

=back

=over 4

=item box example 2

  package main;

  my $example = Example->new(text => 'hello, world');

  my $box = $example->box('text');

  # bless({ value => bless(..., "Venus::String") }, "Venus::Box")

  # $example->box('text')->lc->ucfirst->concat('.')->unbox->get;

=back

=cut