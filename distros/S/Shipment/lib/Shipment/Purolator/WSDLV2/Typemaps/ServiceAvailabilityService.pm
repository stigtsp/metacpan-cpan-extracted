
package Shipment::Purolator::WSDLV2::Typemaps::ServiceAvailabilityService;
$Shipment::Purolator::WSDLV2::Typemaps::ServiceAvailabilityService::VERSION = '3.09';
use strict;
use warnings;

our $typemap_1 = {
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceLength/DimensionUnit' => 'Shipment::Purolator::WSDLV2::Types::DimensionUnit',
               'GetServiceRulesResponse/OptionRules/OptionRule/Exclusions/OptionIDValuePair/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/Errors/Error/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/OptionRules/OptionRule/OptionIDValuePair/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/Inclusions/OptionIDValuePair/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceHeight/DimensionUnit' => 'Shipment::Purolator::WSDLV2::Types::DimensionUnit',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/Exclusions/OptionIDValuePair/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsResponse/Services/Service/Options/Option/AvailableForPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
               'GetServiceRulesResponse/ResponseInformation' => 'Shipment::Purolator::WSDLV2::Types::ResponseInformation',
               'GetServicesOptionsResponse/ResponseInformation/Errors' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfError',
               'GetServicesOptionsResponse/Services/Service/Options/Option/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumDeclaredValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceLength/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumTotalWeight/WeightUnit' => 'Shipment::Purolator::WSDLV2::Types::WeightUnit',
               'ValidationFault/Details' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfValidationDetail',
               'GetServiceRulesResponse/OptionRules/OptionRule/Inclusions/OptionIDValuePair/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceLength' => 'Shipment::Purolator::WSDLV2::Types::Dimension',
               'GetServicesOptionsResponse/ResponseInformation/Errors/Error/AdditionalInformation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsResponse' => 'Shipment::Purolator::WSDLV2::Elements::GetServicesOptionsResponse',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceHeight/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServiceRulesRequest/ReceiverAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceWeight' => 'Shipment::Purolator::WSDLV2::Types::Weight',
               'GetServiceRulesResponse/ResponseInformation/Errors/Error/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipRequest/Addresses/ShortAddress/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsResponse/Services/Service/PackageTypeDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse' => 'Shipment::Purolator::WSDLV2::Elements::ValidateCityPostalCodeZipResponse',
               'GetServicesOptionsResponse/Services/Service/Options/Option/PossibleValues' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionValue',
               'GetServicesOptionsResponse/Services/Service/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsRequest/SenderAddress' => 'Shipment::Purolator::WSDLV2::Types::ShortAddress',
               'GetServiceRulesResponse/ResponseInformation/InformationalMessages' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfInformationalMessage',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumSize/DimensionUnit' => 'Shipment::Purolator::WSDLV2::Types::DimensionUnit',
               'GetServiceRulesResponse/ServiceRules' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfServiceRule',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceWidth/DimensionUnit' => 'Shipment::Purolator::WSDLV2::Types::DimensionUnit',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/InformationalMessages/InformationalMessage/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/OptionRules/OptionRule/Inclusions/OptionIDValuePair/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ResponseInformation/Errors' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfError',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceHeight' => 'Shipment::Purolator::WSDLV2::Types::Dimension',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceLength/DimensionUnit' => 'Shipment::Purolator::WSDLV2::Types::DimensionUnit',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceHeight/DimensionUnit' => 'Shipment::Purolator::WSDLV2::Types::DimensionUnit',
               'GetServicesOptionsResponse/Services/Service/Options/Option/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/Errors/Error/AdditionalInformation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumTotalWeight' => 'Shipment::Purolator::WSDLV2::Types::Weight',
               'GetServicesOptionsResponse/Services' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfService',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceHeight/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServicesOptionsRequest' => 'Shipment::Purolator::WSDLV2::Elements::GetServicesOptionsRequest',
               'GetServicesOptionsRequest/ReceiverAddress/Province' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidationFault/Details/ValidationDetail/Tag' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesRequest/ReceiverAddress/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/Errors/Error/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsRequest/BillingAccountNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsResponse/Services/Service/Options/Option/ValueType' => 'Shipment::Purolator::WSDLV2::Types::ValueType',
               'GetServiceRulesResponse/OptionRules/OptionRule' => 'Shipment::Purolator::WSDLV2::Types::OptionRule',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceHeight' => 'Shipment::Purolator::WSDLV2::Types::Dimension',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumTotalWeight/WeightUnit' => 'Shipment::Purolator::WSDLV2::Types::WeightUnit',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceWeight' => 'Shipment::Purolator::WSDLV2::Types::Weight',
               'ValidateCityPostalCodeZipRequest/Addresses/ShortAddress/Province' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/Address/Province' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsRequest/ReceiverAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/Inclusions/OptionIDValuePair' => 'Shipment::Purolator::WSDLV2::Types::OptionIDValuePair',
               'GetServicesOptionsRequest/SenderAddress/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesRequest/SenderAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsResponse/Services/Service/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfSuggestedAddress',
               'ValidateCityPostalCodeZipRequest/Addresses/ShortAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/OptionRules' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionRule',
               'GetServicesOptionsRequest/SenderAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsRequest/ReceiverAddress' => 'Shipment::Purolator::WSDLV2::Types::ShortAddress',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/Errors/Error' => 'Shipment::Purolator::WSDLV2::Types::Error',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceWeight/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/InformationalMessages/InformationalMessage' => 'Shipment::Purolator::WSDLV2::Types::InformationalMessage',
               'GetServiceRulesResponse/OptionRules/OptionRule/Inclusions/OptionIDValuePair' => 'Shipment::Purolator::WSDLV2::Types::OptionIDValuePair',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceWidth/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceWeight/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServicesOptionsResponse/ResponseInformation' => 'Shipment::Purolator::WSDLV2::Types::ResponseInformation',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/Errors/Error/AdditionalInformation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipRequest/Addresses' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfShortAddress',
               'GetServicesOptionsResponse/Services/Service/Options/Option' => 'Shipment::Purolator::WSDLV2::Types::Option',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'GetServiceRulesResponse/OptionRules/OptionRule/Exclusions/OptionIDValuePair' => 'Shipment::Purolator::WSDLV2::Types::OptionIDValuePair',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceWidth/DimensionUnit' => 'Shipment::Purolator::WSDLV2::Types::DimensionUnit',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceWidth' => 'Shipment::Purolator::WSDLV2::Types::Dimension',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/Errors/Error/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'GetServiceRulesResponse/OptionRules/OptionRule/Exclusions' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair',
               'GetServiceRulesResponse/ResponseInformation/Errors/Error' => 'Shipment::Purolator::WSDLV2::Types::Error',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumTotalWeight/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServiceRulesResponse' => 'Shipment::Purolator::WSDLV2::Elements::GetServiceRulesResponse',
               'GetServiceRulesResponse/ResponseInformation/InformationalMessages/InformationalMessage/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsRequest/SenderAddress/Province' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesRequest/SenderAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsResponse/ResponseInformation/Errors/Error/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesRequest/SenderAddress/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/Address' => 'Shipment::Purolator::WSDLV2::Types::ShortAddress',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/InformationalMessages' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfInformationalMessage',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'GetServicesOptionsRequest/ReceiverAddress/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipRequest' => 'Shipment::Purolator::WSDLV2::Elements::ValidateCityPostalCodeZipRequest',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/Exclusions/OptionIDValuePair' => 'Shipment::Purolator::WSDLV2::Types::OptionIDValuePair',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/InformationalMessages/InformationalMessage/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/ResponseInformation' => 'Shipment::Purolator::WSDLV2::Types::ResponseInformation',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/InformationalMessages/InformationalMessage/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceWeight/WeightUnit' => 'Shipment::Purolator::WSDLV2::Types::WeightUnit',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumTotalPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'GetServiceRulesResponse/ResponseInformation/InformationalMessages/InformationalMessage/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/Inclusions' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair',
               'GetServiceRulesRequest/BillingAccountNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/OptionRules/OptionRule/Exclusions/OptionIDValuePair/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/Errors' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfError',
               'GetServicesOptionsResponse/ResponseInformation/InformationalMessages' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfInformationalMessage',
               'GetServiceRulesRequest/SenderAddress/Province' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/Errors' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfError',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceWeight/WeightUnit' => 'Shipment::Purolator::WSDLV2::Types::WeightUnit',
               'GetServicesOptionsResponse/Services/Service/PackageType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule' => 'Shipment::Purolator::WSDLV2::Types::ServiceRule',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceLength/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/Inclusions/OptionIDValuePair/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation' => 'Shipment::Purolator::WSDLV2::Types::ResponseInformation',
               'GetServicesOptionsResponse/ResponseInformation/InformationalMessages/InformationalMessage/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesRequest/ReceiverAddress/Province' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumSize/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServiceRulesResponse/ServiceOptionRules' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfServiceOptionRules',
               'ValidationFault/Details/ValidationDetail/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/Exclusions' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/InformationalMessages/InformationalMessage' => 'Shipment::Purolator::WSDLV2::Types::InformationalMessage',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumPieceWidth/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServicesOptionsResponse/Services/Service/Options' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOption',
               'GetServicesOptionsResponse/Services/Service/Options/Option/PossibleValues/OptionValue/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidationFault/Details/ValidationDetail/Key' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/OptionRules/OptionRule/OptionIDValuePair/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidationFault/Details/ValidationDetail' => 'Shipment::Purolator::WSDLV2::Types::ValidationDetail',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/Errors/Error/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsResponse/Services/Service' => 'Shipment::Purolator::WSDLV2::Types::Service',
               'GetServiceRulesResponse/OptionRules/OptionRule/Inclusions' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair',
               'GetServicesOptionsRequest/ReceiverAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumTotalWeight/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceWidth' => 'Shipment::Purolator::WSDLV2::Types::Dimension',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/Exclusions/OptionIDValuePair/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ResponseInformation/Errors/Error/AdditionalInformation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/ServiceID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/Address/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress' => 'Shipment::Purolator::WSDLV2::Types::SuggestedAddress',
               'GetServicesOptionsResponse/ResponseInformation/InformationalMessages/InformationalMessage/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/Errors/Error' => 'Shipment::Purolator::WSDLV2::Types::Error',
               'GetServicesOptionsResponse/ResponseInformation/Errors/Error' => 'Shipment::Purolator::WSDLV2::Types::Error',
               'GetServicesOptionsResponse/Services/Service/Options/Option/PossibleValues/OptionValue/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules/ServiceID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/Address/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServicesOptionsRequest/SenderAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipResponse/ResponseInformation/InformationalMessages/InformationalMessage/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidateCityPostalCodeZipRequest/Addresses/ShortAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesRequest/ReceiverAddress' => 'Shipment::Purolator::WSDLV2::Types::ShortAddress',
               'GetServiceRulesResponse/ResponseInformation/InformationalMessages/InformationalMessage' => 'Shipment::Purolator::WSDLV2::Types::InformationalMessage',
               'GetServiceRulesRequest' => 'Shipment::Purolator::WSDLV2::Elements::GetServiceRulesRequest',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/Address/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumPieceLength' => 'Shipment::Purolator::WSDLV2::Types::Dimension',
               'ValidateCityPostalCodeZipRequest/Addresses/ShortAddress' => 'Shipment::Purolator::WSDLV2::Types::ShortAddress',
               'GetServicesOptionsResponse/Services/Service/Options/Option/PossibleValues/OptionValue' => 'Shipment::Purolator::WSDLV2::Types::OptionValue',
               'GetServiceRulesResponse/ServiceOptionRules/ServiceOptionRules' => 'Shipment::Purolator::WSDLV2::Types::ServiceOptionRules',
               'GetServiceRulesResponse/OptionRules/OptionRule/OptionIDValuePair' => 'Shipment::Purolator::WSDLV2::Types::OptionIDValuePair',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumSize' => 'Shipment::Purolator::WSDLV2::Types::Dimension',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MaximumTotalWeight' => 'Shipment::Purolator::WSDLV2::Types::Weight',
               'GetServicesOptionsResponse/ResponseInformation/InformationalMessages/InformationalMessage' => 'Shipment::Purolator::WSDLV2::Types::InformationalMessage',
               'ValidateCityPostalCodeZipResponse/SuggestedAddresses/SuggestedAddress/ResponseInformation/InformationalMessages' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfInformationalMessage',
               'GetServiceRulesResponse/ResponseInformation/Errors/Error/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetServiceRulesRequest/ReceiverAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidationFault' => 'Shipment::Purolator::WSDLV2::Elements::ValidationFault',
               'GetServiceRulesResponse/ServiceRules/ServiceRule/MinimumTotalPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'GetServiceRulesRequest/SenderAddress' => 'Shipment::Purolator::WSDLV2::Types::ShortAddress',
               'GetServicesOptionsResponse/ResponseInformation/Errors/Error/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    ## Add missing
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOption',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option' => 'Shipment::Purolator::WSDLV2::Types::Option',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/AvailableForPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/PossibleValues' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionValue',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ValueType' => 'Shipment::Purolator::WSDLV2::Types::ValueType',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/PossibleValues/OptionValue/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/PossibleValues/OptionValue/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/PossibleValues/OptionValue' => 'Shipment::Purolator::WSDLV2::Types::OptionValue',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOption',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option' => 'Shipment::Purolator::WSDLV2::Types::Option',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/AvailableForPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/PossibleValues' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionValue',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ValueType' => 'Shipment::Purolator::WSDLV2::Types::ValueType',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/PossibleValues/OptionValue/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/PossibleValues/OptionValue/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/PossibleValues/OptionValue' => 'Shipment::Purolator::WSDLV2::Types::OptionValue',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOption',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option' => 'Shipment::Purolator::WSDLV2::Types::Option',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/AvailableForPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/PossibleValues' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfOptionValue',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ValueType' => 'Shipment::Purolator::WSDLV2::Types::ValueType',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/PossibleValues/OptionValue/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/PossibleValues/OptionValue/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'GetServicesOptionsResponse/Services/Service/Options/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/ChildServiceOptions/Option/PossibleValues/OptionValue' => 'Shipment::Purolator::WSDLV2::Types::OptionValue',
    'ResponseContext' => 'Shipment::Purolator::WSDLV2::Elements::ResponseContext',
    'ResponseContext/ResponseReference' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
             };
;

sub get_class {
  my $name = join '/', @{ $_[1] };
  return $typemap_1->{ $name };
}

sub get_typemap {
    return $typemap_1;
}

1;

=pod

=encoding UTF-8

=head1 NAME

Shipment::Purolator::WSDLV2::Typemaps::ServiceAvailabilityService

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=head1 NAME

Shipment::Purolator::WSDLV2::Typemaps::ServiceAvailabilityService - typemap for ServiceAvailabilityService

=head1 AUTHOR

Andrew Baerg <baergaj@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Andrew Baerg.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__

__END__


