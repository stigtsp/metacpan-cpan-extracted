package Venus::Match;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';

use Scalar::Util ();

# ATTRIBUTES

attr 'on_none';
attr 'on_only';
attr 'on_then';
attr 'on_when';

# BUILDERS

sub build_self {
  my ($self, $data) = @_;

  $self->on_none(sub{}) if !$self->on_none;
  $self->on_only(sub{1}) if !$self->on_only;
  $self->on_then([]) if !$self->on_then;
  $self->on_when([]) if !$self->on_when;

  return $self;
}

# METHODS

sub data {
  my ($self, $data) = @_;

  while(my($key, $value) = each(%$data)) {
    $self->just($key)->then($value);
  }

  return $self;
}

sub expr {
  my ($self, $topic) = @_;

  $self->when(sub{
    my $value = $self->value;

    if (!defined $value) {
      return 0;
    }
    if (Scalar::Util::blessed($value) && !overload::Overloaded($value)) {
      return 0;
    }
    if (!Scalar::Util::blessed($value) && ref($value)) {
      return 0;
    }
    if (ref($topic) eq 'Regexp' && "$value" =~ qr/$topic/) {
      return 1;
    }
    elsif ("$value" eq "$topic") {
      return 1;
    }
    else {
      return 0;
    }
  });

  return $self;
}

sub just {
  my ($self, $topic) = @_;

  $self->when(sub{
    my $value = $self->value;

    if (!defined $value) {
      return 0;
    }
    if (Scalar::Util::blessed($value) && !overload::Overloaded($value)) {
      return 0;
    }
    if (!Scalar::Util::blessed($value) && ref($value)) {
      return 0;
    }
    if ("$value" eq "$topic") {
      return 1;
    }
    else {
      return 0;
    }
  });

  return $self;
}

sub none {
  my ($self, $code) = @_;

  $self->on_none(UNIVERSAL::isa($code, 'CODE') ? $code : sub{$code});

  return $self;
}

sub only {
  my ($self, $code) = @_;

  $self->on_only($code);

  return $self;
}

sub result {
  my ($self) = @_;

  my $result;
  my $matched = 0;

  my $value = $self->value;

  local $_ = $value;

  return wantarray ? ($result, $matched) : $result if !$self->on_only->($value);

  for (my $i = 0; $i < @{$self->on_when}; $i++) {
    if ($self->on_when->[$i]->($value)) {
      $result = $self->on_then->[$i]->($value);
      $matched++;
      last;
    }
  }

  if (!$matched) {
    local $_ = $value;
    $result = $self->on_none->($value);
  }

  return wantarray ? ($result, $matched) : $result;
}

sub test {
  my ($self) = @_;

  my $matched = 0;

  my $value = $self->value;

  local $_ = $value;

  return $matched if !$self->on_only->($value);

  for (my $i = 0; $i < @{$self->on_when}; $i++) {
    if ($self->on_when->[$i]->($value)) {
      $matched++;
      last;
    }
  }

  return $matched;
}

sub then {
  my ($self, $code) = @_;

  my $next = $#{$self->on_when};

  $self->on_then->[$next] = UNIVERSAL::isa($code, 'CODE') ? $code : sub{$code};

  return $self;
}

