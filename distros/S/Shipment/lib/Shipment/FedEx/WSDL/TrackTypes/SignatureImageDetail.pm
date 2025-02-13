package Shipment::FedEx::WSDL::TrackTypes::SignatureImageDetail;
$Shipment::FedEx::WSDL::TrackTypes::SignatureImageDetail::VERSION = '3.09';
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/track/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Image_of :ATTR(:get<Image>);
my %Notifications_of :ATTR(:get<Notifications>);

__PACKAGE__->_factory(
    [ qw(        Image
        Notifications

    ) ],
    {
        'Image' => \%Image_of,
        'Notifications' => \%Notifications_of,
    },
    {
        'Image' => 'SOAP::WSDL::XSD::Typelib::Builtin::base64Binary',
        'Notifications' => 'Shipment::FedEx::WSDL::TrackTypes::Notification',
    },
    {

        'Image' => 'Image',
        'Notifications' => 'Notifications',
    }
);

} # end BLOCK







1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::SignatureImageDetail

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
SignatureImageDetail from the namespace http://fedex.com/ws/track/v9.

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Image

=item * Notifications

=back

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::SignatureImageDetail

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::SignatureImageDetail
   Image =>  $some_value, # base64Binary
   Notifications =>  { # Shipment::FedEx::WSDL::TrackTypes::Notification
     Severity => $some_value, # NotificationSeverityType
     Source =>  $some_value, # string
     Code =>  $some_value, # string
     Message =>  $some_value, # string
     LocalizedMessage =>  $some_value, # string
     MessageParameters =>  { # Shipment::FedEx::WSDL::TrackTypes::NotificationParameter
       Id =>  $some_value, # string
       Value =>  $some_value, # string
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
