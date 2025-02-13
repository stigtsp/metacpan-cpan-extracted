#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2011-2021 -- leonerd@leonerd.org.uk

use v5.26;
use Object::Pad 0.43;

package Tangence::Meta::Class 0.29;
class Tangence::Meta::Class :strict(params);

use Carp;

=head1 NAME

C<Tangence::Meta::Class> - structure representing one C<Tangence> class

=head1 DESCRIPTION

This data structure object stores information about one L<Tangence> class.
Once constructed and defined, such objects are immutable.

=cut

=head1 CONSTRUCTOR

=cut

=head2 new

   $class = Tangence::Meta::Class->new( name => $name )

Returns a new instance representing the given name.

=cut

has $name    :param :reader;
has $defined        :reader = 0;

has @superclasses;
has %methods;
has %events;
has %properties;

=head2 define

   $class->define( %args )

Provides a definition for the class.

=over 8

=item methods => HASH

=item events => HASH

=item properties => HASH

Optional HASH references containing metadata about methods, events and
properties, as instances of L<Tangence::Meta::Method>,
L<Tangence::Meta::Event> or L<Tangence::Meta::Property>.

=item superclasses => ARRAY

Optional ARRAY reference containing superclasses as
C<Tangence::Meta::Class> references.

=back

=cut

method define ( %args )
{
   $defined and croak "Cannot define $name twice";

   $defined++;
   @superclasses = @{ delete $args{superclasses} // [] };
   %methods      = %{ delete $args{methods}      // {} };
   %events       = %{ delete $args{events}       // {} };
   %properties   = %{ delete $args{properties}   // {} };
}

=head1 ACCESSORS

=cut

=head2 defined

   $defined = $class->defined

Returns true if a definintion for the class has been provided using C<define>.

=cut

=head2 name

   $name = $class->name

Returns the name of the class

=cut

=head2 perlname

   $perlname = $class->perlname

Returns the perl name of the class. This will be the Tangence name, with dots
replaced by double colons (C<::>).

=cut

method perlname
{
   ( my $perlname = $self->name ) =~ s{\.}{::}g; # s///rg in 5.14
   return $perlname;
}

=head2 direct_superclasses

   @superclasses = $class->direct_superclasses

Return the direct superclasses in a list of C<Tangence::Meta::Class>
references.

=cut

method direct_superclasses
{
   $defined or croak "$name is not yet defined";
   return @superclasses;
}

=head2 direct_methods

   $methods = $class->direct_methods

Return the methods that this class directly defines (rather than inheriting
from superclasses) as a HASH reference mapping names to
L<Tangence::Meta::Method> instances.

=cut

method direct_methods
{
   $defined or croak "$name is not yet defined";
   return { %methods };
}

=head2 direct_events

   $events = $class->direct_events

Return the events that this class directly defines (rather than inheriting
from superclasses) as a HASH reference mapping names to
L<Tangence::Meta::Event> instances.

=cut

method direct_events
{
   $defined or croak "$name is not yet defined";
   return { %events };
}

=head2 direct_properties

   $properties = $class->direct_properties

Return the properties that this class directly defines (rather than inheriting
from superclasses) as a HASH reference mapping names to
L<Tangence::Meta::Property> instances.

=cut

method direct_properties
{
   $defined or croak "$name is not yet defined";
   return { %properties };
}

=head1 AGGREGATE ACCESSORS

The following accessors inspect the full inheritance tree of this class and
all its superclasses

=cut

=head2 superclasses

   @superclasses = $class->superclasses

Return all the superclasses in a list of unique C<Tangence::Meta::Class>
references.

=cut

method superclasses
{
   # This algorithm doesn't have to be particularly good, C3 or whatever.
   # We're not really forming a search order, mearly uniq'ifying
   my %seen;
   return grep { !$seen{$_}++ } map { $_, $_->superclasses } @superclasses;
}

=head2 methods

   $methods = $class->methods

Return all the methods available to this class as a HASH reference mapping
names to L<Tangence::Meta::Method> instances.

=cut

method methods
{
   my %methods;
   foreach ( $self, $self->superclasses ) {
      my $m = $_->direct_methods;
      $methods{$_} ||= $m->{$_} for keys %$m;
   }
   return \%methods;
}

=head2 method

   $method = $class->method( $name )

Return the named method as a L<Tangence::Meta::Method> instance, or C<undef>
if no such method exists.

=cut

method method ( $name )
{
   return $self->methods->{$name};
}

=head2 events

   $events = $class->events

Return all the events available to this class as a HASH reference mapping
names to L<Tangence::Meta::Event> instances.

=cut

method events
{
   my %events;
   foreach ( $self, $self->superclasses ) {
      my $e = $_->direct_events;
      $events{$_} ||= $e->{$_} for keys %$e;
   }
   return \%events;
}

=head2 event

   $event = $class->event( $name )

Return the named event as a L<Tangence::Meta::Event> instance, or C<undef> if
no such event exists.

=cut

method event ( $name )
{
   return $self->events->{$name};
}

=head2 properties

   $properties = $class->properties

Return all the properties available to this class as a HASH reference mapping
names to L<Tangence::Meta::Property> instances.

=cut

method properties
{
   my %properties;
   foreach ( $self, $self->superclasses ) {
      my $p = $_->direct_properties;
      $properties{$_} ||= $p->{$_} for keys %$p;
   }
   return \%properties;
}

=head2 property

   $property = $class->property( $name )

Return the named property as a L<Tangence::Meta::Property> instance, or
C<undef> if no such property exists.

=cut

method property ( $name )
{
   return $self->properties->{$name};
}

=head1 AUTHOR

Paul Evans <leonerd@leonerd.org.uk>

=cut

0x55AA;
