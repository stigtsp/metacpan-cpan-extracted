package Venus::Role::Coercible;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# MODIFIERS

sub BUILD {
  my ($self, $data) = @_;

  $data = $self->coercion($data);

  for my $name (keys %$data) {
    $self->{$name} = $data->{$name};
  }

  return $self;
};

# METHODS

sub coerce {
  my ($self) = @_;

  return {};
}

sub coerce_args {
  my ($self, $data, $spec) = @_;

  for my $name (grep exists($data->{$_}), sort keys %$spec) {
    $data->{$name} = $self->coerce_onto(
      $data, $name, $spec->{$name}, $data->{$name},
    );
  }

  return $data;
}

sub coerce_into {
  my ($self, $class, $value) = @_;

  require Scalar::Util;
  require Venus::Space;

  $class = Venus::Space->new($class)->load;

  if (Scalar::Util::blessed($value) && $value->isa($class)) {
    return $value;
  }
  else {
    return $class->new($value);
  }
}

sub coerce_onto {
  my ($self, $data, $name, $class, $value) = @_;

  require Venus::Space;

  $class = Venus::Space->new($class)->load;

  $value = $data->{$name} if $#_ < 4;

  if (my $method = $self->can("coerce_${name}")) {
    return $data->{$name} = $self->$method(\&coerce_into, $class, $value);
  }
  else {
    return $data->{$name} = $self->coerce_into($class, $value);
  }
}

sub coercion {
  my ($self, $data) = @_;

  my $spec = $self->coerce;

  return $data if !%$spec;

  return $self->coerce_args($data, $spec);
}

# EXPORTS

sub EXPORT {
  [
    'coerce',
    'coerce_args',
    'coerce_into',
    'coerce_onto',
    'coercion',
  ]
}

1;



=head1 NAME

Venus::Role::Coercible - Coercible Role

=cut

=head1 ABSTRACT

Coercible Role for Perl 5

=cut

=head1 SYNOPSIS

  package Person;

  use Venus::Class;

  with 'Venus::Role::Coercible';

  attr 'name';
  attr 'father';
  attr 'mother';
  attr 'siblings';

  sub coerce {
    {
      father => 'Person',
      mother => 'Person',
      name => 'Venus/String',
      siblings => 'Person',
    }
  }

  sub coerce_name {
    my ($self, $code, @args) = @_;

    return $self->$code(@args);
  }

  sub coerce_siblings {
    my ($self, $code, $class, $value) = @_;

    return [map $self->$code($class, $_), @$value];
  }

  package main;

  my $person = Person->new(
    name => 'me',
    father => {name => 'father'},
    mother => {name => 'mother'},
    siblings => [{name => 'brother'}, {name => 'sister'}],
  );

  # $person
  # bless({...}, 'Person')

  # $person->name
  # bless({...}, 'Venus::String')

  # $person->father
  # bless({...}, 'Person')

  # $person->mother
  # bless({...}, 'Person')

  # $person->siblings
  # [bless({...}, 'Person'), bless({...}, 'Person'), ...]

=cut

=head1 DESCRIPTION

This package modifies the consuming package and provides methods for hooking
into object construction and coercing arguments into objects and values.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 coerce

  coerce() (HashRef)

The coerce method, if defined, is called during object construction, or by the
L</coercion> method, and returns key/value pairs where the keys map to class
attributes (or input parameters) and the values are L<Venus::Space> compatible
package names.

I<Since C<0.02>>

=over 4

=item coerce example 1

  package main;

  my $person = Person->new(
    name => 'me',
  );

  my $coerce = $person->coerce;

  # {
  #   father   => "Person",
  #   mother   => "Person",
  #   name     => "Venus/String",
  #   siblings => "Person",
  # }

=back

=cut

=head2 coerce_args

  coerce_args(HashRef $data, HashRef $spec) (HashRef)

The coerce_args method replaces values in the data provided with objects
corresponding to the specification provided. The specification should contains
key/value pairs where the keys map to class attributes (or input parameters)
and the values are L<Venus::Space> compatible package names.

I<Since C<0.07>>

=over 4

=item coerce_args example 1

  package main;

  my $person = Person->new;

  my $data = $person->coerce_args(
    {
      father => { name => 'father' }
    },
    {
      father => 'Person',
    },
  );

  # {
  #   father   => bless({...}, 'Person'),
  # }

=back

=cut

=head2 coerce_into

  coerce_into(Str $class, Any $value) (Object)

The coerce_into method attempts to build and return an object based on the
class name and value provided, unless the value provided is already an object
derived from the specified class.

I<Since C<0.07>>

=over 4

=item coerce_into example 1

  package main;

  my $person = Person->new;

  my $friend = $person->coerce_into('Person', {
    name => 'friend',
  });

  # bless({...}, 'Person')

=back

=cut

=head2 coerce_onto

  coerce_onto(HashRef $data, Str $name, Str $class, Any $value) (Object)

The coerce_onto method attempts to build and assign an object based on the
class name and value provided, as the value corresponding to the name
specified, in the data provided. If the C<$value> is omitted, the value
corresponding to the name in the C<$data> will be used.

I<Since C<0.07>>

=over 4

=item coerce_onto example 1

  package main;

  my $person = Person->new;

  my $data = { friend => { name => 'friend' } };

  my $friend = $person->coerce_onto($data, 'friend', 'Person');

  # bless({...}, 'Person'),

  # $data was updated
  #
  # {
  #   friend => bless({...}, 'Person'),
  # }

=back

=cut

=head2 coercion

  coercion(HashRef $data) (HashRef)

The coercion method is called automatically during object construction but can
be called manually as well, and is passed a hashref to coerce and return.

I<Since C<0.02>>

=over 4

=item coercion example 1

  package main;

  my $person = Person->new;

  my $coercion = $person->coercion({
    name => 'me',
  });

  # $coercion
  # {...}

  # $coercion->{name}
  # bless({...}, 'Venus::String')

  # $coercion->{father}
  # undef

  # $coercion->{mother}
  # undef

  # $coercion->{siblings}
  # undef

=back

=over 4

=item coercion example 2

  package main;

  my $person = Person->new;

  my $coercion = $person->coercion({
    name => 'me',
    mother => {name => 'mother'},
    siblings => [{name => 'brother'}, {name => 'sister'}],
  });

  # $coercion
  # {...}

  # $coercion->{name}
  # bless({...}, 'Venus::String')

  # $coercion->{father}
  # undef

  # $coercion->{mother}
  # bless({...}, 'Person')

  # $coercion->{siblings}
  # [bless({...}, 'Person'), bless({...}, 'Person'), ...]

=back

=cut