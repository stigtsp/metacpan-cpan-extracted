package Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail;
$Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail::VERSION = '3.09';
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/rate/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Format_of :ATTR(:get<Format>);
my %LabelPrintingOrientation_of :ATTR(:get<LabelPrintingOrientation>);
my %LabelRotation_of :ATTR(:get<LabelRotation>);
my %SpecificationId_of :ATTR(:get<SpecificationId>);

__PACKAGE__->_factory(
    [ qw(        Format
        LabelPrintingOrientation
        LabelRotation
        SpecificationId

    ) ],
    {
        'Format' => \%Format_of,
        'LabelPrintingOrientation' => \%LabelPrintingOrientation_of,
        'LabelRotation' => \%LabelRotation_of,
        'SpecificationId' => \%SpecificationId_of,
    },
    {
        'Format' => 'Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat',
        'LabelPrintingOrientation' => 'Shipment::FedEx::WSDL::RateTypes::LabelPrintingOrientationType',
        'LabelRotation' => 'Shipment::FedEx::WSDL::RateTypes::LabelRotationType',
        'SpecificationId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'Format' => 'Format',
        'LabelPrintingOrientation' => 'LabelPrintingOrientation',
        'LabelRotation' => 'LabelRotation',
        'SpecificationId' => 'SpecificationId',
    }
);

} # end BLOCK







1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CustomDocumentDetail from the namespace http://fedex.com/ws/rate/v9.

Data required to produce a custom-specified document, either at shipment or package level.

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Format (min/maxOccurs: 0/1)

=item * LabelPrintingOrientation (min/maxOccurs: 0/1)

=item * LabelRotation (min/maxOccurs: 0/1)

=item * SpecificationId (min/maxOccurs: 0/1)

=back

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail
   Format =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
     Dispositions =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentDispositionDetail
       DispositionType => $some_value, # ShippingDocumentDispositionType
       Grouping => $some_value, # ShippingDocumentGroupingType
       EMailDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentEMailDetail
         EMailRecipients =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentEMailRecipient
           RecipientType => $some_value, # EMailNotificationRecipientType
           Address =>  $some_value, # string
         },
         Grouping => $some_value, # ShippingDocumentEMailGroupingType
       },
       PrintDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentPrintDetail
         PrinterId =>  $some_value, # string
       },
     },
     TopOfPageOffset =>  { # Shipment::FedEx::WSDL::RateTypes::LinearMeasure
       Value =>  $some_value, # decimal
       Units => $some_value, # LinearUnits
     },
     ImageType => $some_value, # ShippingDocumentImageType
     StockType => $some_value, # ShippingDocumentStockType
     ProvideInstructions =>  $some_value, # boolean
     Localization =>  { # Shipment::FedEx::WSDL::RateTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
   },
   LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
   LabelRotation => $some_value, # LabelRotationType
   SpecificationId =>  $some_value, # string
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
