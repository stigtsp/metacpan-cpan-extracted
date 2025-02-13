package Venus::Role::Mappable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDIT

sub AUDIT {
  my ($self, $from) = @_;

  my $name = ref $self || $self;

  if (!$from->can('all')) {
    die "${from} requires 'all' to consume ${name}";
  }

  if (!$from->can('any')) {
    die "${from} requires 'any' to consume ${name}";
  }

  if (!$from->can('call')) {
    die "${from} requires 'call' to consume ${name}";
  }

  if (!$from->can('count')) {
    die "${from} requires 'count' to consume ${name}";
  }

  if (!$from->can('delete')) {
    die "${from} requires 'delete' to consume ${name}";
  }

  if (!$from->can('each')) {
    die "${from} requires 'each' to consume ${name}";
  }

  if (!$from->can('empty')) {
    die "${from} requires 'empty' to consume ${name}";
  }

  if (!$from->can('exists')) {
    die "${from} requires 'exists' to consume ${name}";
  }

  if (!$from->can('grep')) {
    die "${from} requires 'grep' to consume ${name}";
  }

  if (!$from->can('iterator')) {
    die "${from} requires 'iterator' to consume ${name}";
  }

  if (!$from->can('keys')) {
    die "${from} requires 'keys' to consume ${name}";
  }

  if (!$from->can('map')) {
    die "${from} requires 'map' to consume ${name}";
  }

  if (!$from->can('none')) {
    die "${from} requires 'none' to consume ${name}";
  }

  if (!$from->can('one')) {
    die "${from} requires 'one' to consume ${name}";
  }

  if (!$from->can('pairs')) {
    die "${from} requires 'pairs' to consume ${name}";
  }

  if (!$from->can('random')) {
    die "${from} requires 'random' to consume ${name}";
  }

  if (!$from->can('reverse')) {
    die "${from} requires 'reverse' to consume ${name}";
  }

  if (!$from->can('slice')) {
    die "${from} requires 'slice' to consume ${name}";
  }

  return $self;
}

1;



=head1 NAME

Venus::Role::Mappable - Mappable Role

=cut

=head1 ABSTRACT

Mappable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  with 'Venus::Role::Mappable';

  sub all;
  sub any;
  sub call;
  sub count;
  sub delete;
  sub each;
  sub empty;
  sub exists;
  sub grep;
  sub iterator;
  sub keys;
  sub map;
  sub none;
  sub one;
  sub pairs;
  sub random;
  sub reverse;
  sub slice;

  package main;

  my $example = Example->new;

  # $example->random;

=cut

=head1 DESCRIPTION

This package provides a specification for the consuming package to implement
methods that makes the object mappable. See L<Venus::Array> and L<Venus::Hash>
as other examples of mappable classes.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 all

  all(CodeRef $code) (Bool)

The all method should return true if the callback returns true for all of the
elements provided.

I<Since C<0.01>>

=over 4

=item all example 1

  # given: synopsis;

  my $all = $example->all(sub {
    # ...
  });

=back

=cut

=head2 any

  any(CodeRef $code) (Bool)

The any method should return true if the callback returns true for any of the
elements provided.




I<Since C<0.01>>

=over 4

=item any example 1

  # given: synopsis;

  my $any = $example->any(sub {
    # ...
  });

=back

=cut

=head2 count

  count() (Num)

The count method should return the number of top-level element in the data
structure.




I<Since C<0.01>>

=over 4

=item count example 1

  # given: synopsis;

  my $count = $example->count;

=back

=cut

=head2 delete

  delete(Str $key) (Any)

The delete method returns should remove the item in the data structure based on
the key provided, returning the item.




I<Since C<0.01>>

=over 4

=item delete example 1

  # given: synopsis;

  my $delete = $example->delete(...);

=back

=cut

=head2 each

  each(CodeRef $code) (ArrayRef)

The each method should execute the callback for each item in the data structure
passing the key and value as arguments.




