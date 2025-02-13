
#line 638 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
/*
 * THIS FILE WAS GENERATED BY PDL::PP! Do not modify!
 */

#define PDL_COMMENT(comment)
PDL_COMMENT("This preprocessor symbol is used to add commentary in the PDL  ")
PDL_COMMENT("autogenerated code. Normally, one would use typical C-style    ")
PDL_COMMENT("multiline comments (i.e. /* comment */). However, because such ")
PDL_COMMENT("comments do not nest, it's not possible for PDL::PP users to   ")
PDL_COMMENT("comment-out sections of code using multiline comments, as is   ")
PDL_COMMENT("often the practice when debugging, for example. So, when you   ")
PDL_COMMENT("see something like this:                                       ")
PDL_COMMENT("                                                               ")
                PDL_COMMENT("Memory access")
PDL_COMMENT("                                                               ")
PDL_COMMENT("just think of it as a C multiline comment like:                ")
PDL_COMMENT("                                                               ")
PDL_COMMENT("   /* Memory access */                                         ")

#define PDL_FREE_CODE(trans, destroy, comp_free_code, ntpriv_free_code) \
    if (destroy) { \
	comp_free_code \
    } \
    if ((trans)->dims_redone) { \
	ntpriv_free_code \
    }

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "pdl.h"
#include "pdlcore.h"
#define PDL PDL_NDBin_Actions_PP
extern Core* PDL; PDL_COMMENT("Structure hold core C functions")
static int __pdl_boundscheck = 0;
static SV* CoreSV;       PDL_COMMENT("Gets pointer to perl var holding core structure")

#if ! 1
# define PP_INDTERM(max, at) at
#else
# define PP_INDTERM(max, at) (__pdl_boundscheck? PDL->safe_indterm(max,at, __FILE__, __LINE__) : at)
#endif
#line 46 "pp-_istddev_post.c"

#line 1295 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
pdl_error pdl__istddev_post_readdata(pdl_trans *__privtrans) {
pdl_error PDL_err = {0, NULL, 0};


#line 154 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
PDL_COMMENT("threadloop declarations")
int __thrloopval;
register PDL_Indx __tind0,__tind1; PDL_COMMENT("counters along dim")
register PDL_Indx __tnpdls = __privtrans->pdlthread.npdls;
PDL_COMMENT("dims here are how many steps along those dims")
register PDL_Indx __tinc0_in = PDL_THR_INC(__privtrans->pdlthread.incs,__tnpdls,0,0);
register PDL_Indx __tinc0_count = PDL_THR_INC(__privtrans->pdlthread.incs,__tnpdls,1,0);
register PDL_Indx __tinc0_out = PDL_THR_INC(__privtrans->pdlthread.incs,__tnpdls,2,0);
register PDL_Indx __tinc1_in = PDL_THR_INC(__privtrans->pdlthread.incs,__tnpdls,0,1);
register PDL_Indx __tinc1_count = PDL_THR_INC(__privtrans->pdlthread.incs,__tnpdls,1,1);
register PDL_Indx __tinc1_out = PDL_THR_INC(__privtrans->pdlthread.incs,__tnpdls,2,1);
#line 1311 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 177 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
#define PDL_DECLARE_PARAMS__istddev_post(PDL_PARAMTYPE_in,PDL_PARAMTYPE_count,PDL_PARAMTYPE_out) \
  PDL_DECLARE_PARAMETER_BADVAL(PDL_PARAMTYPE_in, (__privtrans->vtable->per_pdl_flags[0]), in, (__privtrans->pdls[0])) \
PDL_DECLARE_PARAMETER_BADVAL(PDL_PARAMTYPE_count, (__privtrans->vtable->per_pdl_flags[1]), count, (__privtrans->pdls[1])) \
PDL_DECLARE_PARAMETER_BADVAL(PDL_PARAMTYPE_out, (__privtrans->vtable->per_pdl_flags[2]), out, (__privtrans->pdls[2]))
#line 1318 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_COMMENT("Start generic loop")
	switch(__privtrans->__datatype) {

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_SB: {
#line 1324 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) f

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_SByte,PDL_Indx,PDL_SByte)
#line 1331 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1368 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_B: {
#line 1372 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) t

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_Byte,PDL_Indx,PDL_Byte)
#line 1379 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1416 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_S: {
#line 1420 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) f

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_Short,PDL_Indx,PDL_Short)
#line 1427 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1464 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_US: {
#line 1468 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) t

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_Ushort,PDL_Indx,PDL_Ushort)
#line 1475 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1512 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_L: {
#line 1516 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) f

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_Long,PDL_Indx,PDL_Long)
#line 1523 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1560 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_UL: {
#line 1564 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) t

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_ULong,PDL_Indx,PDL_ULong)
#line 1571 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1608 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_IND: {
#line 1612 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) f

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_Indx,PDL_Indx,PDL_Indx)
#line 1619 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1656 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_ULL: {
#line 1660 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) t

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_ULongLong,PDL_Indx,PDL_ULongLong)
#line 1667 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1704 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_LL: {
#line 1708 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) t
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) f

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_LongLong,PDL_Indx,PDL_LongLong)
#line 1715 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1752 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_F: {
#line 1756 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) f
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) f

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_Float,PDL_Indx,PDL_Float)
#line 1763 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1800 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_D: {
#line 1804 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) f
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) f

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_Double,PDL_Indx,PDL_Double)
#line 1811 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1848 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 510 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
case PDL_LD: {
#line 1852 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
#define PDL_IF_GENTYPE_INTEGER(t,f) f
#define PDL_IF_GENTYPE_REAL(t,f) t
#define PDL_IF_GENTYPE_UNSIGNED(t,f) f

#line 503 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
		PDL_DECLARE_PARAMS__istddev_post(PDL_LDouble,PDL_Indx,PDL_LDouble)
#line 1859 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_THREADLOOP_START(
readdata,
__privtrans->pdlthread,
__privtrans->vtable,
	in_datap += __offsp[0];
	count_datap += __offsp[1];
	out_datap += __offsp[2];
,
(	,in_datap += __tinc1_in - __tinc0_in * __tdims0
	,count_datap += __tinc1_count - __tinc0_count * __tdims0
	,out_datap += __tinc1_out - __tinc0_out * __tdims0
),
(	,in_datap += __tinc0_in
	,count_datap += __tinc0_count
	,out_datap += __tinc0_out
)
)
{

		if( ! (count_datap)[0] ) { (out_datap)[0]=out_badval; }
		else { (out_datap)[0] = sqrt( (in_datap)[0] / (count_datap)[0] ); }
	
}PDL_THREADLOOP_END(
__privtrans->pdlthread,
in_datap -= __tinc1_in * __tdims1 + __offsp[0];
count_datap -= __tinc1_count * __tdims1 + __offsp[1];
out_datap -= __tinc1_out * __tdims1 + __offsp[2];

)

