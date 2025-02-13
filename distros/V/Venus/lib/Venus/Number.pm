package Venus::Number;

use 5.018;

use strict;
use warnings;

use Venus::Class;

base 'Venus::Kind::Value';

use overload (
  '!' => sub{!$_[0]->get},
  '!=' => sub{$_[0]->get != ($_[1] + 0)},
  '%' => sub{$_[0]->get % ($_[1] + 0)},
  '*' => sub{$_[0]->get * ($_[1] + 0)},
  '+' => sub{$_[0]->get + ($_[1] + 0)},
  '-' => sub{$_[0]->get - ($_[1] + 0)},
  '.' => sub{$_[0]->get . ($_[1] + 0)},
  '/' => sub{$_[0]->get / ($_[1] + 0)},
  '0+' => sub{$_[0]->get + 0},
  '<' => sub{$_[0]->get < ($_[1] + 0)},
  '<=' => sub{$_[0]->get <= ($_[1] + 0)},
  '==' => sub{$_[0]->get == ($_[1] + 0)},
  '>' => sub{$_[0]->get > ($_[1] + 0)},
  '>=' => sub{$_[0]->get >= ($_[1] + 0)},
  'bool' => sub{$_[0]->get + 0},
  'eq' => sub{"$_[0]" eq "$_[1]"},
  'ne' => sub{"$_[0]" ne "$_[1]"},
  'qr' => sub{qr/@{[quotemeta($_[0]->get)]}/},
  'x' => sub{$_[0]->get x ($_[1] + 0)},
  fallback => 1,
);

# METHODS

sub abs {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::abs($data);
}

sub atan2 {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return CORE::atan2($data, $arg + 0);
}

sub comparer {
  my ($self) = @_;

  return 'numified';
}

sub cos {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::cos($data);
}

sub decr {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data - (($arg || 1) + 0);
}

sub default {
  return 0;
}

sub exp {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::exp($data);
}

sub hex {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::sprintf('%#x', $data);
}

sub incr {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data + (($arg || 1) + 0);
}

sub int {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::int($data);
}

sub log {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::log($data);
}

sub mod {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data % ($arg + 0);
}

sub neg {
  my ($self) = @_;

  my $data = $self->get;

  return $data =~ /^-(.*)/ ? $1 : -$data;
}

sub numified {
  my ($self) = @_;

  my $data = $self->get;

  return 0 + $data;
}

sub pow {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data ** ($arg + 0);
}

sub range {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return [
    ($data > ($arg + 0)) ? CORE::reverse(($arg + 0)..$data) : ($data..($arg + 0))
  ];
}

sub sin {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::sin($data);
}

sub sqrt {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::sqrt($data);
}

1;



=head1 NAME

Venus::Number - Number Class

=cut

=head1 ABSTRACT

Number Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1_000);

  # $number->abs;

=cut

=head1 DESCRIPTION

This package provides methods for manipulating number data.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind::Value>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 abs

  abs() (Num)

The abs method returns the absolute value of the number.

I<Since C<0.01>>

=over 4

=item abs example 1

  # given: synopsis;

  my $abs = $number->abs;

  # 1000

=back

=over 4

=item abs example 2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $abs = $number->abs;

  # 12

=back

=over 4

=item abs example 3

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(-12);

  my $abs = $number->abs;

  # 12

=back

=cut

=head2 atan2

  atan2() (Num)

The atan2 method returns the arctangent of Y/X in the range -PI to PI.

I<Since C<0.01>>

=over 4

=item atan2 example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1);

  my $atan2 = $number->atan2(1);

  # 0.785398163397448

=back

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

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('array');

  # bless({ value => [0] }, "Venus::Array")

=back

=over 4

=item cast example 2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('boolean');

  # bless({ value => 0 }, "Venus::Boolean")

=back

=over 4

=item cast example 3

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('code');

  # bless({ value => sub { ... } }, "Venus::Code")

=back

=over 4

=item cast example 4

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('float');

  # bless({ value => "0.0" }, "Venus::Float")

=back

=over 4

=item cast example 5

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('hash');

  # bless({ value => { "0" => 0 } }, "Venus::Hash")

=back

=over 4

=item cast example 6

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('number');

  # bless({ value => 0 }, "Venus::Number")

=back

=over 4

=item cast example 7

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('regexp');

  # bless({ value => qr/(?^u:0)/ }, "Venus::Regexp")

=back

=over 4

=item cast example 8

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('scalar');

  # bless({ value => \0 }, "Venus::Scalar")

=back

=over 4

=item cast example 9

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('string');

  # bless({ value => 0 }, "Venus::String")

=back

=over 4

=item cast example 10

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('undef');

  # bless({ value => undef }, "Venus::Undef")

=back

=cut

=head2 cos

  cos() (Num)

The cos method computes the cosine of the number (expressed in radians).

I<Since C<0.01>>

=over 4

=item cos example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $cos = $number->cos;

  # 0.843853958732492

=back

=cut

=head2 decr

  decr() (Num)

The decr method returns the numeric number decremented by 1.

I<Since C<0.01>>

=over 4

=item decr example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $decr = $number->decr;

  # 123456788

=back

=over 4