sub when {
  my ($self, $code, @args) = @_;

  my $next = (@{$self->on_when}-$#{$self->on_then}) > 1 ? -1 : @{$self->on_when};

  $self->on_when->[$next] = sub {
    local $_ = $self->value;
    $self->value->$code(@args);
  };

  return $self;
}

1;



=head1 NAME

Venus::Match - Match Class

=cut

=head1 ABSTRACT

Match Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Match;

  my $match = Venus::Match->new(5);

  $match->when(sub{$_ < 5})->then(sub{"< 5"});
  $match->when(sub{$_ > 5})->then(sub{"> 5"});

  $match->none(sub{"?"});

  my $result = $match->result;

  # "?"

=cut

=head1 DESCRIPTION

This package provides an object-oriented interface for complex pattern matching
operations.

=cut

=head1 ATTRIBUTES

This package has the following attributes:

=cut

=head2 on_none

  on_none(CodeRef)

This attribute is read-write, accepts C<(CodeRef)> values, is optional, and defaults to C<sub{}>.

=cut

=head2 on_only

  on_only(CodeRef)

This attribute is read-write, accepts C<(CodeRef)> values, is optional, and defaults to C<sub{1}>.

=cut

=head2 on_then

  on_then(ArrayRef[CodeRef])

This attribute is read-write, accepts C<(ArrayRef[CodeRef])> values, is optional, and defaults to C<[]>.

=cut

=head2 on_when

  on_when(ArrayRef[CodeRef])

This attribute is read-write, accepts C<(ArrayRef[CodeRef])> values, is optional, and defaults to C<[]>.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind::Utility>

=cut

=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Accessible>

L<Venus::Role::Buildable>

L<Venus::Role::Valuable>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 data

  data(HashRef $data) (Match)

The data method takes a hashref (i.e. lookup table) and match conditions and
actions based on the keys and values found.

I<Since C<0.07>>

=over 4

=item data example 1

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->data({
    'a' => 'b',
    'c' => 'd',
    'e' => 'f',
    'g' => 'h',
  });

  my $result = $match->none('z')->result;

  # "b"

=back

=over 4

=item data example 2

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('x');

  $match->data({
    'a' => 'b',
    'c' => 'd',
    'e' => 'f',
    'g' => 'h',
  });

  my $result = $match->none('z')->result;

  # "z"

=back

=cut

=head2 expr

  expr(Str | RegexpRef $expr) (Match)

The expr method registers a L</when> condition that check if the match value is
an exact string match of the C<$topic> if the topic is a string, or that it
matches against the topic if the topic is a regular expression.

I<Since C<0.07>>

=over 4

=item expr example 1

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('1901-01-01');

  $match->expr('1901-01-01')->then(sub{[split /-/]});

  my $result = $match->result;

  # ["1901", "01", "01"]

=back

=over 4

=item expr example 2

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('1901-01-01');

  $match->expr(qr/^1901-/)->then(sub{[split /-/]});

  my $result = $match->result;

  # ["1901", "01", "01"]

=back

=cut

=head2 just

  just(Str $topic) (Match)

The just method registers a L</when> condition that check if the match value is
an exact string match of the C<$topic> provided.

I<Since C<0.03>>

=over 4

=item just example 1

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result;

  # "a"

=back

=over 4

=item just example 2

  package main;

  use Venus::Match;
  use Venus::String;

  my $match = Venus::Match->new(Venus::String->new('a'));

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result;

  # "a"

=back

=over 4

=item just example 3

  package main;

  use Venus::Match;
  use Venus::String;

  my $match = Venus::Match->new(Venus::String->new('c'));

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result;

  # "c"

=back

=over 4

=item just example 4

  package main;

  use Venus::Match;

  my $match = Venus::Match->new(1.23);

  $match->just('1.230')->then('1.230');
  $match->just(01.23)->then('123');
  $match->just(1.230)->then(1.23);

  my $result = $match->result;

  # "1.23"

=back

=over 4

=item just example 5

  package main;

  use Venus::Match;
  use Venus::Number;

  my $match = Venus::Match->new(Venus::Number->new(1.23));

  $match->just('1.230')->then('1.230');
  $match->just(01.23)->then('123');
  $match->just(1.230)->then(1.23);

  my $result = $match->result;

  # "1.23"

=back

=over 4

=item just example 6

  package main;

  use Venus::Match;
  use Venus::Number;

  my $match = Venus::Match->new(1.23);

  $match->just(Venus::Number->new('1.230'))->then('1.230');
  $match->just(Venus::Number->new(01.23))->then('123');
  $match->just(Venus::Number->new(1.230))->then(1.23);

  my $result = $match->result;

  # "1.23"

=back

=cut

=head2 none

  none(CodeRef $code) (Match)

The none method registers a special condition that returns a result only when
no other conditions have been matched.

I<Since C<0.03>>

=over 4

=item none example 1

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('z');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  $match->none('z');

  my $result = $match->result;

  # "z"

=back

=over 4

=item none example 2

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('z');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  $match->none(sub{"($_) not found"});

  my $result = $match->result;

  # "(z) not found"

=back

=cut

=head2 only

  only(CodeRef $code) (Match)

The only method registers a special condition that only allows matching on the
match value only if the code provided returns truthy.

I<Since C<0.03>>

=over 4

=item only example 1

  package main;

  use Venus::Match;

  my $match = Venus::Match->new(5);

  $match->only(sub{$_ != 5});

  $match->just(5)->then(5);
  $match->just(6)->then(6);

  my $result = $match->result;

  # undef

=back

=over 4

=item only example 2

  package main;

  use Venus::Match;

  my $match = Venus::Match->new(6);

  $match->only(sub{$_ != 5});

  $match->just(5)->then(5);
  $match->just(6)->then(6);

  my $result = $match->result;

  # 6

=back

=cut

=head2 result

  result() (Any)

The result method evaluates the registered conditions and returns the result of
the action (i.e. the L</then> code) or the special L</none> condition if there
were no matches. In list context, this method returns both the result and
whether or not a condition matched.

I<Since C<0.03>>

=over 4

=item result example 1

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result;

  # "a"

=back

=over 4

=item result example 2

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my ($result, $matched) = $match->result;

  # ("a", 1)

=back

=over 4

=item result example 3

  package main;

  use Venus::Match;

  sub fibonacci {
    my ($n) = @_;
    my $match = Venus::Match->new($n)
      ->just(1)->then(1)
      ->just(2)->then(1)
      ->none(sub{fibonacci($n - 1) + fibonacci($n - 2)})
      ->result
  }

  my $result = [fibonacci(4), fibonacci(6), fibonacci(12)]

  # [3, 8, 144]

=back

=cut

=head2 then

  then(CodeRef $code) (Match)

The then method registers an action to be executed if the corresponding match
condition returns truthy.

I<Since C<0.03>>

=over 4

=item then example 1

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('b');

  $match->just('a');
  $match->then('a');

  $match->just('b');
  $match->then('b');

  my $result = $match->result;

  # "b"

=back

=over 4

=item then example 2

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('b');

  $match->just('a');
  $match->then('a');

  $match->just('b');
  $match->then('b');
  $match->then('x');

  my $result = $match->result;

  # "x"

=back

=cut

=head2 when

  when(Str | CodeRef $code, Any @args) (Match)

The when method registers a match condition that will be passed the match value
during evaluation. If the match condition returns truthy the corresponding
action will be used to return a result. If the match value is an object, this
method can take a method name and arguments which will be used as a match
condition.

I<Since C<0.03>>

=over 4

=item when example 1

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->when(sub{$_ eq 'a'});
  $match->then('a');

  $match->when(sub{$_ eq 'b'});
  $match->then('b');

  $match->when(sub{$_ eq 'c'});
  $match->then('c');

  my $result = $match->result;

  # "a"

=back

=over 4

=item when example 2

  package main;

  use Venus::Match;
  use Venus::Type;

  my $match = Venus::Match->new(Venus::Type->new(1)->deduce);

  $match->when('isa', 'Venus::Number');
  $match->then('Venus::Number');

  $match->when('isa', 'Venus::String');
  $match->then('Venus::String');

  my $result = $match->result;

  # "Venus::Number"

=back

=over 4

=item when example 3

  package main;

  use Venus::Match;
  use Venus::Type;

  my $match = Venus::Match->new(Venus::Type->new('1')->deduce);

  $match->when('isa', 'Venus::Number');
  $match->then('Venus::Number');

  $match->when('isa', 'Venus::String');
  $match->then('Venus::String');

  my $result = $match->result;

  # "Venus::String"

=back

=cut