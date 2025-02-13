#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::GSLSF::EXP;

our @EXPORT_OK = qw(gsl_sf_exp gsl_sf_exprel_n gsl_sf_exp_err );
our %EXPORT_TAGS = (Func=>\@EXPORT_OK);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;


   
   our @ISA = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::GSLSF::EXP ;






#line 4 "gsl_sf_exp.pd"

use strict;
use warnings;

=head1 NAME

PDL::GSLSF::EXP - PDL interface to GSL Special Functions

=head1 DESCRIPTION

This is an interface to the Special Function package present in the GNU Scientific Library. 

=cut
#line 39 "EXP.pm"






=head1 FUNCTIONS

=cut




#line 948 "../../../../blib/lib/PDL/PP.pm"



=head2 gsl_sf_exp

=for sig

  Signature: (double x(); double [o]y(); double [o]e())

=for ref

Exponential

=for bad

gsl_sf_exp does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 74 "EXP.pm"



#line 950 "../../../../blib/lib/PDL/PP.pm"

*gsl_sf_exp = \&PDL::gsl_sf_exp;
#line 81 "EXP.pm"



#line 948 "../../../../blib/lib/PDL/PP.pm"



=head2 gsl_sf_exprel_n

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

N-relative Exponential. exprel_N(x) = N!/x^N (exp(x) - Sum[x^k/k!, {k,0,N-1}]) = 1 + x/(N+1) + x^2/((N+1)(N+2)) + ... = 1F1(1,1+N,x)

=for bad

gsl_sf_exprel_n does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 106 "EXP.pm"



#line 950 "../../../../blib/lib/PDL/PP.pm"

*gsl_sf_exprel_n = \&PDL::gsl_sf_exprel_n;
#line 113 "EXP.pm"



#line 948 "../../../../blib/lib/PDL/PP.pm"



=head2 gsl_sf_exp_err

=for sig

  Signature: (double x(); double dx(); double [o]y(); double [o]e())

=for ref

Exponential of a quantity with given error.

=for bad

gsl_sf_exp_err does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 138 "EXP.pm"



#line 950 "../../../../blib/lib/PDL/PP.pm"

*gsl_sf_exp_err = \&PDL::gsl_sf_exp_err;
#line 145 "EXP.pm"





#line 65 "gsl_sf_exp.pd"

=head1 AUTHOR

This file copyright (C) 1999 Christian Pellegrin <chri@infis.univ.trieste.it>
All rights reserved. There
is no warranty. You are allowed to redistribute this software /
documentation under certain conditions. For details, see the file
COPYING in the PDL distribution. If this file is separated from the
PDL distribution, the copyright notice should be included in the file.

The GSL SF modules were written by G. Jungman.

=cut
#line 165 "EXP.pm"




# Exit with OK status

1;
