##----------------------------------------------------------------------------
## Stripe API - ~/lib/Net/API/Stripe/Issuing/Dispute/Evidence/Fraudulent.pm
## Version v0.100.0
## Copyright(c) 2019 DEGUEST Pte. Ltd.
## Author: Jacques Deguest <@sitael.tokyo.deguest.jp>
## Created 2019/11/02
## Modified 2020/05/15
## 
##----------------------------------------------------------------------------
package Net::API::Stripe::Issuing::Dispute::Evidence::Fraudulent;
BEGIN
{
    use strict;
    use parent qw( Net::API::Stripe::Generic );
    our( $VERSION ) = 'v0.100.0';
};

sub dispute_explanation { return( shift->_set_get_scalar( 'dispute_explanation', @_ ) ); }

sub uncategorized_file { return( shift->_set_get_scalar_or_object( 'uncategorized_file', 'Net::API::Stripe::File', @_ ) ); }

1;

__END__

=encoding utf8

=head1 NAME

Net::API::Stripe::Issuing::Dispute::Evidence::Fraudulent - A Stripe Issued Card Evidence Object

=head1 SYNOPSIS

    my $fraud = $stripe->issuing_dispute->evidence->fraudulent({
        dispute_explanation => 'Service not provided',
        uncategorized_file => $file_object,
    });

=head1 VERSION

    v0.100.0

=head1 DESCRIPTION

Evidence to support a fraudulent dispute. This will only be present if your dispute’s reason is fraudulent.

This is instantiated by method B<fraudulent> in module L<Net::API::Stripe::Issuing::Dispute>

=head1 CONSTRUCTOR

=over 4

=item B<new>( %ARG )

Creates a new L<Net::API::Stripe::Issuing::Dispute::Evidence::Fraudulent> object.
It may also take an hash like arguments, that also are method of the same name.

=back

=head1 METHODS

=over 4

=item B<dispute_explanation> string

Brief freeform text explaining why you are disputing this transaction.

=item B<uncategorized_file> string (expandable)

(ID of a file upload) Additional file evidence supporting your dispute.

When expanded, this is a L<Net::API::Stripe::File> object.

=back

=head1 API SAMPLE

	{
	  "id": "idp_fake123456789",
	  "object": "issuing.dispute",
	  "amount": 100,
	  "created": 1571480456,
	  "currency": "usd",
	  "disputed_transaction": "ipi_fake123456789",
	  "evidence": {
		"fraudulent": {
		  "dispute_explanation": "Fraud; card reported lost on 10/19/2019",
		  "uncategorized_file": null
		},
		"other": null
	  },
	  "livemode": false,
	  "metadata": {},
	  "reason": "fraudulent",
	  "status": "under_review"
	}

=head1 HISTORY

=head2 v0.1

Initial version

=head1 AUTHOR

Jacques Deguest E<lt>F<jack@deguest.jp>E<gt>

=head1 SEE ALSO

Stripe API documentation:

L<https://stripe.com/docs/api/issuing/disputes>, L<https://stripe.com/docs/issuing/disputes>

=head1 COPYRIGHT & LICENSE

Copyright (c) 2019-2020 DEGUEST Pte. Ltd.

You can use, copy, modify and redistribute this package and associated
files under the same terms as Perl itself.

=cut