#undef PDL_IF_GENTYPE_INTEGER
#undef PDL_IF_GENTYPE_REAL
#undef PDL_IF_GENTYPE_UNSIGNED

#line 521 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/PDLCode.pm"
} break;
#line 1896 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

	default:return PDL->make_error(PDL_EUSERERROR, "PP INTERNAL ERROR in _istddev_post: unhandled datatype(%d), only handles (ABSULKNPQFDE)! PLEASE MAKE A BUG REPORT\n", __privtrans->__datatype);}
return PDL_err;}
#line 654 "pp-_istddev_post.c"



#line 2238 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
static pdl_datatypes pdl__istddev_post_vtable_gentypes[] = { PDL_SB, PDL_B, PDL_S, PDL_US, PDL_L, PDL_UL, PDL_IND, PDL_ULL, PDL_LL, PDL_F, PDL_D, PDL_LD, -1 };
static char pdl__istddev_post_vtable_flags[] = {
  PDL_TPDL_VAFFINE_OK, PDL_TPDL_VAFFINE_OK, PDL_TPDL_VAFFINE_OK
};
static PDL_Indx pdl__istddev_post_vtable_realdims[] = { 0, 0, 0 };
static char *pdl__istddev_post_vtable_parnames[] = { "in","count","out" };
static short pdl__istddev_post_vtable_parflags[] = {
  0,
  PDL_PARAM_ISTYPED,
  PDL_PARAM_ISCREAT|PDL_PARAM_ISOUT|PDL_PARAM_ISWRITE
};
static pdl_datatypes pdl__istddev_post_vtable_partypes[] = { -1, PDL_IND, -1 };
static PDL_Indx pdl__istddev_post_vtable_realdims_starts[] = { 0, 0, 0 };
static PDL_Indx pdl__istddev_post_vtable_realdims_ind_ids[] = { 0 };
static char *pdl__istddev_post_vtable_indnames[] = { "" };
pdl_transvtable pdl__istddev_post_vtable = {
  PDL_TRANS_DO_THREAD|PDL_TRANS_BADPROCESS, 0, pdl__istddev_post_vtable_gentypes, 2, 3, pdl__istddev_post_vtable_flags,
  pdl__istddev_post_vtable_realdims, pdl__istddev_post_vtable_parnames,
  pdl__istddev_post_vtable_parflags, pdl__istddev_post_vtable_partypes,
  pdl__istddev_post_vtable_realdims_starts, pdl__istddev_post_vtable_realdims_ind_ids, 0,
  0, pdl__istddev_post_vtable_indnames,
  NULL, pdl__istddev_post_readdata, NULL,
  NULL,
  0,"PDL::NDBin::Actions_PP::_istddev_post"
};
#line 684 "pp-_istddev_post.c"



#line 2159 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
pdl_error pdl__istddev_post_run(pdl  *in,pdl  *count,pdl  *out) {
pdl_error PDL_err = {0, NULL, 0};

#line 2135 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
if (!PDL) croak("PDL core struct is NULL, can't continue");
pdl_trans *__privtrans = PDL->create_trans(&pdl__istddev_post_vtable);
#line 2165 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 1998 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
__privtrans->pdls[0] = in;
#line 2169 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 1998 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
__privtrans->pdls[1] = count;
#line 2173 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 1998 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
__privtrans->pdls[2] = out;
#line 2177 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 2095 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_RETERROR(PDL_err, PDL->trans_check_pdls(__privtrans));
char 
#line 402 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
badflag_cache
#line 2099 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
 = PDL->trans_badflag_from_inputs(__privtrans);
#line 2186 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 1989 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_RETERROR(PDL_err, PDL->type_coerce(__privtrans));
#line 2190 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 2005 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
in = __privtrans->pdls[0];
#line 2194 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 2005 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
count = __privtrans->pdls[1];
#line 2198 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 2005 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
out = __privtrans->pdls[2];
#line 2202 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 164 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP/Signature.pm"
#line 2205 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

#line 2011 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
PDL_RETERROR(PDL_err, PDL->make_trans_mutual(__privtrans));
#line 2209 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"

		if( in == out && !
#line 383 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
(in->state & PDL_BADVAL)
#line 2214 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
 ) {
			PDL->propagate_badflag( out, 1 );
		}
		
#line 398 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
out->state |= PDL_BADVAL
#line 2221 "/home/osboxes/.perlbrew/libs/perl-5.32.0@normal/lib/perl5/x86_64-linux/PDL/PP.pm"
;
	return PDL_err;
}
#line 755 "pp-_istddev_post.c"
