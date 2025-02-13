package Chart::Plotly::Trace::Bar::Error_x;
use Moose;
use MooseX::ExtraArgs;
use Moose::Util::TypeConstraints qw(enum union);
if ( !defined Moose::Util::TypeConstraints::find_type_constraint('PDL') ) {
    Moose::Util::TypeConstraints::type('PDL');
}

our $VERSION = '0.041';    # VERSION

# ABSTRACT: This attribute is one of the possible options for the trace bar.

sub TO_JSON {
    my $self       = shift;
    my $extra_args = $self->extra_args // {};
    my $meta       = $self->meta;
    my %hash       = %$self;
    for my $name ( sort keys %hash ) {
        my $attr = $meta->get_attribute($name);
        if ( defined $attr ) {
            my $value = $hash{$name};
            my $type  = $attr->type_constraint;
            if ( $type && $type->equals('Bool') ) {
                $hash{$name} = $value ? \1 : \0;
            }
        }
    }
    %hash = ( %hash, %$extra_args );
    delete $hash{'extra_args'};
    if ( $self->can('type') && ( !defined $hash{'type'} ) ) {
        $hash{type} = $self->type();
    }
    return \%hash;
}

has array => (
      is  => "rw",
      isa => "ArrayRef|PDL",
      documentation =>
        "Sets the data corresponding the length of each error bar. Values are plotted relative to the underlying data.",
);

has arrayminus => (
    is  => "rw",
    isa => "ArrayRef|PDL",
    documentation =>
      "Sets the data corresponding the length of each error bar in the bottom (left) direction for vertical (horizontal) bars Values are plotted relative to the underlying data.",
);

has arrayminussrc => ( is            => "rw",
                       isa           => "Str",
                       documentation => "Sets the source reference on plot.ly for  arrayminus .",
);

has arraysrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on plot.ly for  array .",
);

has color => ( is            => "rw",
               isa           => "Str",
               documentation => "Sets the stoke color of the error bars.",
);

has copy_ystyle => ( is  => "rw",
                     isa => "Bool", );

has symmetric => (
    is  => "rw",
    isa => "Bool",
    documentation =>
      "Determines whether or not the error bars have the same length in both direction (top/bottom for vertical bars, left/right for horizontal bars.",
);

has thickness => ( is            => "rw",
                   isa           => "Num",
                   documentation => "Sets the thickness (in px) of the error bars.",
);

has traceref => ( is  => "rw",
                  isa => "Int", );

has tracerefminus => ( is  => "rw",
                       isa => "Int", );

has value => (
    is  => "rw",
    isa => "Num",
    documentation =>
      "Sets the value of either the percentage (if `type` is set to *percent*) or the constant (if `type` is set to *constant*) corresponding to the lengths of the error bars.",
);

has valueminus => (
    is  => "rw",
    isa => "Num",
    documentation =>
      "Sets the value of either the percentage (if `type` is set to *percent*) or the constant (if `type` is set to *constant*) corresponding to the lengths of the error bars in the bottom (left) direction for vertical (horizontal) bars",
);

has visible => ( is            => "rw",
                 isa           => "Bool",
                 documentation => "Determines whether or not this set of error bars is visible.",
);

has width => ( is            => "rw",
               isa           => "Num",
               documentation => "Sets the width (in px) of the cross-bar at both ends of the error bars.",
);

__PACKAGE__->meta->make_immutable();
1;

__END__

=pod

=encoding utf-8

=head1 NAME

Chart::Plotly::Trace::Bar::Error_x - This attribute is one of the possible options for the trace bar.

=head1 VERSION

version 0.041

=head1 SYNOPSIS

 use Chart::Plotly;
 use Chart::Plotly::Trace::Bar;
 use Chart::Plotly::Plot;
 my $x = [ "apples", "bananas", "cherries" ];
 my $sample1 = Chart::Plotly::Trace::Bar->new( x    => $x,
                                               y    => [ map { int( rand() * 10 ) } ( 1 .. ( scalar(@$x) ) ) ],
                                               name => "sample1"
 );
 my $sample2 = Chart::Plotly::Trace::Bar->new( x    => $x,
                                               y    => [ map { int( rand() * 10 ) } ( 1 .. ( scalar(@$x) ) ) ],
                                               name => "sample2"
 );
 my $sample3 = Chart::Plotly::Trace::Bar->new( x    => $x,
                                               y    => [ map { int( rand() * 10 ) } ( 1 .. ( scalar(@$x) ) ) ],
                                               name => "sample3"
 );
 my $plot = Chart::Plotly::Plot->new( traces => [ $sample1, $sample2, $sample3 ], layout => { barmode => 'group' } );
 Chart::Plotly::show_plot($plot);

=head1 DESCRIPTION

This attribute is part of the possible options for the trace bar.

This file has been autogenerated from the official plotly.js source.

If you like Plotly, please support them: L<https://plot.ly/> 
Open source announcement: L<https://plot.ly/javascript/open-source-announcement/>

Full reference: L<https://plot.ly/javascript/reference/#bar>

=head1 DISCLAIMER

This is an unofficial Plotly Perl module. Currently I'm not affiliated in any way with Plotly. 
But I think plotly.js is a great library and I want to use it with perl.

=head1 METHODS

=head2 TO_JSON

Serialize the trace to JSON. This method should be called only by L<JSON> serializer.

=head1 ATTRIBUTES

=over

=item * array

Sets the data corresponding the length of each error bar. Values are plotted relative to the underlying data.

=item * arrayminus

Sets the data corresponding the length of each error bar in the bottom (left) direction for vertical (horizontal) bars Values are plotted relative to the underlying data.

=item * arrayminussrc

Sets the source reference on plot.ly for  arrayminus .

=item * arraysrc

Sets the source reference on plot.ly for  array .

=item * color

Sets the stoke color of the error bars.

=item * copy_ystyle

=item * symmetric

Determines whether or not the error bars have the same length in both direction (top/bottom for vertical bars, left/right for horizontal bars.

=item * thickness

Sets the thickness (in px) of the error bars.

=item * traceref

=item * tracerefminus

=item * value

Sets the value of either the percentage (if `type` is set to *percent*) or the constant (if `type` is set to *constant*) corresponding to the lengths of the error bars.

=item * valueminus

Sets the value of either the percentage (if `type` is set to *percent*) or the constant (if `type` is set to *constant*) corresponding to the lengths of the error bars in the bottom (left) direction for vertical (horizontal) bars

=item * visible

Determines whether or not this set of error bars is visible.

=item * width

Sets the width (in px) of the cross-bar at both ends of the error bars.

=back

=head1 AUTHOR

Pablo Rodríguez González <pablo.rodriguez.gonzalez@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2020 by Pablo Rodríguez González.

This is free software, licensed under:

  The MIT (X11) License

=cut
