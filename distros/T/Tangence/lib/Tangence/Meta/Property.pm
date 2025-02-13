#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2011-2021 -- leonerd@leonerd.org.uk

use v5.26;
use Object::Pad 0.44;

package Tangence::Meta::Property 0.29;
class Tangence::Meta::Property :strict(params);

use Syntax::Keyword::Match;

use Tangence::Constants;

=head1 NAME

C<Tangence::Meta::Property> - structure representing one C<Tangence> property

=head1 DESCRIPTION

This data structure object stores information about one L<Tangence> class
property. Once constructed, such objects are immutable.

=cut

=head1 CONSTRUCTOR

=cut

=head2 new

   $property = Tangence::Meta::Property->new( %args )

Returns a new instance initialised by the given arguments.

=over 8

=item class => Tangence::Meta::Class

Reference to the containing class

=item name => STRING

Name of the property

=item dimension => INT

Dimension of the property, as one of the C<DIM_*> constants from
L<Tangence::Constants>.

=item type => STRING

The element type as a L<Tangence::Meta::Type> reference.

=item smashed => BOOL

Optional. If true, marks that the property is smashed.

=back

=cut

has $class     :param :weak :reader;
has $name      :param       :reader;
has $dimension :param       :reader;
has $type      :param       :reader;
has $smashed   :param       :reader = 0;

=head1 ACCESSORS

=cut

=head2 class

   $class = $property->class

Returns the class the property is a member of

=cut

=head2 name

   $name = $property->name

Returns the name of the class

=cut

=head2 dimension

   $dimension = $property->dimension

Returns the dimension as one of the C<DIM_*> constants.

=cut

=head2 type

   $type = $property->type

Returns the element type as a L<Tangence::Meta::Type> reference.

=cut

=head2 overall_type

   $type = $property->overall_type

Returns the type of the entire collection as a L<Tangence::Meta::Type>
reference. For scalar types this will be the element type. For dict types this
will be a hash of the array type. For array, queue and objset types this will
a list of the element type.

=cut

has $_overall_type;

method overall_type
{
   return $_overall_type ||= do {
      my $type = $self->type;
      my $dim  = $self->dimension;
      match( $dim : == ) {
         case( DIM_SCALAR ) {
            $type;
         }
         case( DIM_HASH ) {
            $self->make_type( dict => $type );
         }
         case( DIM_ARRAY ), case( DIM_QUEUE ), case( DIM_OBJSET ) {
            $self->make_type( list => $type );
         }
         default {
            die "Unrecognised dimension $dim for ->overall_type";
         }
      }
   }
}

=head2 smashed

   $smashed = $property->smashed

Returns true if the property is smashed.

=cut

# For subclasses to override if required
method make_type
{
   return Tangence::Meta::Type->make( @_ );
}

=head1 AUTHOR

Paul Evans <leonerd@leonerd.org.uk>

=cut

0x55AA;

