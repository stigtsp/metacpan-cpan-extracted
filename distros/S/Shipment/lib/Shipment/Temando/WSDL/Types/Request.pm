package Shipment::Temando::WSDL::Types::Request;
$Shipment::Temando::WSDL::Types::Request::VERSION = '3.09';
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(0);

sub get_xmlns { 'http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd' };

our $XML_ATTRIBUTE_CLASS = 'Shipment::Temando::WSDL::Types::Request::_Request::XmlAttr';

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %status_of :ATTR(:get<status>);
my %anythings_of :ATTR(:get<anythings>);
my %anywhere_of :ATTR(:get<anywhere>);
my %anytime_of :ATTR(:get<anytime>);
my %general_of :ATTR(:get<general>);
my %origin_of :ATTR(:get<origin>);
my %destination_of :ATTR(:get<destination>);
my %quotes_of :ATTR(:get<quotes>);
my %instructions_of :ATTR(:get<instructions>);
my %comments_of :ATTR(:get<comments>);
my %reference_of :ATTR(:get<reference>);

__PACKAGE__->_factory(
    [ qw(        status
        anythings
        anywhere
        anytime
        general
        origin
        destination
        quotes
        instructions
        comments
        reference

    ) ],
    {
        'status' => \%status_of,
        'anythings' => \%anythings_of,
        'anywhere' => \%anywhere_of,
        'anytime' => \%anytime_of,
        'general' => \%general_of,
        'origin' => \%origin_of,
        'destination' => \%destination_of,
        'quotes' => \%quotes_of,
        'instructions' => \%instructions_of,
        'comments' => \%comments_of,
        'reference' => \%reference_of,
    },
    {
        'status' => 'Shipment::Temando::WSDL::Types::RequestStatus',

        'anythings' => 'Shipment::Temando::WSDL::Types::Request::_anythings',
        'anywhere' => 'Shipment::Temando::WSDL::Types::Anywhere',
        'anytime' => 'Shipment::Temando::WSDL::Types::Anytime',
        'general' => 'Shipment::Temando::WSDL::Types::General',
        'origin' => 'Shipment::Temando::WSDL::Types::Location',
        'destination' => 'Shipment::Temando::WSDL::Types::Location',

        'quotes' => 'Shipment::Temando::WSDL::Types::Request::_quotes',
        'instructions' => 'Shipment::Temando::WSDL::Types::Instructions',
        'comments' => 'Shipment::Temando::WSDL::Types::Comments',
        'reference' => 'Shipment::Temando::WSDL::Types::ClientReference',
    },
    {

        'status' => 'status',
        'anythings' => 'anythings',
        'anywhere' => 'anywhere',
        'anytime' => 'anytime',
        'general' => 'general',
        'origin' => 'origin',
        'destination' => 'destination',
        'quotes' => 'quotes',
        'instructions' => 'instructions',
        'comments' => 'comments',
        'reference' => 'reference',
    }
);

} # end BLOCK




package Shipment::Temando::WSDL::Types::Request::_anythings;
$Shipment::Temando::WSDL::Types::Request::_anythings::VERSION = '3.09';
use strict;
use warnings;
{
our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %anything_of :ATTR(:get<anything>);

__PACKAGE__->_factory(
    [ qw(        anything

    ) ],
    {
        'anything' => \%anything_of,
    },
    {
        'anything' => 'Shipment::Temando::WSDL::Types::Anything',
    },
    {

        'anything' => 'anything',
    }
);

} # end BLOCK






}



package Shipment::Temando::WSDL::Types::Request::_quotes;
$Shipment::Temando::WSDL::Types::Request::_quotes::VERSION = '3.09';
use strict;
use warnings;
{
our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %quote_of :ATTR(:get<quote>);

__PACKAGE__->_factory(
    [ qw(        quote

    ) ],
    {
        'quote' => \%quote_of,
    },
    {
        'quote' => 'Shipment::Temando::WSDL::Types::AvailableQuote',
    },
    {

        'quote' => 'quote',
    }
);

} # end BLOCK






}



package Shipment::Temando::WSDL::Types::Request::_Request::XmlAttr;
$Shipment::Temando::WSDL::Types::Request::_Request::XmlAttr::VERSION = '3.09';
use base qw(SOAP::WSDL::XSD::Typelib::AttributeSet);

