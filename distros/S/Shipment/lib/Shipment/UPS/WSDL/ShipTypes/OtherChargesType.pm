package Shipment::UPS::WSDL::ShipTypes::OtherChargesType;
$Shipment::UPS::WSDL::ShipTypes::OtherChargesType::VERSION = '3.09';
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/IF/v1.0' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %MonetaryValue_of :ATTR(:get<MonetaryValue>);
my %Description_of :ATTR(:get<Description>);

__PACKAGE__->_factory(
    [ qw(        MonetaryValue
        Description

    ) ],
    {
        'MonetaryValue' => \%MonetaryValue_of,
        'Description' => \%Description_of,
    },
    {
        'MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'MonetaryValue' => 'MonetaryValue',
        'Description' => 'Description',
    }
);

} # end BLOCK







1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::OtherChargesType

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
OtherChargesType from the namespace http://www.ups.com/XMLSchema/XOLTWS/IF/v1.0.

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * MonetaryValue (min/maxOccurs: 1/1)

=item * Description (min/maxOccurs: 1/1)

=back

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::OtherChargesType

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::ShipTypes::OtherChargesType
   MonetaryValue =>  $some_value, # string
   Description =>  $some_value, # string
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=head1 AUTHOR

Andrew Baerg <baergaj@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Andrew Baerg.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
