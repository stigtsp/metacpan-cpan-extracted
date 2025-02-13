package Venus::Regexp;

use 5.018;

use strict;
use warnings;

use Venus::Class;

base 'Venus::Kind::Value';

use overload (
  'eq' => sub{"$_[0]" eq "$_[1]"},
  'ne' => sub{"$_[0]" ne "$_[1]"},
  'qr' => sub{$_[0]->value},
  fallback => 1,
);

# METHODS

sub comparer {
  my ($self) = @_;

  return 'stringified';
}

sub default {
  return qr//;
}

sub replace {
  my ($self, $string, $substr, $flags) = @_;

  require Venus::Replace;

  my $replace = Venus::Replace->new(
    regexp => $self->get,
    string => $string // '',
    substr => $substr // '',
    flags => $flags // '',
  );

  return $replace->do('evaluate');
}

sub search {
  my ($self, $string) = @_;

  require Venus::Search;

  my $search = Venus::Search->new(
    regexp => $self->get,
    string => $string // '',
  );

  return $search->do('evaluate');
}

1;



=head1 NAME

Venus::Regexp - Regexp Class

=cut

=head1 ABSTRACT

Regexp Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<greet>\w+) (?<username>\w+)/u,
  );

  # $regexp->search;

=cut

=head1 DESCRIPTION

This package provides methods for manipulating regexp data.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind::Value>

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

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('array');

  # bless({ value => [qr/(?^u:)/] }, "Venus::Array")

=back

=over 4

=item cast example 2

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('boolean');

  # bless({ value => 1 }, "Venus::Boolean")

=back

=over 4

=item cast example 3

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('code');

  # bless({ value => sub { ... } }, "Venus::Code")

=back

=over 4

=item cast example 4

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('float');

  # bless({ value => "1.0" }, "Venus::Float")

=back

=over 4

=item cast example 5

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('hash');

  # bless({ value => { "0" => qr/(?^u:)/ } }, "Venus::Hash")

=back

=over 4

=item cast example 6

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('number');

  # bless({ value => 5 }, "Venus::Number")

=back

=over 4

=item cast example 7

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('regexp');

  # bless({ value => qr/(?^u:)/ }, "Venus::Regexp")

=back

=over 4

=item cast example 8

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('scalar');

  # bless({ value => \qr/(?^u:)/ }, "Venus::Scalar")

=back

=over 4

=item cast example 9

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('string');

  # bless({ value => "qr//u" }, "Venus::String")

=back

=over 4

=item cast example 10

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  my $cast = $regexp->cast('undef');

  # bless({ value => undef }, "Venus::Undef")

=back

=cut

=head2 default

  default() (Regexp)

The default method returns the default value, i.e. C<qr//>.

I<Since C<0.01>>

=over 4

=item default example 1

  # given: synopsis;

  my $default = $regexp->default;

  # qr/(?^u:)/

=back

=cut

=head2 eq

  eq(Any $arg) (Bool)

The eq method performs an I<"equals"> operation using the argument provided.

I<Since C<0.08>>

=over 4

=item eq example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=back

=over 4

=item eq example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=cut

=head2 ge

  ge(Any $arg) (Bool)

The ge method performs a I<"greater-than-or-equal-to"> operation using the
argument provided.

I<Since C<0.08>>

=over 4

=item ge example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=back

=over 4

=item ge example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=back

=over 4

=item ge example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=cut

=head2 gele

  gele(Any $arg1, Any $arg2) (Bool)

The gele method performs a I<"greater-than-or-equal-to"> operation on the 1st
argument, and I<"lesser-than-or-equal-to"> operation on the 2nd argument.

I<Since C<0.08>>

=over 4

=item gele example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=cut

=head2 gt

  gt(Any $arg) (Bool)

The gt method performs a I<"greater-than"> operation using the argument provided.

I<Since C<0.08>>

=over 4

=item gt example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=back

=over 4

=item gt example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=back

=over 4

=item gt example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=back

=over 4

=item gt example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=back

=over 4

=item gt example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=back

=over 4

=item gt example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=back

=cut

=head2 gtlt

  gtlt(Any $arg1, Any $arg2) (Bool)