I<Since C<0.01>>

=over 4

=item each example 1

  # given: synopsis;

  my $results = $example->each(sub {
    # ...
  });

=back

=cut

=head2 empty

  empty() (Value)

The empty method should drop all items from the data structure.




I<Since C<0.01>>

=over 4

=item empty example 1

  # given: synopsis;

  my $empty = $example->empty;

=back

=cut

=head2 exists

  exists(Str $key) (Bool)

The exists method should return true if the item at the key specified exists,
otherwise it returns false.




I<Since C<0.01>>

=over 4

=item exists example 1

  # given: synopsis;

  my $exists = $example->exists(...);

=back

=cut

=head2 grep

  grep(CodeRef $code) (ArrayRef)

The grep method should execute a callback for each item in the array, passing
the value as an argument, returning a value containing the items for which the
returned true.




I<Since C<0.01>>

=over 4

=item grep example 1

  # given: synopsis;

  my $results = $example->grep(sub {
    # ...
  });

=back

=cut

=head2 iterator

  iterator() (CodeRef)

The iterator method should return a code reference which can be used to iterate
over the data structure. Each time the iterator is executed it will return the
next item in the data structure until all items have been seen, at which point
the iterator will return an undefined value.




I<Since C<0.01>>

=over 4

=item iterator example 1

  # given: synopsis;

  my $iterator = $example->iterator;

=back

=cut

=head2 keys

  keys() (ArrayRef)

The keys method should return an array reference consisting of the keys of the
data structure.




I<Since C<0.01>>

=over 4

=item keys example 1

  # given: synopsis;

  my $keys = $example->keys;

=back

=cut

=head2 map

  map(CodeRef $code) (ArrayRef)

The map method should iterate over each item in the data structure, executing
the code reference supplied in the argument, passing the routine the value at
the current position in the loop and returning an array reference containing
the items for which the argument returns a value or non-empty list.




I<Since C<0.01>>

=over 4

=item map example 1

  # given: synopsis;

  my $results = $example->map(sub {
    # ...
  });

=back

=cut

=head2 none

  none(CodeRef $code) (Bool)

The none method should return true if none of the items in the data structure
meet the criteria set by the operand and rvalue.




I<Since C<0.01>>

=over 4

=item none example 1

  # given: synopsis;

  my $none = $example->none(sub {
    # ...
  });

=back

=cut

=head2 one

  one(CodeRef $code) (Bool)

The one method should return true if only one of the items in the data
structure meet the criteria set by the operand and rvalue.




I<Since C<0.01>>

=over 4

=item one example 1

  # given: synopsis;

  my $one = $example->one(sub {
    # ...
  });

=back

=cut

=head2 pairs

  pairs(CodeRef $code) (Tuple[ArrayRef, ArrayRef])

The pairs method should return an array reference of tuples where each tuple is
an array reference having two items corresponding to the key and value for each
item in the data structure.




I<Since C<0.01>>

=over 4

=item pairs example 1

  # given: synopsis;

  my $pairs = $example->pairs(sub {
    # ...
  });

=back

=cut

=head2 random

  random() (Any)

The random method should return a random item from the data structure.




I<Since C<0.01>>

=over 4

=item random example 1

  # given: synopsis;

  my $random = $example->random;

=back

=cut

=head2 reverse

  reverse() (ArrayRef)

The reverse method should returns an array reference containing the items in
the data structure in reverse order if the items in the data structure are
ordered.




I<Since C<0.01>>

=over 4

=item reverse example 1

  # given: synopsis;

  my $reverse = $example->reverse;

=back

=cut

=head2 slice

  slice(Str @keys) (ArrayRef)

The slice method should return a new data structure containing the elements in
the invocant at the key(s) specified in the arguments.




I<Since C<0.01>>

=over 4

=item slice example 1

  # given: synopsis;

  my $slice = $example->slice(...);

=back

=cut