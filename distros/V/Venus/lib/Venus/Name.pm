package Venus::Name;

use 5.018;

use strict;
use warnings;

use Venus::Class;

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';

use overload (
  '""' => 'explain',
  '.' => sub{$_[0]->value . "$_[1]"},
  'eq' => sub{$_[0]->value eq "$_[1]"},
  'ne' => sub{$_[0]->value ne "$_[1]"},
  'qr' => sub{qr/@{[quotemeta($_[0]->value)]}/},
  '~~' => 'explain',
  fallback => 1,
);

my $sep = qr/'|__|::|\\|\//;

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    value => $data,
  };
}

# METHODS

sub default {
  return 'Venus';
}

sub dist {
  my ($self) = @_;

  return $self->label =~ s/_/-/gr;
}

sub explain {
  my ($self) = @_;

  return $self->get;
}

sub file {
  my ($self) = @_;

  return $self->get if $self->lookslike_a_file;

  my $string = $self->package;

  return join '__', map {
    join '_', map {lc} map {split /_/} grep {length}
    split /([A-Z]{1}[^A-Z]*)/
  } split /$sep/, $string;
}

sub format {
  my ($self, $method, $format) = @_;

  my $string = $self->$method;

  return sprintf($format || '%s', $string);
}

sub label {
  my ($self) = @_;

  return $self->get if $self->lookslike_a_label;

  return join '_', split /$sep/, $self->package;
}

sub lookslike_a_file {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^[a-z](?:\w*[a-z])?$/;
}

sub lookslike_a_label {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^[A-Z](?:\w*[a-zA-Z0-9])?$/;
}

sub lookslike_a_package {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^[A-Z](?:(?:\w|::)*[a-zA-Z0-9])?$/;
}

sub lookslike_a_path {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^[A-Z](?:(?:\w|\\|\/|[\:\.]{1}[a-zA-Z0-9])*[a-zA-Z0-9])?$/;
}

sub lookslike_a_pragma {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^\[\w+\]$/;
}

sub package {
  my ($self) = @_;

  return $self->get if $self->lookslike_a_package;

  return substr($self->get, 1, -1) if $self->lookslike_a_pragma;

  my $string = $self->get;

  if ($string !~ $sep) {
    return join '', map {ucfirst} split /[^a-zA-Z0-9]/, $string;
  } else {
    return join '::', map {
      join '', map {ucfirst} split /[^a-zA-Z0-9]/
    } split /$sep/, $string;
  }
}

sub path {
  my ($self) = @_;

  return $self->get if $self->lookslike_a_path;

  return join '/', split /$sep/, $self->package;
}

1;



=head1 NAME

Venus::Name - Name Class

=cut

=head1 ABSTRACT

Name Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Name;

  my $name = Venus::Name->new('Foo/Bar');

  # $name->package;

=cut

=head1 DESCRIPTION

This package provides methods for parsing and formatting package namespace
strings.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind::Utility>

=cut

=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Accessible>

L<Venus::Role::Buildable>

L<Venus::Role::Explainable>

L<Venus::Role::Valuable>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 default

  default() (Str)

The default method returns the default value, i.e. C<'Venus'>.

I<Since C<0.01>>

=over 4

=item default example 1

  # given: synopsis;

  my $default = $name->default;

  # "Venus"

=back

=cut

=head2 dist

  dist() (Str)

The dist method returns a package distribution representation of the name.

I<Since C<0.01>>

=over 4

=item dist example 1

  # given: synopsis;

  my $dist = $name->dist;

  # "Foo-Bar"

=back

=cut

=head2 explain

  explain() (Str)

The explain method returns the package name and is used in stringification
operations.

I<Since C<0.01>>

=over 4

=item explain example 1

  # given: synopsis;

  my $explain = $name->explain;

  # "Foo/Bar"

=back

=cut

=head2 file

  file() (Str)

The file method returns a file representation of the name.

I<Since C<0.01>>

=over 4

=item file example 1

  # given: synopsis;

  my $file = $name->file;

  # "foo__bar"

=back

=cut

=head2 format

  format(Str $method, Str $format) (Str)

The format method calls the specified method passing the result to the core
L</sprintf> function with itself as an argument. This method supports
dispatching, i.e. providing a method name and arguments whose return value will
be acted on by this method.