The gtlt method performs a I<"greater-than"> operation on the 1st argument, and
I<"lesser-than"> operation on the 2nd argument.

I<Since C<0.08>>

=over 4

=item gtlt example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=cut

=head2 le

  le(Any $arg) (Bool)

The le method performs a I<"lesser-than-or-equal-to"> operation using the
argument provided.

I<Since C<0.08>>

=over 4

=item le example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->le($rvalue);

  # 0

=back

=over 4

=item le example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->le($rvalue);

  # 0

=back

=over 4

=item le example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->le($rvalue);

  # 0

=back

=over 4

=item le example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->le($rvalue);

  # 0

=back

=over 4

=item le example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->le($rvalue);

  # 0

=back

=over 4

=item le example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->le($rvalue);

  # 0

=back

=cut

=head2 lt

  lt(Any $arg) (Bool)

The lt method performs a I<"lesser-than"> operation using the argument provided.

I<Since C<0.08>>

=over 4

=item lt example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=back

=over 4

=item lt example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=back

=over 4

=item lt example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=cut

=head2 ne

  ne(Any $arg) (Bool)

The ne method performs a I<"not-equal-to"> operation using the argument provided.

I<Since C<0.08>>

=over 4

=item ne example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=back

=over 4

=item ne example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=cut

=head2 numified

  numified() (Int)

The numified method returns the numerical representation of the object. For
regexp objects the method returns the length (or character count) of the
stringified object.

I<Since C<0.08>>

=over 4

=item numified example 1

  # given: synopsis;

  my $numified = $regexp->numified;

  # 36

=back

=over 4

=item numified example 2

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/.*/u,
  );

  my $numified = $regexp->numified;

  # 7

=back

=cut

=head2 replace

  replace(Str $string, Str $substr, Str $flags) (Replace)

The replace method performs a regular expression substitution on the given
string. The first argument is the string to match against. The second argument
is the replacement string. The optional third argument might be a string
representing flags to append to the s///x operator, such as 'g' or 'e'.  This
method will always return a L<Venus::Replace> object which can be used to
introspect the result of the operation.

I<Since C<0.01>>

=over 4

=item replace example 1

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<username>\w+)$/,
  );

  my $replace = $regexp->replace('Hey, unknown', 'awncorp');

  # bless({ ... }, 'Venus::Replace')

=back

=cut

=head2 search

  search(Str $string) (Search)

The search method performs a regular expression match against the given string,
this method will always return a L<Venus::Search> object which can be used to
introspect the result of the operation.

I<Since C<0.01>>

=over 4

=item search example 1

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<greet>\w+), (?<username>\w+)/,
  );

  my $search = $regexp->search('hey, awncorp');

  # bless({ ... }, 'Venus::Search')

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

  my $stringified = $regexp->stringified;

  # qr/(?<greet>\w+) (?<username>\w+)/u




=back

=over 4

=item stringified example 2

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/.*/,
  );

  my $stringified = $regexp->stringified;

  # qr/.*/u

=back

=cut

=head2 tv

  tv(Any $arg) (Bool)

The tv method performs a I<"type-and-value-equal-to"> operation using argument
provided.

I<Since C<0.08>>

=over 4

=item tv example 1

  package main;

  use Venus::Array;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 2

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 3

  package main;

  use Venus::Float;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 4

  package main;

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 5

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 6

  package main;

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->tv($rvalue);

  # 1

=back

=over 4

=item tv example 7

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 8

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 9

  package main;

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=cut

=head1 OPERATORS

This package overloads the following operators:

=cut

=over 4

=item operation: C<(eq)>

This package overloads the C<eq> operator.

B<example 1>

  # given: synopsis;

  my $result = $regexp eq '(?^u:(?<greet>\\w+) (?<username>\\w+))';

  # 1

=back

=over 4

=item operation: C<(ne)>

This package overloads the C<ne> operator.

B<example 1>

  # given: synopsis;

  my $result = $regexp ne '(?<greet>\w+) (?<username>\w+)';

  # 1

=back

=over 4

=item operation: C<(qr)>

This package overloads the C<qr> operator.

B<example 1>

  # given: synopsis;

  my $result = 'Hello Friend' =~  $regexp;

  # 1

=back