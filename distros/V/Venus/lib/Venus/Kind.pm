package Venus::Kind;

use 5.018;

use strict;
use warnings;

use Venus::Class 'with';

with 'Venus::Role::Boxable';
with 'Venus::Role::Tryable';
with 'Venus::Role::Catchable';
with 'Venus::Role::Comparable';
with 'Venus::Role::Dumpable';
with 'Venus::Role::Digestable';
with 'Venus::Role::Doable';
with 'Venus::Role::Matchable';
with 'Venus::Role::Printable';
with 'Venus::Role::Testable';
with 'Venus::Role::Throwable';

# METHODS

sub class {
  my ($self) = @_;

  return ref($self) || $self;
}

sub checksum {
  my ($self) = @_;

  return $self->digest('md5', 'stringified');
}

sub comparer {
  my ($self, $operation) = @_;

  if (lc($operation) eq 'eq') {
    return 'checksum';
  }
  if (lc($operation) eq 'gt') {
    return 'numified';
  }
  if (lc($operation) eq 'lt') {
    return 'numified';
  }
  else {
    return 'stringified';
  }
}

sub numified {
  my ($self) = @_;

  return CORE::length($self->stringified);
}

sub safe {
  my ($self, $method, @args) = @_;

  my $result = $self->trap($method, @args);

  return(wantarray ? (@$result) : $result->[0]);
}

sub space {
  my ($self) = @_;

  require Venus::Space;

  return Venus::Space->new($self->class);
}

sub stringified {
  my ($self) = @_;

  return $self->dump($self->can('value') ? 'value' : ());
}

sub trap {
  my ($self, $method, @args) = @_;

  no strict;
  no warnings;

  my $result = [[],[],[]];

  return(wantarray ? (@$result) : $result->[0]) if !$method;

  local ($!, $?, $@, $^E);

  local $SIG{__DIE__} = sub{
    push @{$result->[2]}, @_;
  };

  local $SIG{__WARN__} = sub{
    push @{$result->[1]}, @_;
  };

  push @{$result->[0]}, eval {
    local $_ = $self;
    $self->$method(@args);
  };

  return(wantarray ? (@$result) : $result->[0]);
}

sub type {
  my ($self, $method, @args) = @_;

  require Venus::Type;

  my $value = $method
    ? $self->$method(@args) : $self->can('value') ? $self->value : $self;

  return Venus::Type->new(value => $value);
}

1;



=head1 NAME

Venus::Kind - Kind Base Class

=cut

=head1 ABSTRACT

Kind Base Class for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  base 'Venus::Kind';

  package main;

  my $example = Example->new;

=cut

=head1 DESCRIPTION

This package provides identity and methods common across all L<Venus> classes.

=cut

=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Boxable>

L<Venus::Role::Catchable>

L<Venus::Role::Comparable>

L<Venus::Role::Digestable>

L<Venus::Role::Doable>

L<Venus::Role::Dumpable>

L<Venus::Role::Matchable>

L<Venus::Role::Printable>

L<Venus::Role::Testable>

L<Venus::Role::Throwable>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 checksum

  checksum() (Str)

The checksum method returns an md5 hash string representing the stringified
object value (or the object itself).

I<Since C<0.08>>

=over 4

=item checksum example 1

  # given: synopsis;

  my $checksum = $example->checksum;

  # "859a86eed4b2d97eb7b830b02f06de32"

=back

=over 4

=item checksum example 2

  package Checksum::Example;

  use Venus::Class;

  base 'Venus::Kind';

  attr 'value';

  package main;

  my $example = Checksum::Example->new(value => 'example');

  my $checksum = $example->checksum;

  # "1a79a4d60de6718e8e5b326e338ae533"

=back

=cut

=head2 class

  class() (Str)

The class method returns the class name for the given class or object.

I<Since C<0.01>>

=over 4

=item class example 1

  # given: synopsis;

  my $class = $example->class;

  # "Example"

=back

=cut

