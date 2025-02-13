package Shipment::FedEx::WSDL::ShipTypes::CompletedEtdDetail;
$Shipment::FedEx::WSDL::ShipTypes::CompletedEtdDetail::VERSION = '3.09';
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

my %FolderId_of :ATTR(:get<FolderId>);
my %UploadDocumentReferenceDetails_of :ATTR(:get<UploadDocumentReferenceDetails>);

__PACKAGE__->_factory(
    [ qw(        FolderId
        UploadDocumentReferenceDetails

    ) ],
    {
        'FolderId' => \%FolderId_of,
        'UploadDocumentReferenceDetails' => \%UploadDocumentReferenceDetails_of,
    },
    {
        'FolderId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'UploadDocumentReferenceDetails' => 'Shipment::FedEx::WSDL::ShipTypes::UploadDocumentReferenceDetail',
    },
    {

        'FolderId' => 'FolderId',
        'UploadDocumentReferenceDetails' => 'UploadDocumentReferenceDetails',
    }
);

} # end BLOCK







1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::CompletedEtdDetail

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CompletedEtdDetail from the namespace http://fedex.com/ws/ship/v9.

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * FolderId (min/maxOccurs: 0/1)

=item * UploadDocumentReferenceDetails (min/maxOccurs: 0/unbounded)

=back

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::CompletedEtdDetail

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::CompletedEtdDetail
   FolderId =>  $some_value, # string
   UploadDocumentReferenceDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::UploadDocumentReferenceDetail
     LineNumber =>  $some_value, # nonNegativeInteger
     CustomerReference =>  $some_value, # string
     DocumentProducer => $some_value, # UploadDocumentProducerType
     DocumentType => $some_value, # UploadDocumentType
     DocumentId =>  $some_value, # string
     DocumentIdProducer => $some_value, # UploadDocumentIdProducer
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