{ # BLOCK to scope variables

my %id_of :ATTR(:get<id>);

__PACKAGE__->_factory(
    [ qw(
        id
    ) ],
    {

        id => \%id_of,
    },
    {
        id => 'SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger',
    }
);

} # end BLOCK



1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::Temando::WSDL::Types::Request

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Request from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd.

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * status (min/maxOccurs: 0/1)

=item * anythings (min/maxOccurs: 0/1)

=item * anywhere (min/maxOccurs: 0/1)

=item * anytime (min/maxOccurs: 0/1)

=item * general (min/maxOccurs: 0/1)

=item * origin (min/maxOccurs: 0/1)

=item * destination (min/maxOccurs: 0/1)

=item * quotes (min/maxOccurs: 0/1)

=item * instructions (min/maxOccurs: 0/1)

=item * comments (min/maxOccurs: 0/1)

=item * reference (min/maxOccurs: 0/1)

=back

=head1 NAME

Shipment::Temando::WSDL::Types::Request

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::Request
   status => $some_value, # RequestStatus
   anythings =>  {
     anything =>  { # Shipment::Temando::WSDL::Types::Anything
       class => $some_value, # Class
       subclass => $some_value, # Subclass
       mode => $some_value, # Mode
       tlSubclass => $some_value, # TlSubclass
       packaging => $some_value, # Packaging
       palletType => $some_value, # PalletType
       palletNature => $some_value, # PalletNature
       containerDimensions => $some_value, # ContainerDimensions
       containerNature => $some_value, # ContainerNature
       containerRegistered => $some_value, # YesNoOption
       qualifierFreightGeneralDangerousGoods => $some_value, # YesNoOption
       qualifierFreightGeneralFragile => $some_value, # YesNoOption
       qualifierFreightGeneralRefrigerated => $some_value, # YesNoOption
       qualifierVehicleMake => $some_value, # VehicleMake
       qualifierVehicleModel => $some_value, # VehicleModel
       qualifierVehicleDescription => $some_value, # VehicleDescription
       qualifierVehicleRunning => $some_value, # YesNoOption
       qualifierVehicleRegistered => $some_value, # YesNoOption
       qualifierVehicleYear => $some_value, # VehicleYear
       qualifierVehicleRegistration => $some_value, # VehicleRegistration
       qualifierBoatMake => $some_value, # BoatMake
       qualifierBoatModel => $some_value, # BoatModel
       qualifierBoatSeaworthy => $some_value, # YesNoOption
       qualifierBoatTrailer => $some_value, # YesNoOption
       qualifierBoatHullType => $some_value, # BoatHullType
       qualifierLivestockType => $some_value, # LivestockType
       qualifierAnimalVaccinated => $some_value, # YesNoOption
       qualifierAnimalRegistered => $some_value, # YesNoOption
       qualifierAnimalType => $some_value, # AnimalType
       qualifierAnimalBreed => $some_value, # AnimalBreed
       qualifierAnimalSex => $some_value, # Sex
       qualifierAnimalAge => $some_value, # AnimalAge
       qualifierAnimalCrate => $some_value, # AnimalCrate
       distanceMeasurementType => $some_value, # DistanceMeasurementType
       weightMeasurementType => $some_value, # WeightMeasurementType
       length => $some_value, # Length
       width => $some_value, # Width
       height => $some_value, # Height
       weight => $some_value, # Weight
       quantity => $some_value, # Quantity
       description => $some_value, # ItemDescription
     },
   },
   anywhere =>  { # Shipment::Temando::WSDL::Types::Anywhere
     itemNature => $some_value, # DeliveryNature
     itemMethod => $some_value, # DeliveryType
     originDescription => $some_value, # LocationName
     originCountry => $some_value, # CountryCode
     originCode => $some_value, # PostalCode
     originSuburb => $some_value, # Suburb
     originState => $some_value, # State
     originCity => $some_value, # City
     originPort => $some_value, # PortName
     destinationDescription => $some_value, # LocationName
     destinationCountry => $some_value, # CountryCode
     destinationCode => $some_value, # PostalCode
     destinationSuburb => $some_value, # Suburb
     destinationState => $some_value, # State
     destinationCity => $some_value, # City
     destinationPort => $some_value, # PortName
     portType => $some_value, # PortType
     destinationIs => $some_value, # LocationType
     destinationBusPostalBox => $some_value, # YesNoOption
     destinationBusUnattended => $some_value, # YesNoOption
     destinationBusDock => $some_value, # YesNoOption
     destinationBusForklift => $some_value, # YesNoOption
     destinationBusLoadingFacilities => $some_value, # YesNoOption
     destinationBusInside => $some_value, # YesNoOption
     destinationBusNotifyBefore => $some_value, # YesNoOption
     destinationBusLimitedAccess => $some_value, # YesNoOption
     destinationBusHeavyLift => $some_value, # YesNoOption
     destinationBusTailgateLifter => $some_value, # YesNoOption
     destinationBusContainerSwingLifter => $some_value, # YesNoOption
     destinationResPostalBox => $some_value, # YesNoOption
     destinationResUnattended => $some_value, # YesNoOption
     destinationResInside => $some_value, # YesNoOption
     destinationResNotifyBefore => $some_value, # YesNoOption
     destinationResLimitedAccess => $some_value, # YesNoOption
     destinationResHeavyLift => $some_value, # YesNoOption
     destinationResTailgateLifter => $some_value, # YesNoOption
     originIs => $some_value, # LocationType
     originBusUnattended => $some_value, # YesNoOption
     originBusDock => $some_value, # YesNoOption
     originBusForklift => $some_value, # YesNoOption
     originBusLoadingFacilities => $some_value, # YesNoOption
     originBusInside => $some_value, # YesNoOption
     originBusNotifyBefore => $some_value, # YesNoOption
     originBusLimitedAccess => $some_value, # YesNoOption
     originBusHeavyLift => $some_value, # YesNoOption
     originBusTailgateLifter => $some_value, # YesNoOption
     originBusContainerSwingLifter => $some_value, # YesNoOption
     originResUnattended => $some_value, # YesNoOption
     originResInside => $some_value, # YesNoOption
     originResNotifyBefore => $some_value, # YesNoOption
     originResLimitedAccess => $some_value, # YesNoOption
     originResHeavyLift => $some_value, # YesNoOption
     originResTailgateLifter => $some_value, # YesNoOption
   },
   anytime =>  { # Shipment::Temando::WSDL::Types::Anytime
     readyDate => $some_value, # Date
     readyTime => $some_value, # ReadyTime
   },
   general =>  { # Shipment::Temando::WSDL::Types::General
     goodsValue => $some_value, # CurrencyAmount
   },
   origin =>  { # Shipment::Temando::WSDL::Types::Location
     description => $some_value, # LocationName
     type => $some_value, # LocationPosition
     contactName => $some_value, # ContactName
     companyName => $some_value, # CompanyName
     street => $some_value, # Address
     suburb => $some_value, # Suburb
     state => $some_value, # State
     code => $some_value, # PostalCode
     country => $some_value, # CountryCode
     phone1 => $some_value, # Phone
     phone2 => $some_value, # Phone
     fax => $some_value, # Fax
     email => $some_value, # Email
     loadingFacilities => $some_value, # YesNoOption
     forklift => $some_value, # YesNoOption
     dock => $some_value, # YesNoOption
     limitedAccess => $some_value, # YesNoOption
     postalBox => $some_value, # YesNoOption
     auspostMerchantLocationId => $some_value, # AuspostMerchantLocationId
     auspostLodgementFacility => $some_value, # AuspostLodgementFacility
     manifesting => $some_value, # YesNoOption
   },
   destination => {}, # Shipment::Temando::WSDL::Types::Location
   quotes =>  {
     quote =>  { # Shipment::Temando::WSDL::Types::AvailableQuote
       generated => $some_value, # GeneratedType
       accepted => $some_value, # YesNoOption
       bookingNumber => $some_value, # BookingNumber
       consignmentNumber => $some_value, # ConsignmentNumber
       consignmentDocument => $some_value, # ConsignmentDocument
       consignmentDocumentType => $some_value, # ConsignmentDocumentType
       labelDocument => $some_value, # LabelDocument
       labelDocumentType => $some_value, # LabelDocumentType
       manifestNumber => $some_value, # ManifestNumber
       articles =>  {
         article =>  { # Shipment::Temando::WSDL::Types::Article
           anythingIndex => $some_value, # AnythingIndex
           articleNumber => $some_value, # ArticleNumber
           labelDocument => $some_value, # LabelDocument
           labelDocumentType => $some_value, # LabelDocumentType
         },
       },
       trackingStatus => $some_value, # TrackingStatus
       trackingStatusOccurred => $some_value, # Datetime
       trackingLastChecked => $some_value, # Datetime
       trackingFurtherDetails => $some_value, # TrackingFurtherDetails
       totalPrice => $some_value, # CurrencyAmount
       basePrice => $some_value, # CurrencyAmount
       tax => $some_value, # CurrencyAmount
       currency => $some_value, # CurrencyType
       deliveryMethod => $some_value, # DeliveryMethod
       usingGeneralRail => $some_value, # YesNoOption
       usingGeneralRoad => $some_value, # YesNoOption
       usingGeneralSea => $some_value, # YesNoOption
       usingExpressAir => $some_value, # YesNoOption
       usingExpressRoad => $some_value, # YesNoOption
       etaFrom => $some_value, # Eta
       etaTo => $some_value, # Eta
       guaranteedEta => $some_value, # YesNoOption
       adjustments =>  {
         adjustment =>  { # Shipment::Temando::WSDL::Types::Adjustment
           description => $some_value, # AdjustmentDescription
           amount => $some_value, # CurrencyAmount
           tax => $some_value, # CurrencyAmount
         },
       },
       inclusions =>  {
         inclusion =>  { # Shipment::Temando::WSDL::Types::Inclusion
           summary => $some_value, # InclusionSummary
           details => $some_value, # InclusionDetails
         },
       },
       extras =>  {
         extra =>  { # Shipment::Temando::WSDL::Types::Extra
           summary => $some_value, # ExtraSummary
           details => $some_value, # ExtraDetails
           totalPrice => $some_value, # CurrencyAmount
           basePrice => $some_value, # CurrencyAmount
           tax => $some_value, # CurrencyAmount
           adjustments =>  {
             adjustment => {}, # Shipment::Temando::WSDL::Types::Adjustment
           },
         },
       },
       carrier =>  { # Shipment::Temando::WSDL::Types::Carrier
         id => $some_value, # CarrierId
         companyName => $some_value, # CompanyName
         companyContact => $some_value, # ContactName
         streetAddress => $some_value, # Address
         streetSuburb => $some_value, # Suburb
         streetCity => $some_value, # City
         streetState => $some_value, # State
         streetCode => $some_value, # PostalCode
         streetCountry => $some_value, # CountryCode
         postalAddress => $some_value, # Address
         postalSuburb => $some_value, # Suburb
         postalCity => $some_value, # City
         postalState => $some_value, # State
         postalCode => $some_value, # PostalCode
         postalCountry => $some_value, # CountryCode
         phone1 => $some_value, # Phone
         phone2 => $some_value, # Phone
         email => $some_value, # Email
         website => $some_value, # Website
         conditions => $some_value, # CarrierConditions
       },
       originatingDepot =>  { # Shipment::Temando::WSDL::Types::Depot
         name => $some_value, # DepotName
         street => $some_value, # Address
         suburb => $some_value, # Suburb
         city => $some_value, # City
         state => $some_value, # State
         code => $some_value, # PostalCode
         country => $some_value, # CountryCode
         phone1 => $some_value, # Phone
         phone2 => $some_value, # Phone
         fax => $some_value, # Fax
         instructions => $some_value, # DepotInstructions
       },
       destinationDepot => {}, # Shipment::Temando::WSDL::Types::Depot
     },
   },
   instructions => $some_value, # Instructions
   comments => $some_value, # Comments
   reference => $some_value, # ClientReference
 },

=head2 attr

NOTE: Attribute documentation is experimental, and may be inaccurate.
See the correspondent WSDL/XML Schema if in question.

This class has additional attributes, accessibly via the C<attr()> method.

attr() returns an object of the class Shipment::Temando::WSDL::Types::Request::_Request::XmlAttr.

The following attributes can be accessed on this object via the corresponding
get_/set_ methods:

=over

=item * id

This attribute is of type L<SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger|SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger>.

=back

=head1 AUTHOR

Generated by SOAP::WSDL

=head1 AUTHOR

Andrew Baerg <baergaj@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Andrew Baerg.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
