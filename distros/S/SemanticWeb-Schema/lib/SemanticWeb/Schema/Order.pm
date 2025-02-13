use utf8;

package SemanticWeb::Schema::Order;

# ABSTRACT: An order is a confirmation of a transaction (a receipt)

use Moo;

extends qw/ SemanticWeb::Schema::Intangible /;


use MooX::JSON_LD 'Order';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v9.0.0';


has accepted_offer => (
    is        => 'rw',
    predicate => '_has_accepted_offer',
    json_ld   => 'acceptedOffer',
);



has billing_address => (
    is        => 'rw',
    predicate => '_has_billing_address',
    json_ld   => 'billingAddress',
);



has broker => (
    is        => 'rw',
    predicate => '_has_broker',
    json_ld   => 'broker',
);



has confirmation_number => (
    is        => 'rw',
    predicate => '_has_confirmation_number',
    json_ld   => 'confirmationNumber',
);



has customer => (
    is        => 'rw',
    predicate => '_has_customer',
    json_ld   => 'customer',
);



has discount => (
    is        => 'rw',
    predicate => '_has_discount',
    json_ld   => 'discount',
);



has discount_code => (
    is        => 'rw',
    predicate => '_has_discount_code',
    json_ld   => 'discountCode',
);



has discount_currency => (
    is        => 'rw',
    predicate => '_has_discount_currency',
    json_ld   => 'discountCurrency',
);



has is_gift => (
    is        => 'rw',
    predicate => '_has_is_gift',
    json_ld   => 'isGift',
);



has merchant => (
    is        => 'rw',
    predicate => '_has_merchant',
    json_ld   => 'merchant',
);



has order_date => (
    is        => 'rw',
    predicate => '_has_order_date',
    json_ld   => 'orderDate',
);



has order_delivery => (
    is        => 'rw',
    predicate => '_has_order_delivery',
    json_ld   => 'orderDelivery',
);



has order_number => (
    is        => 'rw',
    predicate => '_has_order_number',
    json_ld   => 'orderNumber',
);



has order_status => (
    is        => 'rw',
    predicate => '_has_order_status',
    json_ld   => 'orderStatus',
);



has ordered_item => (
    is        => 'rw',
    predicate => '_has_ordered_item',
    json_ld   => 'orderedItem',
);



has part_of_invoice => (
    is        => 'rw',
    predicate => '_has_part_of_invoice',
    json_ld   => 'partOfInvoice',
);



has payment_due => (
    is        => 'rw',
    predicate => '_has_payment_due',
    json_ld   => 'paymentDue',
);



has payment_due_date => (
    is        => 'rw',
    predicate => '_has_payment_due_date',
    json_ld   => 'paymentDueDate',
);



has payment_method => (
    is        => 'rw',
    predicate => '_has_payment_method',
    json_ld   => 'paymentMethod',
);



has payment_method_id => (
    is        => 'rw',
    predicate => '_has_payment_method_id',
    json_ld   => 'paymentMethodId',
);



has payment_url => (
    is        => 'rw',
    predicate => '_has_payment_url',
    json_ld   => 'paymentUrl',
);



