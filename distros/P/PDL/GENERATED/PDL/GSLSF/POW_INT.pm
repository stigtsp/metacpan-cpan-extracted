#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::GSLSF::POW_INT;

our @EXPORT_OK = qw(gsl_sf_pow_int );
our %EXPORT_TAGS = (Func=>\@EXPORT_OK);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;


   
   our @ISA = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::GSLSF::POW_INT ;






#line 4 "gsl_sf_pow_int.pd"

use strict;
use warnings;

=head1 NAME

PDL::GSLSF::POW_INT - PDL interface to GSL Special Functions

=head1 DESCRIPTION

This is an interface to the Special Function package present in the GNU Scientific Library. 

=cut
#line 39 "POW_INT.pm"






=head1 FUNCTIONS

=cut




#line 948 "../../../../blib/lib/PDL/PP.pm"



=head2 gsl_sf_pow_int

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

Calculate x^n.

=for bad

gsl_sf_pow_int does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 74 "POW_INT.pm"



#line 950 "../../../../blib/lib/PDL/PP.pm"

*gsl_sf_pow_int = \&PDL::gsl_sf_pow_int;
#line 81 "POW_INT.pm"





#line 42 "gsl_sf_pow_int.pd"

=head1 AUTHOR

This file copyright (C) 1999 Christian Pellegrin <chri@infis.univ.trieste.it>
All rights reserved. There
is no warranty. You are allowed to redistribute this software /
documentation under certain conditions. For details, see the file
COPYING in the PDL distribution. If this file is separated from the
PDL distribution, the copyright notice should be included in the file.

The GSL SF modules were written by G. Jungman.

=cut
#line 101 "POW_INT.pm"




# Exit with OK status

1;
