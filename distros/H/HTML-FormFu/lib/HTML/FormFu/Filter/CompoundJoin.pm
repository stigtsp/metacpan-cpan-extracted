use strict;

package HTML::FormFu::Filter::CompoundJoin;
$HTML::FormFu::Filter::CompoundJoin::VERSION = '2.07';
# ABSTRACT: CompoundJoin filter

use Moose;
use MooseX::Attribute::Chained;
extends 'HTML::FormFu::Filter';

with 'HTML::FormFu::Role::Filter::Compound';

use HTML::FormFu::Constants qw( $EMPTY_STR $SPACE );

has join => ( is => 'rw', traits => ['Chained'] );

sub filter {
    my ( $self, $value ) = @_;

    return if !defined $value || $value eq $EMPTY_STR;

    my $join
        = defined $self->join
        ? $self->join
        : $SPACE;

    my @values = $self->_get_values($value);

    @values = grep { $_ ne '' } @values;

    $value = join $join, @values;

    return $value;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

HTML::FormFu::Filter::CompoundJoin - CompoundJoin filter

=head1 VERSION

version 2.07

=head1 SYNOPSIS

    ---
    element:
      - type: Multi
        name: address

        elements:
          - name: number
          - name: street

        filter:
          - type: CompoundJoin

    # get the compound-value

    my $address = $form->param_value('address');

=head1 DESCRIPTION

For use with a L<HTML::FormFu::Element::Multi> group of fields.

Joins the input from several fields into a single value.

=head1 METHODS

=head2 join

Arguments: $string

Default Value: C<' '>

String used to join the individually submitted parts. Defaults to a single
space.

=head2 field_order

Inherited. See L<HTML::FormFu::Filter::_Compound/field_order> for details.

    ---
    element:
      - type: Multi
        name: address

        elements:
          - name: street
          - name: number

        filter:
          - type: CompoundJoin
            field_order:
              - number
              - street

=head1 AUTHOR

Carl Franks, C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=head1 AUTHOR

Carl Franks <cpan@fireartist.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Carl Franks.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
