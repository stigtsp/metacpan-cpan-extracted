package Venus::Role::Tryable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub try {
  my ($self, $callback, @args) = @_;

  require Venus::Try;

  my $try = Venus::Try->new(invocant => $self, arguments => [@args]);

  return $try if !$callback;

  return $try->call($callback);
}

# EXPORTS

sub EXPORT {
  ['try']
}

1;



=head1 NAME

Venus::Role::Tryable - Tryable Role

=cut

=head1 ABSTRACT

Tryable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class 'with';
  use Venus 'raise';

  with 'Venus::Role::Tryable';

  sub test {
    raise 'Example::Error';
  }

  package main;

  my $example = Example->new;

  # $example->try('test');

=cut

=head1 DESCRIPTION

This package modifies the consuming package and provides a mechanism for
handling potentially volatile routines.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 try

  try(Str | CodeRef $method, Any @args) (Try)

The try method returns a L<Venus::Try> object having the invocant, callback,
arguments pre-configured. This method supports dispatching, i.e. providing a
method name and arguments whose return value will be acted on by this method.

I<Since C<0.01>>

=over 4

=item try example 1

  package main;

  my $example = Example->new;

  my $try = $example->try('test');

  # my $value = $try->result;

=back

=cut