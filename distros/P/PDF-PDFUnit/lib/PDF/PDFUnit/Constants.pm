#
# Do not edit this file (it is autogenerated)!
#

#####################
package PDF::PDFUnit;
#####################

# We want to make this stuff usable by just doing "use PDF::PDFUnit".
# Therefore no different namespace here!

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
push @PDF::PDFUnit::EXPORT, qw(
    A0_LANDSCAPE
    A0_PORTRAIT
    A1_LANDSCAPE
    A1_PORTRAIT
    A2_LANDSCAPE
    A2_PORTRAIT
    A3_LANDSCAPE
    A3_PORTRAIT
    A4_LANDSCAPE
    A4_PORTRAIT
    A5_LANDSCAPE
    A5_PORTRAIT
    A6_LANDSCAPE
    A6_PORTRAIT
    ALLOW_SCREENREADERS
    ANY_PAGE
    ASSEMBLE_DOCUMENTS
    AS_DATE
    AS_DATETIME
    AS_RESULTTYPE_BOOLEAN
    AS_RESULTTYPE_NODE
    AS_RESULTTYPE_NODESET
    AS_RESULTTYPE_NUMBER
    AS_RESULTTYPE_STRING
    CHECKBOX
    CHOICE
    COMBO
    COMPARED_BY_CONTENT
    COMPARED_BY_NAME
    DEGREES_180
    DEGREES_270
    DEGREES_90
    EACH_PAGE
    EVEN_PAGES
    EVERY_PAGE
    EXTRACT_CONTENT
    FILL_IN
    FIRST_PAGE
    FONTTYPE_CID
    FONTTYPE_CID_TYPE0
    FONTTYPE_CID_TYPE2
    FONTTYPE_MMTYPE1
    FONTTYPE_OPENTYPE
    FONTTYPE_TRUETYPE
    FONTTYPE_TYPE0
    FONTTYPE_TYPE1
    FONTTYPE_TYPE3
    FORM_FILLING
    FORM_FILLING_AND_ANNOTATIONS
    HORIZONTALLY
    IDENTIFIEDBY_ALLPROPERTIES
    IDENTIFIEDBY_BASENAME
    IDENTIFIEDBY_EMBEDDED
    IDENTIFIEDBY_NAME
    IDENTIFIEDBY_NAME_TYPE
    IDENTIFIEDBY_TYPE
    IGNORE
    IGNORE_WHITESPACES
    KEEP
    KEEP_WHITESPACES
    LAST_PAGE
    LETTER_LANDSCAPE
    LETTER_PORTRAIT
    LIST
    MILLIMETER
    MILLIMETERS
    MODIFY_ANNOTATIONS
    MODIFY_CONTENT
    NORMALIZE
    NORMALIZE_WHITESPACES
    NO_CHANGES_ALLOWED
    ODD_PAGES
    ON_ANY_PAGE
    ON_EACH_PAGE
    ON_EVEN_PAGES
    ON_EVERY_PAGE
    ON_FIRST_PAGE
    ON_LAST_PAGE
    ON_ODD_PAGES
    PDFA_1A
    PDFA_1B
    PDFVERSION_11
    PDFVERSION_12
    PDFVERSION_13
    PDFVERSION_14
    PDFVERSION_15
    PDFVERSION_16
    PDFVERSION_17
    POINTS
    PRINT_DEGRADED_ONLY
    PRINT_IN_HIGHQUALITY
    PUSHBUTTON
    RADIOBUTTON
    SIGNATURE
    TEXT
    VERTICALLY
);

