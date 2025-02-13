package Shipment::Purolator::WSDLV2::Types::GetServiceRulesResponseContainer;
$Shipment::Purolator::WSDLV2::Types::GetServiceRulesResponseContainer::VERSION = '3.09';
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://purolator.com/pws/datatypes/v2' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}


use base qw(Shipment::Purolator::WSDLV2::Types::ResponseContainer);
# Variety: sequence
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %ResponseInformation_of :ATTR(:get<ResponseInformation>);
my %ServiceRules_of :ATTR(:get<ServiceRules>);
my %ServiceOptionRules_of :ATTR(:get<ServiceOptionRules>);
my %OptionRules_of :ATTR(:get<OptionRules>);

__PACKAGE__->_factory(
    [ qw(        ResponseInformation
        ServiceRules
        ServiceOptionRules
        OptionRules

    ) ],
    {
        'ResponseInformation' => \%ResponseInformation_of,
        'ServiceRules' => \%ServiceRules_of,
        'ServiceOptionRules' => \%ServiceOptionRules_of,
        'OptionRules' => \%OptionRules_of,
    },
    {
        'ResponseInformation' => 'Shipment::Purolator::WSDLV2::Types::ResponseInformation',
        'ServiceRules' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfServiceRule',
        'ServiceOptionRules' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfServiceOptionRules',
        'OptionRules' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionRule',
    },
    {

        'ResponseInformation' => 'ResponseInformation',
        'ServiceRules' => 'ServiceRules',
        'ServiceOptionRules' => 'ServiceOptionRules',
        'OptionRules' => 'OptionRules',
    }
);

} # end BLOCK







1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::Purolator::WSDLV2::Types::GetServiceRulesResponseContainer

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
GetServiceRulesResponseContainer from the namespace http://purolator.com/pws/datatypes/v2.

GetServiceRulesResponse

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ServiceRules (min/maxOccurs: 0/1)

=item * ServiceOptionRules (min/maxOccurs: 0/1)

=item * OptionRules (min/maxOccurs: 0/1)

=back

=head1 NAME

Shipment::Purolator::WSDLV2::Types::GetServiceRulesResponseContainer

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDLV2::Types::GetServiceRulesResponseContainer
   ServiceRules =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfServiceRule
     ServiceRule =>  { # Shipment::Purolator::WSDLV2::Types::ServiceRule
       ServiceID =>  $some_value, # string
       MinimumTotalPieces =>  $some_value, # int
       MaximumTotalPieces =>  $some_value, # int
       MinimumTotalWeight =>  { # Shipment::Purolator::WSDLV2::Types::Weight
         Value =>  $some_value, # decimal
         WeightUnit => $some_value, # WeightUnit
       },
       MaximumTotalWeight => {}, # Shipment::Purolator::WSDLV2::Types::Weight
       MinimumPieceWeight => {}, # Shipment::Purolator::WSDLV2::Types::Weight
       MaximumPieceWeight => {}, # Shipment::Purolator::WSDLV2::Types::Weight
       MinimumPieceLength =>  { # Shipment::Purolator::WSDLV2::Types::Dimension
         Value =>  $some_value, # decimal
         DimensionUnit => $some_value, # DimensionUnit
       },
       MaximumPieceLength => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
       MinimumPieceWidth => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
       MaximumPieceWidth => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
       MinimumPieceHeight => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
       MaximumPieceHeight => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
       MaximumSize => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
       MaximumDeclaredValue =>  $some_value, # decimal
     },
   },
   ServiceOptionRules =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfServiceOptionRules
     ServiceOptionRules =>  { # Shipment::Purolator::WSDLV2::Types::ServiceOptionRules
       ServiceID =>  $some_value, # string
       Exclusions =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
         OptionIDValuePair =>  { # Shipment::Purolator::WSDLV2::Types::OptionIDValuePair
           ID =>  $some_value, # string
           Value =>  $some_value, # string
         },
       },
       Inclusions => {}, # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
     },
   },
   OptionRules =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionRule
     OptionRule =>  { # Shipment::Purolator::WSDLV2::Types::OptionRule
       OptionIDValuePair => {}, # Shipment::Purolator::WSDLV2::Types::OptionIDValuePair
       Exclusions => {}, # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
       Inclusions => {}, # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
     },
   },
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
