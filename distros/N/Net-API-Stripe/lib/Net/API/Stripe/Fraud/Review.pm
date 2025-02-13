##----------------------------------------------------------------------------
## Stripe API - ~/lib/Net/API/Stripe/Fraud/Review.pm
## Version v0.100.0
## Copyright(c) 2019 DEGUEST Pte. Ltd.
## Author: Jacques Deguest <@sitael.tokyo.deguest.jp>
## Created 2019/11/02
## Modified 2020/05/15
## 
##----------------------------------------------------------------------------
package Net::API::Stripe::Fraud::Review;
BEGIN
{
    use strict;
    use parent qw( Net::API::Stripe::Generic );
    our( $VERSION ) = 'v0.100.0';
};

sub id { return( shift->_set_get_scalar( 'id', @_ ) ); }

sub object { return( shift->_set_get_scalar( 'object', @_ ) ); }

sub billing_zip { return( shift->_set_get_scalar( 'billing_zip', @_ ) ); }

sub charge { return( shift->_set_get_scalar_or_object( 'charge', 'Net::API::Stripe::Charge', @_ ) ); }

sub closed_reason { return( shift->_set_get_scalar( 'closed_reason', @_ ) ); }

sub created { return( shift->_set_get_datetime( 'created', @_ ) ); }

sub ip_address { return( shift->_set_get_scalar( 'ip_address', @_ ) ); }

sub ip_address_location { return( shift->_set_get_hash_as_object( 'ip_address_location', 'Net::API::Stripe::GeoLocation', @_ ) ); }

sub livemode { return( shift->_set_get_boolean( 'livemode', @_ ) ); }

sub open { return( shift->_set_get_boolean( 'open', @_ ) ); }

sub opened_reason { return( shift->_set_get_scalar( 'opened_reason', @_ ) ); }

sub payment_intent { return( shift->_set_get_scalar_or_object( 'payment_intent', 'Net::API::Stripe::Payment::Intent', @_ ) ); }

sub reason { return( shift->_set_get_scalar( 'reason', @_ ) ); }

sub session { return( shift->_set_get_object( 'session', 'Net::API::Stripe::Fraud::Review::Session', @_ ) ); }

1;

__END__

=encoding utf8

=head1 NAME

Net::API::Stripe::Fraud::Review - A Stripe Fraud Review Object

=head1 SYNOPSIS

    my $review = $stripe->review({
        billing_zip => '123-4567',
        # Could also be a Net::API::Stripe::Charge object when expanded
        charge => 'ch_fake1234567890',
        ip_address => '1.2.3.4',
        ip_address_location => 
            {
            city => 'Tokyo',
            country => 'jp',
            latitude => '35.6935496',
            longitude => '139.7461204',
            region => undef,
            },
        open => $stripe->true,
        payment_intent => $payment_intent_object,
        reason => 'Some issue',
        session => $session_object,
    });

See documentation in L<Net::API::Stripe> for example to make api calls to Stripe to create those objects.

=head1 VERSION

    v0.100.0

=head1 DESCRIPTION

Reviews can be used to supplement automated fraud detection with human expertise.

=head1 CONSTRUCTOR

=over 4

=item B<new>( %ARG )

Creates a new L<Net::API::Stripe::Fraud::Review> object.
It may also take an hash like arguments, that also are method of the same name.

=back

=head1 METHODS

=over 4

=item B<id> string

Unique identifier for the object.

=item B<object> string, value is "review"

String representing the object’s type. Objects of the same type share the same value.

=item B<billing_zip> string

The ZIP or postal code of the card used, if applicable.

=item B<charge> string (expandable)

The charge associated with this review.

When expanded, this is a L<Net::API::Stripe::Charge> object.

=item B<closed_reason> string

The reason the review was closed, or null if it has not yet been closed. One of approved, refunded, refunded_as_fraud, or disputed.

=item B<created> timestamp

Time at which the object was created. Measured in seconds since the Unix epoch.

=item B<ip_address> string

The IP address where the payment originated.

=item B<ip_address_location> hash

Information related to the location of the payment. Note that this information is an approximation and attempts to locate the nearest population center - it should not be used to determine a specific address.

This is a L<Net::API::Stripe::GeoLocation> object.

=item B<livemode> boolean

Has the value true if the object exists in live mode or the value false if the object exists in test mode.

=item B<open> boolean

If true, the review needs action.

=item B<opened_reason> string

The reason the review was opened. One of rule or manual.

=item B<payment_intent> string (expandable)

The PaymentIntent ID associated with this review, if one exists.

When expanded, this is a L<Net::API::Stripe::Payment::Intent> object.

=item B<reason> string

The reason the review is currently open or closed. One of rule, manual, approved, refunded, refunded_as_fraud, or disputed.

=item B<session> hash

Information related to the browsing session of the user who initiated the payment.

This is a L<Net::API::Stripe::Session> object.

=back

=head1 API SAMPLE

	{
	  "id": "prv_fake123456789",
	  "object": "review",
	  "billing_zip": null,
	  "charge": "ch_fake123456789",
	  "closed_reason": null,
	  "created": 1571480456,
	  "ip_address": null,
	  "ip_address_location": null,
	  "livemode": false,
	  "open": true,
	  "opened_reason": "rule",
	  "reason": "rule",
	  "session": null
	}

=head1 HISTORY

=head2 v0.1

Initial version

=head1 AUTHOR

Jacques Deguest E<lt>F<jack@deguest.jp>E<gt>

=head1 SEE ALSO

Stripe API documentation:

L<https://stripe.com/docs/api/radar/reviews>, L<https://stripe.com/radar>

=head1 COPYRIGHT & LICENSE

Copyright (c) 2019-2020 DEGUEST Pte. Ltd.

You can use, copy, modify and redistribute this package and associated
files under the same terms as Perl itself.

=cut