sub A0_LANDSCAPE { $com::pdfunit::Constants::A0_LANDSCAPE }
sub A0_PORTRAIT { $com::pdfunit::Constants::A0_PORTRAIT }
sub A1_LANDSCAPE { $com::pdfunit::Constants::A1_LANDSCAPE }
sub A1_PORTRAIT { $com::pdfunit::Constants::A1_PORTRAIT }
sub A2_LANDSCAPE { $com::pdfunit::Constants::A2_LANDSCAPE }
sub A2_PORTRAIT { $com::pdfunit::Constants::A2_PORTRAIT }
sub A3_LANDSCAPE { $com::pdfunit::Constants::A3_LANDSCAPE }
sub A3_PORTRAIT { $com::pdfunit::Constants::A3_PORTRAIT }
sub A4_LANDSCAPE { $com::pdfunit::Constants::A4_LANDSCAPE }
sub A4_PORTRAIT { $com::pdfunit::Constants::A4_PORTRAIT }
sub A5_LANDSCAPE { $com::pdfunit::Constants::A5_LANDSCAPE }
sub A5_PORTRAIT { $com::pdfunit::Constants::A5_PORTRAIT }
sub A6_LANDSCAPE { $com::pdfunit::Constants::A6_LANDSCAPE }
sub A6_PORTRAIT { $com::pdfunit::Constants::A6_PORTRAIT }
sub ALLOW_SCREENREADERS { $com::pdfunit::Constants::ALLOW_SCREENREADERS }
sub ANY_PAGE { $com::pdfunit::Constants::ANY_PAGE }
sub ASSEMBLE_DOCUMENTS { $com::pdfunit::Constants::ASSEMBLE_DOCUMENTS }
sub AS_DATE { $com::pdfunit::Constants::AS_DATE }
sub AS_DATETIME { $com::pdfunit::Constants::AS_DATETIME }
sub AS_RESULTTYPE_BOOLEAN { $com::pdfunit::Constants::AS_RESULTTYPE_BOOLEAN }
sub AS_RESULTTYPE_NODE { $com::pdfunit::Constants::AS_RESULTTYPE_NODE }
sub AS_RESULTTYPE_NODESET { $com::pdfunit::Constants::AS_RESULTTYPE_NODESET }
sub AS_RESULTTYPE_NUMBER { $com::pdfunit::Constants::AS_RESULTTYPE_NUMBER }
sub AS_RESULTTYPE_STRING { $com::pdfunit::Constants::AS_RESULTTYPE_STRING }
sub CHECKBOX { $com::pdfunit::Constants::CHECKBOX }
sub CHOICE { $com::pdfunit::Constants::CHOICE }
sub COMBO { $com::pdfunit::Constants::COMBO }
sub COMPARED_BY_CONTENT { $com::pdfunit::Constants::COMPARED_BY_CONTENT }
sub COMPARED_BY_NAME { $com::pdfunit::Constants::COMPARED_BY_NAME }
sub DEGREES_180 { $com::pdfunit::Constants::DEGREES_180 }
sub DEGREES_270 { $com::pdfunit::Constants::DEGREES_270 }
sub DEGREES_90 { $com::pdfunit::Constants::DEGREES_90 }
sub EACH_PAGE { $com::pdfunit::Constants::EACH_PAGE }
sub EVEN_PAGES { $com::pdfunit::Constants::EVEN_PAGES }
sub EVERY_PAGE { $com::pdfunit::Constants::EVERY_PAGE }
sub EXTRACT_CONTENT { $com::pdfunit::Constants::EXTRACT_CONTENT }
sub FILL_IN { $com::pdfunit::Constants::FILL_IN }
sub FIRST_PAGE { $com::pdfunit::Constants::FIRST_PAGE }
sub FONTTYPE_CID { $com::pdfunit::Constants::FONTTYPE_CID }
sub FONTTYPE_CID_TYPE0 { $com::pdfunit::Constants::FONTTYPE_CID_TYPE0 }
sub FONTTYPE_CID_TYPE2 { $com::pdfunit::Constants::FONTTYPE_CID_TYPE2 }
sub FONTTYPE_MMTYPE1 { $com::pdfunit::Constants::FONTTYPE_MMTYPE1 }
sub FONTTYPE_OPENTYPE { $com::pdfunit::Constants::FONTTYPE_OPENTYPE }
sub FONTTYPE_TRUETYPE { $com::pdfunit::Constants::FONTTYPE_TRUETYPE }
sub FONTTYPE_TYPE0 { $com::pdfunit::Constants::FONTTYPE_TYPE0 }
sub FONTTYPE_TYPE1 { $com::pdfunit::Constants::FONTTYPE_TYPE1 }
sub FONTTYPE_TYPE3 { $com::pdfunit::Constants::FONTTYPE_TYPE3 }
sub FORM_FILLING { $com::pdfunit::Constants::FORM_FILLING }
sub FORM_FILLING_AND_ANNOTATIONS { $com::pdfunit::Constants::FORM_FILLING_AND_ANNOTATIONS }
sub HORIZONTALLY { $com::pdfunit::Constants::HORIZONTALLY }
sub IDENTIFIEDBY_ALLPROPERTIES { $com::pdfunit::Constants::IDENTIFIEDBY_ALLPROPERTIES }
sub IDENTIFIEDBY_BASENAME { $com::pdfunit::Constants::IDENTIFIEDBY_BASENAME }
sub IDENTIFIEDBY_EMBEDDED { $com::pdfunit::Constants::IDENTIFIEDBY_EMBEDDED }
sub IDENTIFIEDBY_NAME { $com::pdfunit::Constants::IDENTIFIEDBY_NAME }
sub IDENTIFIEDBY_NAME_TYPE { $com::pdfunit::Constants::IDENTIFIEDBY_NAME_TYPE }
sub IDENTIFIEDBY_TYPE { $com::pdfunit::Constants::IDENTIFIEDBY_TYPE }
sub IGNORE { $com::pdfunit::Constants::IGNORE }
sub IGNORE_WHITESPACES { $com::pdfunit::Constants::IGNORE_WHITESPACES }
sub KEEP { $com::pdfunit::Constants::KEEP }
sub KEEP_WHITESPACES { $com::pdfunit::Constants::KEEP_WHITESPACES }
sub LAST_PAGE { $com::pdfunit::Constants::LAST_PAGE }
sub LETTER_LANDSCAPE { $com::pdfunit::Constants::LETTER_LANDSCAPE }
sub LETTER_PORTRAIT { $com::pdfunit::Constants::LETTER_PORTRAIT }
sub LIST { $com::pdfunit::Constants::LIST }
sub MILLIMETER { $com::pdfunit::Constants::MILLIMETER }
sub MILLIMETERS { $com::pdfunit::Constants::MILLIMETERS }
sub MODIFY_ANNOTATIONS { $com::pdfunit::Constants::MODIFY_ANNOTATIONS }
sub MODIFY_CONTENT { $com::pdfunit::Constants::MODIFY_CONTENT }
sub NORMALIZE { $com::pdfunit::Constants::NORMALIZE }
sub NORMALIZE_WHITESPACES { $com::pdfunit::Constants::NORMALIZE_WHITESPACES }
sub NO_CHANGES_ALLOWED { $com::pdfunit::Constants::NO_CHANGES_ALLOWED }
sub ODD_PAGES { $com::pdfunit::Constants::ODD_PAGES }
sub ON_ANY_PAGE { $com::pdfunit::Constants::ON_ANY_PAGE }
sub ON_EACH_PAGE { $com::pdfunit::Constants::ON_EACH_PAGE }
sub ON_EVEN_PAGES { $com::pdfunit::Constants::ON_EVEN_PAGES }
sub ON_EVERY_PAGE { $com::pdfunit::Constants::ON_EVERY_PAGE }
sub ON_FIRST_PAGE { $com::pdfunit::Constants::ON_FIRST_PAGE }
sub ON_LAST_PAGE { $com::pdfunit::Constants::ON_LAST_PAGE }
sub ON_ODD_PAGES { $com::pdfunit::Constants::ON_ODD_PAGES }
sub PDFA_1A { $com::pdfunit::Constants::PDFA_1A }
sub PDFA_1B { $com::pdfunit::Constants::PDFA_1B }
sub PDFVERSION_11 { $com::pdfunit::Constants::PDFVERSION_11 }
sub PDFVERSION_12 { $com::pdfunit::Constants::PDFVERSION_12 }
sub PDFVERSION_13 { $com::pdfunit::Constants::PDFVERSION_13 }
sub PDFVERSION_14 { $com::pdfunit::Constants::PDFVERSION_14 }
sub PDFVERSION_15 { $com::pdfunit::Constants::PDFVERSION_15 }
sub PDFVERSION_16 { $com::pdfunit::Constants::PDFVERSION_16 }
sub PDFVERSION_17 { $com::pdfunit::Constants::PDFVERSION_17 }
sub POINTS { $com::pdfunit::Constants::POINTS }
sub PRINT_DEGRADED_ONLY { $com::pdfunit::Constants::PRINT_DEGRADED_ONLY }
sub PRINT_IN_HIGHQUALITY { $com::pdfunit::Constants::PRINT_IN_HIGHQUALITY }
sub PUSHBUTTON { $com::pdfunit::Constants::PUSHBUTTON }
sub RADIOBUTTON { $com::pdfunit::Constants::RADIOBUTTON }
sub SIGNATURE { $com::pdfunit::Constants::SIGNATURE }
sub TEXT { $com::pdfunit::Constants::TEXT }
sub VERTICALLY { $com::pdfunit::Constants::VERTICALLY }

