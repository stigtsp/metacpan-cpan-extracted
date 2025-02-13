package Shipment::Purolator::WSDLV2::Types::ValidateCityPostalCodeZipResponseContainer;
$Shipment::Purolator::WSDLV2::Types::ValidateCityPostalCodeZipResponseContainer::VERSION = '3.09';
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
my %SuggestedAddresses_of :ATTR(:get<SuggestedAddresses>);

__PACKAGE__->_factory(
    [ qw(        ResponseInformation
        SuggestedAddresses

    ) ],
    {
        'ResponseInformation' => \%ResponseInformation_of,
        'SuggestedAddresses' => \%SuggestedAddresses_of,
    },
    {
        'ResponseInformation' => 'Shipment::Purolator::WSDLV2::Types::ResponseInformation',
        'SuggestedAddresses' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfSuggestedAddress',
    },
    {

        'ResponseInformation' => 'ResponseInformation',
        'SuggestedAddresses' => 'SuggestedAddresses',
    }
);

} # end BLOCK







1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::Purolator::WSDLV2::Types::ValidateCityPostalCodeZipResponseContainer

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ValidateCityPostalCodeZipResponseContainer from the namespace http://purolator.com/pws/datatypes/v2.

ValidateCityPostalCodeZipResponse

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * SuggestedAddresses (min/maxOccurs: 0/1)

=back

=head1 NAME

Shipment::Purolator::WSDLV2::Types::ValidateCityPostalCodeZipResponseContainer

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDLV2::Types::ValidateCityPostalCodeZipResponseContainer
   SuggestedAddresses =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfSuggestedAddress
     SuggestedAddress =>  { # Shipment::Purolator::WSDLV2::Types::SuggestedAddress
       Address =>  { # Shipment::Purolator::WSDLV2::Types::ShortAddress
         City =>  $some_value, # string
         Province =>  $some_value, # string
         Country =>  $some_value, # string
         PostalCode =>  $some_value, # string
       },
       ResponseInformation =>  { # Shipment::Purolator::WSDLV2::Types::ResponseInformation
         Errors =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfError
           Error =>  { # Shipment::Purolator::WSDLV2::Types::Error
             Code =>  $some_value, # string
             Description =>  $some_value, # string
             AdditionalInformation =>  $some_value, # string
           },
         },
         InformationalMessages =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfInformationalMessage
           InformationalMessage =>  { # Shipment::Purolator::WSDLV2::Types::InformationalMessage
             Code =>  $some_value, # string
             Message =>  $some_value, # string
           },
         },
       },
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
