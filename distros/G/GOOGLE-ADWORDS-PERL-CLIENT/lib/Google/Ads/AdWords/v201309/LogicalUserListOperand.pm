package Google::Ads::AdWords::v201309::LogicalUserListOperand;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'https://adwords.google.com/api/adwords/rm/v201309' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(Google::Ads::SOAP::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %UserList_of :ATTR(:get<UserList>);

__PACKAGE__->_factory(
    [ qw(        UserList

    ) ],
    {
        'UserList' => \%UserList_of,
    },
    {
        'UserList' => 'Google::Ads::AdWords::v201309::UserList',
    },
    {

        'UserList' => 'UserList',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Google::Ads::AdWords::v201309::LogicalUserListOperand

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
LogicalUserListOperand from the namespace https://adwords.google.com/api/adwords/rm/v201309.

An interface for a logical user list operand. A logical user list is a combination of logical rules. Each rule is defined as a logical operator and a list of operands. Those operands can be of type UserList or UserInterest. 




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * UserList




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():






=head1 AUTHOR

Generated by SOAP::WSDL

=cut