1;

__END__

=head1 NAME

PDF::PDFUnit::Constants - Constants exported by PDF::PDFUnit

=head1 DESCRIPTION

I<PDF::PDFUnit> exports the following constants
into your namespace (in alphabetical order):

=over


=item B<A0_LANDSCAPE>


=item B<A0_PORTRAIT>


=item B<A1_LANDSCAPE>


=item B<A1_PORTRAIT>


=item B<A2_LANDSCAPE>


=item B<A2_PORTRAIT>


=item B<A3_LANDSCAPE>


=item B<A3_PORTRAIT>


=item B<A4_LANDSCAPE>


=item B<A4_PORTRAIT>


=item B<A5_LANDSCAPE>


=item B<A5_PORTRAIT>


=item B<A6_LANDSCAPE>


=item B<A6_PORTRAIT>


=item B<ALLOW_SCREENREADERS>


=item B<ANY_PAGE>


=item B<ASSEMBLE_DOCUMENTS>


=item B<AS_DATE>


=item B<AS_DATETIME>


=item B<AS_RESULTTYPE_BOOLEAN>


=item B<AS_RESULTTYPE_NODE>


=item B<AS_RESULTTYPE_NODESET>


=item B<AS_RESULTTYPE_NUMBER>


=item B<AS_RESULTTYPE_STRING>


