#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::GSLSF::DILOG;

our @EXPORT_OK = qw(gsl_sf_dilog gsl_sf_complex_dilog );
our %EXPORT_TAGS = (Func=>\@EXPORT_OK);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;


   
   our @ISA = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::GSLSF::DILOG ;






#line 4 "gsl_sf_dilog.pd"

use strict;
use warnings;

=head1 NAME

PDL::GSLSF::DILOG - PDL interface to GSL Special Functions

=head1 DESCRIPTION

This is an interface to the Special Function package present in the GNU Scientific Library. 

=cut
#line 39 "DILOG.pm"






=head1 FUNCTIONS

=cut




#line 948 "../../../../blib/lib/PDL/PP.pm"



=head2 gsl_sf_dilog

=for sig

  Signature: (double x(); double [o]y(); double [o]e())

=for ref

/* Real part of DiLogarithm(x), for real argument. In Lewins notation, this is Li_2(x). Li_2(x) = - Re[ Integrate[ Log[1-s] / s, {s, 0, x}] ]

=for bad

gsl_sf_dilog does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 74 "DILOG.pm"



#line 950 "../../../../blib/lib/PDL/PP.pm"

*gsl_sf_dilog = \&PDL::gsl_sf_dilog;
#line 81 "DILOG.pm"



#line 948 "../../../../blib/lib/PDL/PP.pm"



=head2 gsl_sf_complex_dilog

=for sig

  Signature: (double r(); double t(); double [o]re(); double [o]im(); double [o]ere(); double [o]eim())

=for ref

DiLogarithm(z), for complex argument z = r Exp[i theta].

=for bad

gsl_sf_complex_dilog does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 106 "DILOG.pm"



#line 950 "../../../../blib/lib/PDL/PP.pm"

*gsl_sf_complex_dilog = \&PDL::gsl_sf_complex_dilog;
#line 113 "DILOG.pm"





#line 54 "gsl_sf_dilog.pd"

=head1 AUTHOR

This file copyright (C) 1999 Christian Pellegrin <chri@infis.univ.trieste.it>
All rights reserved. There
is no warranty. You are allowed to redistribute this software /
documentation under certain conditions. For details, see the file
COPYING in the PDL distribution. If this file is separated from the
PDL distribution, the copyright notice should be included in the file.

The GSL SF modules were written by G. Jungman.

=cut
#line 133 "DILOG.pm"




# Exit with OK status

1;
