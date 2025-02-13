package PDF::Builder::Resource::ColorSpace::DeviceN;

use base 'PDF::Builder::Resource::ColorSpace';

use strict;
use warnings;
#no warnings qw[ deprecated recursion uninitialized ];

our $VERSION = '3.023'; # VERSION
our $LAST_UPDATE = '3.021'; # manually update whenever code is changed

use PDF::Builder::Basic::PDF::Utils;
use PDF::Builder::Util;
use Scalar::Util qw(weaken);

=head1 NAME

PDF::Builder::Resource::ColorSpace::DeviceN - colorspace handling for Device 
CMYK. Inherits from L<PDF::Builder::Resource::ColorSpace>

=cut

sub new {
    my ($class, $pdf, $key, @opts) = @_;

    # this is a bit odd, but the only use of ->new() has two values, $clrs
    #  and $sampled, in the argument list
    my ($clrs, $sampled) = @opts;

    $sampled = 2;

    $class = ref $class if ref $class;
    my $self = $class->SUPER::new($pdf, $key);
    $pdf->new_obj($self) unless $self->is_obj($pdf);
    $self->{' apipdf'} = $pdf;
    weaken $self->{' apipdf'};

    my $fct = PDFDict();

    my $csname = $clrs->[0]->type();
    my @xclr = map { $_->color() } @{$clrs};
    my @xnam = map { $_->tintname() } @{$clrs};
    # $self->{' comments'} = "DeviceN ColorSpace\n";
    if ($csname eq 'DeviceCMYK') {
        @xclr = map { [ namecolor_cmyk($_) ] } @xclr;

        $fct->{'FunctionType'} = PDFNum(0);
        $fct->{'Order'} = PDFNum(3);
        $fct->{'Range'} = PDFArray(map {PDFNum($_)} (0,1,0,1,0,1,0,1));
        $fct->{'BitsPerSample'} = PDFNum(8);
        $fct->{'Domain'} = PDFArray();
        $fct->{'Size'} = PDFArray();
        foreach (@xclr) {
            $fct->{'Size'}->add_elements(PDFNum($sampled));
            $fct->{'Domain'}->add_elements(PDFNum(0), PDFNum(1));
        }
        my @spec = ();
        foreach my $xc (0 .. (scalar @xclr)-1) {
            foreach my $n (0 .. ($sampled**(scalar @xclr))-1) {
                $spec[$n] ||= [0,0,0,0];
                my $factor = ($n/($sampled**$xc)) % $sampled;
                # $self->{' comments'}.="C($n): xc=$xc i=$factor ";
                my @thiscolor = map { ($_*$factor)/($sampled-1) } @{$xclr[$xc]};
                # $self->{' comments'}.="(@{$xclr[$xc]}) --> (@thiscolor) ";
                foreach my $s (0..3) {
                    $spec[$n]->[$s] += $thiscolor[$s];
                }
                @{$spec[$n]} = map { $_>1? 1: $_ } @{$spec[$n]};
                # $self->{' comments'}.="--> (@{$spec[$n]})\n";
                # $self->{' comments'}.="\n";
            }
        }
        my @b = ();
        foreach my $s (@spec) {
            push(@b,(map { pack('C', ($_*255)) } @{$s}));
        }
        $fct->{' stream'} = join('', @b);
    } else {
        die "unsupported colorspace specification (=$csname).";
    }
    $fct->{'Filter'} = PDFArray(PDFName('ASCIIHexDecode'));
    $self->type($csname);
    $pdf->new_obj($fct);
    my $attr = PDFDict();
    foreach my $cs (@{$clrs}) {
        $attr->{$cs->tintname()} = $cs;
    }
    $self->add_elements(PDFName('DeviceN'), PDFArray(map { PDFName($_) } @xnam), PDFName($csname), $fct);

    return $self;
}

sub param {
    my $self = shift;

    return (@_);
}

1;
