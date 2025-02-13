package Shipment::FedEx::WSDL::ShipTypes::TaxpayerIdentification;
$Shipment::FedEx::WSDL::ShipTypes::TaxpayerIdentification::VERSION = '3.09';
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/ship/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %TinType_of :ATTR(:get<TinType>);
my %Number_of :ATTR(:get<Number>);
my %Usage_of :ATTR(:get<Usage>);

__PACKAGE__->_factory(
    [ qw(        TinType
        Number
        Usage

    ) ],
    {
        'TinType' => \%TinType_of,
        'Number' => \%Number_of,
        'Usage' => \%Usage_of,
    },
    {
        'TinType' => 'Shipment::FedEx::WSDL::ShipTypes::TinType',
        'Number' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Usage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'TinType' => 'TinType',
        'Number' => 'Number',
        'Usage' => 'Usage',
    }
);

} # end BLOCK







1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::TaxpayerIdentification

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
TaxpayerIdentification from the namespace http://fedex.com/ws/ship/v9.

The descriptive data for taxpayer identification information.

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * TinType (min/maxOccurs: 1/1)

=item * Number (min/maxOccurs: 1/1)

=item * Usage (min/maxOccurs: 0/1)

=back

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::TaxpayerIdentification

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::TaxpayerIdentification
   TinType => $some_value, # TinType
   Number =>  $some_value, # string
   Usage =>  $some_value, # string
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
