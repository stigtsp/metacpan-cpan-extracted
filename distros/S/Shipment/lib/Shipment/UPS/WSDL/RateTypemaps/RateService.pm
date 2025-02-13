
package Shipment::UPS::WSDL::RateTypemaps::RateService;
$Shipment::UPS::WSDL::RateTypemaps::RateService::VERSION = '3.09';
use strict;
use warnings;

our $typemap_1 = {
               'UPSSecurity/UsernameToken/Username' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageServiceOptions/DeclaredValue/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageServiceOptions/COD/CODAmount' => 'Shipment::UPS::WSDL::RateTypes::CODAmountType',
               'UPSSecurity/ServiceAccessToken' => 'Shipment::UPS::WSDL::RateElements::UPSSecurity::_ServiceAccessToken',
               'RateRequest/Shipment/ShipFrom/Address' => 'Shipment::UPS::WSDL::RateTypes::AddressType',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/NetCharge/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/OnCallPickup/Schedule/Method' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Shipper/Address/CountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/AdditionalHandlingIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipTo/Address/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/Response/TransactionReference/CustomerContext' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageWeight/Weight' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipFrom/Name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/ServiceOptionsCharges/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageWeight/UnitOfMeasurement/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/DeliveryConfirmation/DCISType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/GrossCharge' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateRequest/Shipment/Package/PackageWeight/UnitOfMeasurement' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateRequest/Request/TransactionReference/CustomerContext' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Shipper/ShipperNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/SaturdayDeliveryIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/BillingWeight/UnitOfMeasurement/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageServiceOptions/VerbalConfirmationIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage' => 'Shipment::UPS::WSDL::RateTypes::RatedPackageType',
               'Fault/detail/Errors/ErrorDetail/Location/XPathOfElement' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/Response/TransactionReference' => 'Shipment::UPS::WSDL::RateTypes::TransactionReferenceType',
               'Fault/detail/Errors/ErrorDetail/PrimaryErrorCode' => 'Shipment::UPS::WSDL::RateTypes::CodeType',
               'Errors' => 'Shipment::UPS::WSDL::RateElements::Errors',
               'RateRequest/Shipment/ShipmentRatingOptions/NegotiatedRatesIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Request/TransactionReference' => 'Shipment::UPS::WSDL::RateTypes::TransactionReferenceType',
               'RateResponse/RatedShipment/NegotiatedRateCharges/TotalCharge/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/FRSPaymentInformation/Address/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/TransportationCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateResponse/RatedShipment/RatedPackage/SurePostDasCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateRequest/Shipment/Package/Dimensions/Width' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageServiceOptions/DeclaredValue/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Shipper/Address/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Request/RequestOption' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipFrom/Address/AddressLine' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/PickupType/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/BillingWeight/Weight' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageServiceOptions/COD/CODAmount/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse' => 'Shipment::UPS::WSDL::RateElements::RateResponse',
               'RateRequest/Shipment/ShipmentServiceOptions/COD/CODAmount/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/PickupType' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateResponse/RatedShipment/RatedPackage/TransportationCharges/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/SurePostDasCharges/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedShipmentAlert' => 'Shipment::UPS::WSDL::RateTypes::RatedShipmentInfoType',
               'UPSSecurity' => 'Shipment::UPS::WSDL::RateElements::UPSSecurity',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation/Value/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/ServiceOptionsCharges/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/Response' => 'Shipment::UPS::WSDL::RateTypes::ResponseType',
               'RateRequest/Shipment/FRSPaymentInformation/Type' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateRequest/CustomerClassification/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipFrom/Address/CountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/SubErrorCode' => 'Shipment::UPS::WSDL::RateTypes::CodeType',
               'RateRequest/Request' => 'Shipment::UPS::WSDL::RateTypes::RequestType',
               'RateResponse/RatedShipment/ServiceOptionsCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateResponse/RatedShipment/RatedPackage/TotalCharges/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/BillingWeight/UnitOfMeasurement' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation' => 'Shipment::UPS::WSDL::RateTypes::AdditionalInfoType',
               'UPSSecurity/UsernameToken/Password' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipTo/Address/StateProvinceCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/FRSPaymentInformation/Address' => 'Shipment::UPS::WSDL::RateTypes::PayerAddressType',
               'RateRequest/Shipment/Shipper/Address/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Service/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/COD' => 'Shipment::UPS::WSDL::RateTypes::CODType',
               'RateRequest/Shipment/Package/Dimensions/UnitOfMeasurement' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/GrossCharge/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/Service/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Shipper/Name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/FRSPaymentInformation/Address/CountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/Severity' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/DiscountPercentage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/Commodity/NMFC' => 'Shipment::UPS::WSDL::RateTypes::NMFCCommodityType',
               'RateRequest/Shipment/ShipmentRatingOptions/FRSShipmentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/CustomerClassification/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackagingType/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/GuaranteedDelivery' => 'Shipment::UPS::WSDL::RateTypes::GuaranteedDeliveryType',
               'RateRequest/Shipment/ShipmentServiceOptions/SaturdayPickupIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/BillingWeight' => 'Shipment::UPS::WSDL::RateTypes::BillingWeightType',
               'RateResponse/Response/ResponseStatus/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageServiceOptions/DeclaredValue' => 'Shipment::UPS::WSDL::RateTypes::InsuredValueType',
               'RateRequest/Shipment/FRSPaymentInformation/AccountNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/UPScarbonneutralIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/OnCallPickup' => 'Shipment::UPS::WSDL::RateTypes::OnCallPickupType',
               'RateRequest/Shipment/Package/LargePackageIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment' => 'Shipment::UPS::WSDL::RateTypes::RatedShipmentType',
               'RateRequest/Shipment/Shipper/Address/AddressLine' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'RateResponse/Response/TransactionReference/TransactionIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Service' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateRequest/Shipment/FRSPaymentInformation/Type/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/GuaranteedDelivery/BusinessDaysInTransit' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment' => 'Shipment::UPS::WSDL::RateTypes::ShipmentType',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'RateResponse/RatedShipment/NegotiatedRateCharges/TotalCharge/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges' => 'Shipment::UPS::WSDL::RateTypes::TransportationChargesType',
               'RateRequest/Shipment/ShipTo/Address/CountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/InvoiceLineTotal/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/NetCharge' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateRequest/Shipment/ShipFrom/Address/StateProvinceCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipFrom/Address/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/TotalCharges/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/Location/OriginalValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/PrimaryErrorCode/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/OnCallPickup/Schedule' => 'Shipment::UPS::WSDL::RateTypes::ScheduleType',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/DiscountAmount/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageServiceOptions/COD' => 'Shipment::UPS::WSDL::RateTypes::CODType',
               'RateRequest/Shipment/Package/PackageServiceOptions/COD/CODFundsCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/Location/LocationElementName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'Fault/detail/Errors/ErrorDetail/SubErrorCode/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Shipper/Address' => 'Shipment::UPS::WSDL::RateTypes::AddressType',
               'RateRequest/Shipment/ShipmentServiceOptions/DeliveryConfirmation' => 'Shipment::UPS::WSDL::RateTypes::DeliveryConfirmationType',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation/Value' => 'Shipment::UPS::WSDL::RateTypes::AdditionalCodeDescType',
               'Fault/detail/Errors/ErrorDetail/SubErrorCode/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/Dimensions/Length' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipTo/Address/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/SubErrorCode/Digest' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/TotalCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateResponse/RatedShipment/ServiceOptionsCharges/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/TransportationCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateRequest/Shipment/Package/Commodity/NMFC/SubCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions' => 'Shipment::UPS::WSDL::RateTypes::ShipmentServiceOptionsType',
               'RateResponse/RatedShipment/NegotiatedRateCharges' => 'Shipment::UPS::WSDL::RateTypes::TotalChargeType',
               'Fault/detail/Errors/ErrorDetail/PrimaryErrorCode/Digest' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/Dimensions/UnitOfMeasurement/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/NetCharge/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/Dimensions/UnitOfMeasurement/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/FRSPaymentInformation/Type/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/CustomerClassification' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateRequest/Shipment/ShipTo' => 'Shipment::UPS::WSDL::RateTypes::ShipToType',
               'RateResponse/RatedShipment/TransportationCharges/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/Response/Alert/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation/Type' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/TransportationCharges/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/SurePostDasCharges/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageWeight' => 'Shipment::UPS::WSDL::RateTypes::PackageWeightType',
               'RateResponse/Response/ResponseStatus' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateRequest/Shipment/Package/Commodity/FreightClass' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/ServiceOptionsCharges/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/ServiceAccessToken/AccessLicenseNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/COD/CODAmount' => 'Shipment::UPS::WSDL::RateTypes::CODAmountType',
               'RateRequest/Shipment/Package/PackagingType' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipTo/Address' => 'Shipment::UPS::WSDL::RateTypes::ShipToAddressType',
               'RateRequest/Shipment/Shipper' => 'Shipment::UPS::WSDL::RateTypes::ShipperType',
               'RateRequest/Request/TransactionReference/TransactionIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/BillingWeight/UnitOfMeasurement/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedShipmentAlert/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/ServiceOptionsCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation/Value/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/FRSShipmentData' => 'Shipment::UPS::WSDL::RateTypes::FRSShipmentType',
               'Fault/detail' => 'Shipment::UPS::WSDL::RateElements::FaultDetail',
               'Fault/detail/Errors' => 'Shipment::UPS::WSDL::RateElements::Errors',
               'RateResponse/RatedShipment/RatedPackage/BillingWeight' => 'Shipment::UPS::WSDL::RateTypes::BillingWeightType',
               'RateRequest/Shipment/Package/PackageWeight/UnitOfMeasurement/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/Dimensions' => 'Shipment::UPS::WSDL::RateTypes::DimensionsType',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/DiscountAmount' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateRequest/Shipment/Package/PackageServiceOptions' => 'Shipment::UPS::WSDL::RateTypes::PackageServiceOptionsType',
               'RateResponse/RatedShipment/RatedShipmentAlert/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipFrom' => 'Shipment::UPS::WSDL::RateTypes::ShipFromType',
               'RateResponse/RatedShipment/TotalCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateResponse/RatedShipment/RatedPackage/TotalCharges/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/Service/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/InvoiceLineTotal' => 'Shipment::UPS::WSDL::RateTypes::InvoiceLineTotalType',
               'RateRequest/Shipment/Package/Commodity/NMFC/PrimeCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/BillingWeight/UnitOfMeasurement' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateRequest/Shipment/Service/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipFrom/Address/PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipTo/Name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentRatingOptions' => 'Shipment::UPS::WSDL::RateTypes::ShipmentRatingOptionsType',
               'RateRequest/Shipment/InvoiceLineTotal/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/DocumentsOnlyIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/Response/Alert' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateResponse/RatedShipment/TotalCharges/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package' => 'Shipment::UPS::WSDL::RateTypes::PackageType',
               'RateRequest/Shipment/Package/Commodity' => 'Shipment::UPS::WSDL::RateTypes::CommodityType',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/DiscountAmount/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/FRSPaymentInformation' => 'Shipment::UPS::WSDL::RateTypes::FRSPaymentInfoType',
               'RateRequest/Shipment/ShipTo/Address/ResidentialAddressIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Shipper/Address/StateProvinceCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/COD/CODAmount/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/BillingWeight/Weight' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/TransportationCharges/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/GuaranteedDelivery/DeliveryByTime' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/ReturnOfDocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail' => 'Shipment::UPS::WSDL::RateTypes::ErrorDetailType',
               'RateRequest/Shipment/ShipmentServiceOptions/OnCallPickup/Schedule/PickupDay' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/RatedPackage/BillingWeight/UnitOfMeasurement/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/PrimaryErrorCode/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackageServiceOptions/DeliveryConfirmation/DCISType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/Dimensions/Height' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/Response/ResponseStatus/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/Package/PackagingType/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipTo/Address/AddressLine' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/Location' => 'Shipment::UPS::WSDL::RateTypes::LocationType',
               'RateRequest/Shipment/Package/PackageServiceOptions/COD/CODAmount/MonetaryValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/UsernameToken' => 'Shipment::UPS::WSDL::RateElements::UPSSecurity::_UsernameToken',
               'RateResponse/RatedShipment/RatedPackage/BillingWeight/UnitOfMeasurement/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/MinimumRetrySeconds' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/NegotiatedRateCharges/TotalCharge' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
               'RateRequest/Shipment/Package/PackageServiceOptions/DeliveryConfirmation' => 'Shipment::UPS::WSDL::RateTypes::DeliveryConfirmationType',
               'RateResponse/RatedShipment/RatedPackage/Weight' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest/Shipment/ShipmentServiceOptions/COD/CODFundsCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/RatedShipment/FRSShipmentData/TransportationCharges/GrossCharge/CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateResponse/Response/Alert/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'RateRequest' => 'Shipment::UPS::WSDL::RateElements::RateRequest',
               'RateResponse/RatedShipment/Service' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
               'RateRequest/PickupType/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string'
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

Shipment::UPS::WSDL::RateTypemaps::RateService

=head1 VERSION

version 3.09

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=head1 NAME

Shipment::UPS::WSDL::RateTypemaps::RateService - typemap for RateService

=head1 AUTHOR

Andrew Baerg <baergaj@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Andrew Baerg.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__

__END__