=head2 numified

  numified() (Int)

The numified method returns the numerical representation of the object which is
typically the length (or character count) of the stringified object.

I<Since C<0.08>>

=over 4

=item numified example 1

  # given: synopsis;

  my $numified = $example->numified;

  # 22

=back

=over 4

=item numified example 2

  package Numified::Example;

  use Venus::Class;

  base 'Venus::Kind';

  attr 'value';

  package main;

  my $example = Numified::Example->new(value => 'example');

  my $numified = $example->numified;

  # 7

=back

=cut

=head2 safe

  safe(Str | CodeRef $code, Any @args) (Any)

The safe method dispatches the method call or executes the callback and returns
the result, supressing warnings and exceptions. If an exception is thrown this
method will return C<undef>. This method supports dispatching, i.e. providing a
method name and arguments whose return value will be acted on by this method.

I<Since C<0.08>>

=over 4

=item safe example 1

  # given: synopsis;

  my $safe = $example->safe('class');

  # "Example"

=back

=over 4

=item safe example 2

  # given: synopsis;

  my $safe = $example->safe(sub {
    ${_}->class / 2
  });

  # '0'

=back

=over 4

=item safe example 3

  # given: synopsis;

  my $safe = $example->safe(sub {
    die;
  });

  # undef

=back

=cut

=head2 space

  space() (Space)

The space method returns a L<Venus::Space> object for the given object.

I<Since C<0.01>>

=over 4

=item space example 1

  # given: synopsis;

  my $space = $example->space;

  # bless({ value => "Example" }, "Venus::Space")

=back

=cut

=head2 stringified

  stringified() (Str)

The stringified method returns the object, stringified (i.e. a dump of the
object's value).

I<Since C<0.08>>

=over 4

=item stringified example 1

  # given: synopsis;

  my $stringified = $example->stringified;

  # bless({}, 'Example')




=back

=over 4

=item stringified example 2

  package Stringified::Example;

  use Venus::Class;

  base 'Venus::Kind';

  attr 'value';

  package main;

  my $example = Stringified::Example->new(value => 'example');

  my $stringified = $example->stringified;

  # "example"

=back

=cut

=head2 trap

  trap(Str | CodeRef $code, Any @args) (Tuple[ArrayRef, ArrayRef, ArrayRef])

The trap method dispatches the method call or executes the callback and returns
a tuple (i.e. a 3-element arrayref) with the results, warnings, and exceptions
from the code execution. If an exception is thrown, the results (i.e. the
1st-element) will be an empty arrayref. This method supports dispatching, i.e.
providing a method name and arguments whose return value will be acted on by
this method.

I<Since C<0.08>>

=over 4

=item trap example 1

  # given: synopsis;

  my $result = $example->trap('class');

  # ["Example"]

=back

=over 4

=item trap example 2

  # given: synopsis;

  my ($results, $warnings, $errors) = $example->trap('class');

  # (["Example"], [], [])

=back

=over 4

=item trap example 3

  # given: synopsis;

  my $trap = $example->trap(sub {
    ${_}->class / 2
  });

  # ["0"]

=back

=over 4

=item trap example 4

  # given: synopsis;

  my ($results, $warnings, $errors) = $example->trap(sub {
    ${_}->class / 2
  });

  # (["0"], ["Argument ... isn't numeric in division ..."], [])

=back

=over 4

=item trap example 5

  # given: synopsis;

  my $trap = $example->trap(sub {
    die;
  });

  # []

=back

=over 4

=item trap example 6

  # given: synopsis;

  my ($results, $warnings, $errors) = $example->trap(sub {
    die;
  });

  # ([], [], ["Died..."])

=back

=cut

=head2 type

  type() (Type)

The type method returns a L<Venus::Type> object for the given object.

I<Since C<0.01>>

=over 4

=item type example 1

  # given: synopsis;

  my $type = $example->type;

  # bless({ value => bless({}, "Example") }, "Venus::Type")

=back

=cut