=item B<CHECKBOX>


=item B<CHOICE>


=item B<COMBO>


=item B<COMPARED_BY_CONTENT>


=item B<COMPARED_BY_NAME>


=item B<DEGREES_180>


=item B<DEGREES_270>


=item B<DEGREES_90>


=item B<EACH_PAGE>


=item B<EVEN_PAGES>


=item B<EVERY_PAGE>


=item B<EXTRACT_CONTENT>


=item B<FILL_IN>


=item B<FIRST_PAGE>


=item B<FONTTYPE_CID>


=item B<FONTTYPE_CID_TYPE0>


=item B<FONTTYPE_CID_TYPE2>


=item B<FONTTYPE_MMTYPE1>


=item B<FONTTYPE_OPENTYPE>


=item B<FONTTYPE_TRUETYPE>


=item B<FONTTYPE_TYPE0>


=item B<FONTTYPE_TYPE1>


=item B<FONTTYPE_TYPE3>


=item B<FORM_FILLING>


=item B<FORM_FILLING_AND_ANNOTATIONS>


=item B<HORIZONTALLY>


=item B<IDENTIFIEDBY_ALLPROPERTIES>


=item B<IDENTIFIEDBY_BASENAME>


=item B<IDENTIFIEDBY_EMBEDDED>


=item B<IDENTIFIEDBY_NAME>


=item B<IDENTIFIEDBY_NAME_TYPE>


=item B<IDENTIFIEDBY_TYPE>


=item B<IGNORE>


=item B<IGNORE_WHITESPACES>


=item B<KEEP>


=item B<KEEP_WHITESPACES>


=item B<LAST_PAGE>


=item B<LETTER_LANDSCAPE>


=item B<LETTER_PORTRAIT>


=item B<LIST>


=item B<MILLIMETER>


=item B<MILLIMETERS>


=item B<MODIFY_ANNOTATIONS>


=item B<MODIFY_CONTENT>


=item B<NORMALIZE>


=item B<NORMALIZE_WHITESPACES>


=item B<NO_CHANGES_ALLOWED>


=item B<ODD_PAGES>


=item B<ON_ANY_PAGE>


=item B<ON_EACH_PAGE>


=item B<ON_EVEN_PAGES>


=item B<ON_EVERY_PAGE>


=item B<ON_FIRST_PAGE>


=item B<ON_LAST_PAGE>


=item B<ON_ODD_PAGES>


=item B<PDFA_1A>


=item B<PDFA_1B>


=item B<PDFVERSION_11>


=item B<PDFVERSION_12>


=item B<PDFVERSION_13>


=item B<PDFVERSION_14>


=item B<PDFVERSION_15>


=item B<PDFVERSION_16>


=item B<PDFVERSION_17>


=item B<POINTS>


=item B<PRINT_DEGRADED_ONLY>


=item B<PRINT_IN_HIGHQUALITY>


=item B<PUSHBUTTON>


=item B<RADIOBUTTON>


=item B<SIGNATURE>


=item B<TEXT>


=item B<VERTICALLY>


=back