I<Since C<0.01>>

=over 4

=item format example 1

  # given: synopsis;

  my $format = $name->format('file', '%s.t');

  # "foo__bar.t"

=back

=cut

=head2 label

  label() (Str)

The label method returns a label (or constant) representation of the name.

I<Since C<0.01>>

=over 4

=item label example 1

  # given: synopsis;

  my $label = $name->label;

  # "Foo_Bar"

=back

=cut

=head2 lookslike_a_file

  lookslike_a_file() (Str)

The lookslike_a_file method returns truthy if its state resembles a filename.

I<Since C<0.01>>

=over 4

=item lookslike_a_file example 1

  # given: synopsis;

  my $lookslike_a_file = $name->lookslike_a_file;

  # ""

=back

=cut

=head2 lookslike_a_label

  lookslike_a_label() (Str)

The lookslike_a_label method returns truthy if its state resembles a label (or
constant).

I<Since C<0.01>>

=over 4

=item lookslike_a_label example 1

  # given: synopsis;

  my $lookslike_a_label = $name->lookslike_a_label;

  # ""

=back

=cut

=head2 lookslike_a_package

  lookslike_a_package() (Str)

The lookslike_a_package method returns truthy if its state resembles a package
name.

I<Since C<0.01>>

=over 4

=item lookslike_a_package example 1

  # given: synopsis;

  my $lookslike_a_package = $name->lookslike_a_package;

  # ""

=back

=cut

=head2 lookslike_a_path

  lookslike_a_path() (Str)

The lookslike_a_path method returns truthy if its state resembles a file path.

I<Since C<0.01>>

=over 4

=item lookslike_a_path example 1

  # given: synopsis;

  my $lookslike_a_path = $name->lookslike_a_path;

  # 1

=back

=cut

=head2 lookslike_a_pragma

  lookslike_a_pragma() (Str)

The lookslike_a_pragma method returns truthy if its state resembles a pragma.

I<Since C<0.01>>

=over 4

=item lookslike_a_pragma example 1

  # given: synopsis;

  my $lookslike_a_pragma = $name->lookslike_a_pragma;

  # ""

=back

=cut

=head2 package

  package() (Str)

The package method returns a package name representation of the name given.

I<Since C<0.01>>

=over 4

=item package example 1

  # given: synopsis;

  my $package = $name->package;

  # "Foo::Bar"

=back

=cut

=head2 path

  path() (Str)

The path method returns a path representation of the name.

I<Since C<0.01>>

=over 4

=item path example 1

  # given: synopsis;

  my $path = $name->path;

  # "Foo/Bar"

=back

=cut

=head1 OPERATORS

This package overloads the following operators:

=cut

=over 4

=item operation: C<(.)>

This package overloads the C<.> operator.

B<example 1>

  # given: synopsis;

  my $package = $name . 'Baz';

  # "Foo::BarBaz"

=back

=over 4

=item operation: C<(eq)>

This package overloads the C<eq> operator.

B<example 1>

  # given: synopsis;

  $name eq 'Foo/Bar';

  # 1

B<example 2>

  package main;

  use Venus::Name;

  my $name1 = Venus::Name->new('Foo\Bar');
  my $name2 = Venus::Name->new('Foo\Bar');

  $name1 eq $name2;

  # 1

=back

=over 4

=item operation: C<(ne)>

This package overloads the C<ne> operator.

B<example 1>

  # given: synopsis;

  $name ne 'Foo\Bar';

  # 1

B<example 2>

  package main;

  use Venus::Name;

  my $name1 = Venus::Name->new('FooBar');
  my $name2 = Venus::Name->new('Foo_Bar');

  $name1 ne $name2;

  # 1

=back

=over 4

=item operation: C<(qr)>

This package overloads the C<qr> operator.

B<example 1>

  # given: synopsis;

  "Foo/Bar" =~ qr/$name/;

  # 1

=back

=over 4

=item operation: C<("")>

This package overloads the C<""> operator.

B<example 1>

  # given: synopsis;

  my $result = "$name";

  # "Foo/Bar"

=back

=over 4

=item operation: C<(~~)>

This package overloads the C<~~> operator.

B<example 1>

  # given: synopsis;

  my $result = $name ~~ 'Foo/Bar';

  # 1

=back