=item decr example 2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $decr = $number->decr(123456788);

  # 1

=back

=cut

=head2 default

  default() (Int)

The default method returns the default value, i.e. C<0>.

I<Since C<0.01>>

=over 4

=item default example 1

  # given: synopsis;

  my $default = $number->default;

  # 0

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=back

=over 4

=item eq example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=back

=over 4

=item eq example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=back

=over 4

=item eq example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=back

=over 4

=item eq example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=back

=cut

=head2 exp

  exp() (Num)

The exp method returns e (the natural logarithm base) to the power of the
number.

I<Since C<0.01>>

=over 4

=item exp example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(0);

  my $exp = $number->exp;

  # 1

=back

=over 4

=item exp example 2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1);

  my $exp = $number->exp;

  # 2.71828182845905

=back

=over 4

=item exp example 3

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1.5);

  my $exp = $number->exp;

  # 4.48168907033806

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=back

=over 4

=item ge example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=back

=over 4

=item ge example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=back

=over 4

=item ge example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=back

=over 4

=item ge example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=back

=over 4

=item ge example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=back

=over 4

=item ge example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=back

=over 4

=item gele example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=back

=over 4

=item gele example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=back

=over 4

=item gele example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=back

=over 4

=item gele example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gele($rvalue);

  # 1

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=back

=over 4

=item gt example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gt($rvalue);

  # 0

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=over 4

=item gtlt example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=back

=cut

=head2 hex

  hex() (Str)

The hex method returns a hex string representing the value of the number.

I<Since C<0.01>>

=over 4

=item hex example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(175);

  my $hex = $number->hex;

  # "0xaf"

=back

=cut

=head2 incr

  incr() (Num)

The incr method returns the numeric number incremented by 1.

I<Since C<0.01>>

=over 4

=item incr example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $incr = $number->incr;

  # 123456790

=back

=over 4

=item incr example 2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456790);

  my $incr = $number->incr(-1);

  # 123456789

=back

=cut

=head2 int

  int() (Int)

The int method returns the integer portion of the number. Do not use this
method for rounding.

I<Since C<0.01>>

=over 4

=item int example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12.5);

  my $int = $number->int;

  # 12

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=over 4

=item le example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->le($rvalue);

  # 1

=back

=cut

=head2 log

  log() (Num)

The log method returns the natural logarithm (base e) of the number.

I<Since C<0.01>>

=over 4

=item log example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $log = $number->log;

  # 9.42100640177928

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=back

=over 4

=item lt example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=back

=over 4

=item lt example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=back

=over 4

=item lt example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=back

=over 4

=item lt example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=back

=over 4

=item lt example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=over 4

=item lt example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=back

=cut

=head2 mod

  mod() (Int)

The mod method returns the division remainder of the number divided by the
argment.

I<Since C<0.01>>

=over 4

=item mod example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(1);

  # 0

=back

=over 4

=item mod example 2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(2);

  # 0

=back

=over 4

=item mod example 3

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(5);

  # 2

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=back

=over 4

=item ne example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=back

=over 4

=item ne example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=back

=over 4

=item ne example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=back

=over 4

=item ne example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=back

=cut

=head2 neg

  neg() (Num)

The neg method returns a negative version of the number.

I<Since C<0.01>>

=over 4

=item neg example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $neg = $number->neg;

  # -12345

=back

=cut

=head2 numified

  numified() (Int)

The numified method returns the numerical representation of the object. For
number objects this method returns the object's underlying value.

I<Since C<0.08>>

=over 4

=item numified example 1

  # given: synopsis;

  my $numified = $number->numified;

  # 1000

=back

=over 4

=item numified example 2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(2_000);

  my $numified = $number->numified;

  # 2000

=back

=over 4

=item numified example 3

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(10_000);

  my $numified = $number->numified;

  # 10000

=back

=cut

=head2 pow

  pow() (Num)

The pow method returns a number, the result of a math operation, which is the
number to the power of the argument.

I<Since C<0.01>>

=over 4

=item pow example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $pow = $number->pow(3);

  # 1881365963625

=back

=cut

=head2 range

  range() (ArrayRef)

The range method returns an array reference containing integer increasing values
up-to or down-to the limit specified.

I<Since C<0.01>>

=over 4

=item range example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(5);

  my $range = $number->range(9);

  # [5..9]

=back

=over 4

=item range example 2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(5);

  my $range = $number->range(1);

  # [5, 4, 3, 2, 1]

=back

=cut

=head2 sin

  sin() (Num)

The sin method returns the sine of the number (expressed in radians).

I<Since C<0.01>>

=over 4

=item sin example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $sin = $number->sin;

  # -0.993771636455681

=back

=cut

=head2 sqrt

  sqrt() (Num)

The sqrt method returns the positive square root of the number.

I<Since C<0.01>>

=over 4

=item sqrt example 1

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $sqrt = $number->sqrt;

  # 111.108055513541

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 2

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 3

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->tv($rvalue);

  # 1

=back

=over 4

=item tv example 4

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 5

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->tv($rvalue);

  # 1

=back

=over 4

=item tv example 6

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 7

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 8

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=over 4

=item tv example 9

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=back

=cut