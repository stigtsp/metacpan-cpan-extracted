package Venus::Role::Catchable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Tryable')) {
    die "${self} requires ${from} to consume Venus::Role::Tryable";
  }

  return $self;
}

# METHODS

sub catch {
  my ($self, $method, @args) = @_;

  my @result = $self->try($method, @args)->error(\my $error)->result;

  return wantarray ? ($error ? ($error, undef) : ($error, @result)) : $error;
}

# EXPORTS

sub EXPORT {
  ['catch']
}

1;



=head1 NAME

Venus::Role::Catchable - Catchable Role

=cut

=head1 ABSTRACT

Catchable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  use Venus 'error';

  with 'Venus::Role::Tryable';
  with 'Venus::Role::Catchable';

  sub pass {
    true;
  }

  sub fail {
    error;
  }

  package main;

  my $example = Example->new;

  # my $error = $example->catch('fail');

=cut

=head1 DESCRIPTION

This package modifies the consuming package and provides methods for trapping
errors thrown from dispatched method calls.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 catch

  catch(Str $method, Any @args) (Any)

The catch method traps any errors raised by executing the dispatched method
call and returns the error string or error object. This method can return a
list of values in list-context. This method supports dispatching, i.e.
providing a method name and arguments whose return value will be acted on by
this method.

I<Since C<0.01>>

=over 4

=item catch example 1

  package main;

  my $example = Example->new;

  my $catch = $example->catch('fail');

  # bless({...}, "Venus::Error")

=back

=over 4

=item catch example 2

  package main;

  my $example = Example->new;

  my $catch = $example->catch('pass');

  # undef

=back

=over 4

=item catch example 3

  package main;

  my $example = Example->new;

  my ($catch, $result) = $example->catch('pass');

  # (undef, 1)

=back

=over 4

=item catch example 4

  package main;

  my $example = Example->new;

  my ($catch, $result) = $example->catch('fail');

  # (bless({...}, "Venus::Error"), undef)

=back

=cut