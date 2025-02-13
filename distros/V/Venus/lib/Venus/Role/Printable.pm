package Venus::Role::Printable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Dumpable')) {
    die "${self} requires ${from} to consume Venus::Role::Dumpable";
  }

  return $self;
}

# METHODS

sub print {
  my ($self, @args) = @_;

  return $self->printer($self->dump(@args));
}

sub print_pretty {
  my ($self, @args) = @_;

  return $self->printer($self->dump_pretty(@args));
}

sub print_string {
  my ($self, $method, @args) = @_;

  return $self->printer($method ? scalar($self->$method(@args)) : $self);
}

sub printer {
  my ($self, @args) = @_;

  return CORE::print(STDOUT @args);
}

sub say {
  my ($self, @args) = @_;

  return $self->printer($self->dump(@args), "\n");
}

sub say_pretty {
  my ($self, @args) = @_;

  return $self->printer($self->dump_pretty(@args), "\n");
}

sub say_string {
  my ($self, $method, @args) = @_;

  return $self->printer(($method ? scalar($self->$method(@args)) : $self), "\n");
}

# EXPORTS

sub EXPORT {
  [
    'print',
    'print_pretty',
    'print_string',
    'printer',
    'say',
    'say_pretty',
    'say_string',
  ]
}

1;



=head1 NAME

Venus::Role::Printable - Printable Role

=cut

=head1 ABSTRACT

Printable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  with 'Venus::Role::Dumpable';
  with 'Venus::Role::Printable';

  attr 'test';

  sub execute {
    return [@_];
  }

  sub printer {
    return [@_];
  }

  package main;

  my $example = Example->new(test => 123);

  # $example->say;

=cut

=head1 DESCRIPTION

This package provides a mechanism for outputting (printing) objects or the
return value of a dispatched method call to STDOUT.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 print

  print(Any @data) (Any)

The print method prints a stringified representation of the underlying data.

I<Since C<0.01>>

=over 4

=item print example 1

  package main;

  my $example = Example->new(test => 123);

  my $print = $example->print;

  # bless({test => 123}, 'Example')

  # 1

=back

=over 4

=item print example 2

  package main;

  my $example = Example->new(test => 123);

  my $print = $example->print('execute', 1, 2, 3);

  # [bless({test => 123}, 'Example'),1,2,3]

  # 1

=back

=cut

=head2 print_pretty

  print_pretty(Any @data) (Any)

The print_pretty method prints a stringified human-readable representation of
the underlying data.

I<Since C<0.01>>

=over 4

=item print_pretty example 1

  package main;

  my $example = Example->new(test => 123);

  my $print_pretty = $example->print_pretty;

  # bless({ test => 123 }, 'Example')

  # 1

=back

=over 4

=item print_pretty example 2

  package main;

  my $example = Example->new(test => 123);

  my $print_pretty = $example->print_pretty('execute', 1, 2, 3);

  # [
  #   bless({ test => 123 }, 'Example'),
  #   1,
  #   2,
  #   3
  # ]

  # 1

=back

=cut

=head2 print_string

  print_string(Str | CodeRef $method, Any @args) (Any)

The print_string method prints a string representation of the underlying data
without using a dump. This method supports dispatching, i.e. providing a
method name and arguments whose return value will be acted on by this method.

I<Since C<0.09>>

=over 4

=item print_string example 1

  package main;

  my $example = Example->new(test => 123);

  my $print_string = $example->print_string;

  # 'Example'

  # 1

=back

=cut

=head2 say

  say(Any @data) (Any)

The say method prints a stringified representation of the underlying data, with
a trailing newline.

I<Since C<0.01>>

=over 4

=item say example 1

  package main;

  my $example = Example->new(test => 123);

  my $say = $example->say;

  # bless({test => 123}, 'Example')\n

  # 1

=back

=over 4

=item say example 2

  package main;

  my $example = Example->new(test => 123);

  my $say = $example->say;

  # [bless({test => 123}, 'Example'),1,2,3]\n

  # 1

=back

=cut

=head2 say_pretty

  say_pretty(Any @data) (Any)

The say_pretty method prints a stringified human-readable representation of the
underlying data, with a trailing newline.

I<Since C<0.01>>

=over 4

=item say_pretty example 1

  package main;

  my $example = Example->new(test => 123);

  my $say_pretty = $example->say_pretty;

  # bless({ test => 123 }, 'Example')\n

  # 1

=back

=over 4

=item say_pretty example 2

  package main;

  my $example = Example->new(test => 123);

  my $say_pretty = $example->say_pretty;

  # [
  #   bless({ test => 123 }, 'Example'),
  #   1,
  #   2,
  #   3
  # ]\n

  # 1

=back

=cut

=head2 say_string

  say_string(Str | CodeRef $method, Any @args) (Any)

The say_string method prints a string representation of the underlying data
without using a dump, with a trailing newline. This method supports
dispatching, i.e. providing a method name and arguments whose return value will
be acted on by this method.

I<Since C<0.09>>

=over 4

=item say_string example 1

  package main;

  my $example = Example->new(test => 123);

  my $say_string = $example->say_string;

  # "Example\n"

  # 1

=back

=cut