has seller => (
    is        => 'rw',
    predicate => '_has_seller',
    json_ld   => 'seller',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Order - An order is a confirmation of a transaction (a receipt)

=head1 VERSION

version v9.0.0

=head1 DESCRIPTION

An order is a confirmation of a transaction (a receipt), which can contain
multiple line items, each represented by an Offer that has been accepted by
the customer.

=head1 ATTRIBUTES

=head2 C<accepted_offer>

C<acceptedOffer>

The offer(s) -- e.g., product, quantity and price combinations -- included
in the order.

A accepted_offer should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Offer']>

=back

=head2 C<_has_accepted_offer>

A predicate for the L</accepted_offer> attribute.

=head2 C<billing_address>

C<billingAddress>

The billing address for the order.

A billing_address should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::PostalAddress']>

=back

=head2 C<_has_billing_address>

A predicate for the L</billing_address> attribute.

=head2 C<broker>

An entity that arranges for an exchange between a buyer and a seller. In
most cases a broker never acquires or releases ownership of a product or
service involved in an exchange. If it is not clear whether an entity is a
broker, seller, or buyer, the latter two terms are preferred.

A broker should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_broker>

A predicate for the L</broker> attribute.

=head2 C<confirmation_number>

C<confirmationNumber>

A number that confirms the given order or payment has been received.

A confirmation_number should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_confirmation_number>

A predicate for the L</confirmation_number> attribute.

=head2 C<customer>

Party placing the order or paying the invoice.

A customer should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_customer>

A predicate for the L</customer> attribute.

=head2 C<discount>

Any discount applied (to an Order).

A discount should be one of the following types:

=over

=item C<Num>

=item C<Str>

=back

=head2 C<_has_discount>

A predicate for the L</discount> attribute.

=head2 C<discount_code>

C<discountCode>

Code used to redeem a discount.

A discount_code should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_discount_code>

A predicate for the L</discount_code> attribute.

=head2 C<discount_currency>

C<discountCurrency>

=for html <p>The currency of the discount.<br/><br/> Use standard formats: <a
href="http://en.wikipedia.org/wiki/ISO_4217">ISO 4217 currency format</a>
e.g. "USD"; <a
href="https://en.wikipedia.org/wiki/List_of_cryptocurrencies">Ticker
symbol</a> for cryptocurrencies e.g. "BTC"; well known names for <a
href="https://en.wikipedia.org/wiki/Local_exchange_trading_system">Local
Exchange Tradings Systems</a> (LETS) and other currency types e.g. "Ithaca
HOUR".<p>

A discount_currency should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_discount_currency>

A predicate for the L</discount_currency> attribute.

=head2 C<is_gift>

C<isGift>

Was the offer accepted as a gift for someone other than the buyer.

A is_gift should be one of the following types:

=over

=item C<Bool>

=back

=head2 C<_has_is_gift>

A predicate for the L</is_gift> attribute.

=head2 C<merchant>

'merchant' is an out-dated term for 'seller'.

A merchant should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_merchant>

A predicate for the L</merchant> attribute.

=head2 C<order_date>

C<orderDate>

Date order was placed.

A order_date should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_order_date>

A predicate for the L</order_date> attribute.

=head2 C<order_delivery>

C<orderDelivery>

The delivery of the parcel related to this order or order item.

A order_delivery should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::ParcelDelivery']>

=back

=head2 C<_has_order_delivery>

A predicate for the L</order_delivery> attribute.

=head2 C<order_number>

C<orderNumber>

The identifier of the transaction.

A order_number should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_order_number>

A predicate for the L</order_number> attribute.

=head2 C<order_status>

C<orderStatus>

The current status of the order.

A order_status should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::OrderStatus']>

=back

=head2 C<_has_order_status>

A predicate for the L</order_status> attribute.

=head2 C<ordered_item>

C<orderedItem>

The item ordered.

A ordered_item should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::OrderItem']>

=item C<InstanceOf['SemanticWeb::Schema::Product']>

=item C<InstanceOf['SemanticWeb::Schema::Service']>

=back

=head2 C<_has_ordered_item>

A predicate for the L</ordered_item> attribute.

=head2 C<part_of_invoice>

C<partOfInvoice>

The order is being paid as part of the referenced Invoice.

A part_of_invoice should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Invoice']>

=back

=head2 C<_has_part_of_invoice>

A predicate for the L</part_of_invoice> attribute.

=head2 C<payment_due>

C<paymentDue>

The date that payment is due.

A payment_due should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_payment_due>

A predicate for the L</payment_due> attribute.

=head2 C<payment_due_date>

C<paymentDueDate>

The date that payment is due.

A payment_due_date should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_payment_due_date>

A predicate for the L</payment_due_date> attribute.

=head2 C<payment_method>

C<paymentMethod>

The name of the credit card or other method of payment for the order.

A payment_method should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::PaymentMethod']>

=back

=head2 C<_has_payment_method>

A predicate for the L</payment_method> attribute.

=head2 C<payment_method_id>

C<paymentMethodId>

An identifier for the method of payment used (e.g. the last 4 digits of the
credit card).

A payment_method_id should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_payment_method_id>

A predicate for the L</payment_method_id> attribute.

=head2 C<payment_url>

C<paymentUrl>

The URL for sending a payment.

A payment_url should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_payment_url>

A predicate for the L</payment_url> attribute.

=head2 C<seller>

An entity which offers (sells / leases / lends / loans) the services /
goods. A seller may also be a provider.

A seller should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_seller>

A predicate for the L</seller> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Intangible>

=head1 SOURCE

The development version is on github at L<https://github.com/robrwo/SemanticWeb-Schema>
and may be cloned from L<git://github.com/robrwo/SemanticWeb-Schema.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/robrwo/SemanticWeb-Schema/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018-2020 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
