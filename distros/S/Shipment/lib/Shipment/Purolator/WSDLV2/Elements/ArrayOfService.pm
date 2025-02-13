
package Shipment::Purolator::WSDLV2::Elements::ArrayOfService;
$Shipment::Purolator::WSDLV2::Elements::ArrayOfService::VERSION = '3.09';
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://purolator.com/pws/datatypes/v2' }

__PACKAGE__->__set_name('ArrayOfService');
__PACKAGE__->__set_nillable(1);
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();
use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    Shipment::Purolator::WSDLV2::Types::ArrayOfService
);

}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::Purolator::WSDLV2::Elements::ArrayOfService

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
ArrayOfService from the namespace http://purolator.com/pws/datatypes/v2.

=head1 NAME

Shipment::Purolator::WSDLV2::Elements::ArrayOfService

=head1 METHODS

=head2 new

 my $element = Shipment::Purolator::WSDLV2::Elements::ArrayOfService->new($data);

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDLV2::Types::ArrayOfService
   Service =>  { # Shipment::Purolator::WSDLV2::Types::Service
     ID =>  $some_value, # string
     Description =>  $some_value, # string
     PackageType =>  $some_value, # string
     PackageTypeDescription =>  $some_value, # string
     Options =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfOption
       Option =>  { # Shipment::Purolator::WSDLV2::Types::Option
         ID =>  $some_value, # string
         Description =>  $some_value, # string
         ValueType => $some_value, # ValueType
         AvailableForPieces =>  $some_value, # boolean
         PossibleValues =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionValue
           OptionValue =>  { # Shipment::Purolator::WSDLV2::Types::OptionValue
             Value =>  $some_value, # string
             Description =>  $some_value, # string
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
