package PDF::Builder::Resource::ColorSpace::Indexed;

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

PDF::Builder::Resource::ColorSpace::Indexed - base colorspace support for indexed color models. Inherits from L<PDF::Builder::Resource::ColorSpace>

=cut

sub new {
    my ($class, $pdf, $key, %opts) = @_;

    $class = ref $class if ref $class;
    my $self = $class->SUPER::new($pdf,$key,%opts);
    $pdf->new_obj($self) unless $self->is_obj($pdf);
    $self->{' apipdf'} = $pdf;
    weaken $self->{' apipdf'};

    $self->add_elements(PDFName('Indexed'));
    $self->type('Indexed');

    return $self;
}

sub enumColors {
    my $self = shift;

    my %col = ();
    foreach my $n (0..255) {
        my $k = '#'.uc(unpack('H*', substr($self->{' csd'}->{' stream'}, $n*3, 3)));
        $col{$k} = $n unless defined $col{$k};
    }
    return %col;
}

sub nameColor {
    my $self = shift;
    my $n = shift;

    my %col = ();
    my $k = '#'.uc(unpack('H*', substr($self->{' csd'}->{' stream'}, $n*3, 3)));
    return $k;
}

sub resolveNearestRGB {
    my $self = shift;
    my ($r,$g,$b) = @_; # need to be in 0-255

    my $c = 0;
    my $w = 768**2;
    foreach my $n (0..255) {
        my @e = unpack('C*', substr($self->{' csd'}->{' stream'}, $n*3, 3));
        my $d = ($e[0]-$r)**2 + ($e[1]-$g)**2 + ($e[2]-$b)**2;
        if ($d < $w) { 
	    $c = $n; 
	    $w = $d; 
        }
    }
    return $c;
}

1;

__END__

} elsif($opts{'-type'} eq 'Indexed') {

$opts{'-base'}||='DeviceRGB';
$opts{'-whitepoint'}||=[ 0.95049, 1, 1.08897 ];
$opts{'-blackpoint'}||=[ 0, 0, 0 ];
$opts{'-gamma'}||=[ 2.22218, 2.22218, 2.22218 ];

#       my $csd=PDFDict();
#       $csd->{WhitePoint}=PDFArray(map {PDFNum($_)} @{$opts{'-whitepoint'}});
#       $csd->{BlackPoint}=PDFArray(map {PDFNum($_)} @{$opts{'-blackpoint'}});
#       $csd->{Gamma}=PDFArray(map {PDFNum($_)} @{$opts{'-gamma'}});

my $csd=PDFDict();
$pdf->new_obj($csd);
$csd->{Filter}=PDFArray(PDFName('FlateDecode'));
$self->{' index'}=[];

if(defined $opts{'-actfile'}) {
} elsif(defined $opts{'-acofile'}) {
} elsif(defined $opts{'-colors'}) {
$opts{'-maxindex'}||=scalar(@{$opts{'-colors'}})-1;

foreach my $col (@{$opts{'-colors'}}) {
map { $csd->{' stream'}.=pack('C',$_); } @{$col};
}

foreach my $col (0..$opts{'-maxindex'}) {
if($opts{'-base'}=~/RGB/i) {
my $r=(shift(@{$opts{'-colors'}})||0)/255;
my $g=(shift(@{$opts{'-colors'}})||0)/255;
my $b=(shift(@{$opts{'-colors'}})||0)/255;
push(@{$self->{' index'}},[$r,$g,$b]);
} elsif($opts{'-base'}=~/CMYK/i) {
my $c=(shift(@{$opts{'-colors'}})||0)/255;
my $m=(shift(@{$opts{'-colors'}})||0)/255;
my $y=(shift(@{$opts{'-colors'}})||0)/255;
my $k=(shift(@{$opts{'-colors'}})||0)/255;
push(@{$self->{' index'}},[$c,$m,$y,$k]);
}
}
} else {
die "unspecified color index table.";
}

    $self->add_elements(PDFName('Indexed'),PDFName($opts{'-base'}),PDFNum($opts{'-maxindex'}),$csd);

$self->{' type'}='index-'.(
$opts{'-base'}=~/RGB/i ? 'rgb' :
$opts{'-base'}=~/CMYK/i ? 'cmyk' : 'unknown'
);

