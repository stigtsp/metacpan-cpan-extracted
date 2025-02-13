# This file was automatically generated by SWIG (http://www.swig.org).
# Version 4.0.1
#
# Do not make changes to this file unless you know what you are doing--modify
# the SWIG interface file instead.

package Math::GSL::Sum;
use base qw(Exporter);
use base qw(DynaLoader);
package Math::GSL::Sumc;
bootstrap Math::GSL::Sum;
package Math::GSL::Sum;
@EXPORT = qw();

# ---------- BASE METHODS -------------

package Math::GSL::Sum;

sub TIEHASH {
    my ($classname,$obj) = @_;
    return bless $obj, $classname;
}

sub CLEAR { }

sub FIRSTKEY { }

sub NEXTKEY { }

sub FETCH {
    my ($self,$field) = @_;
    my $member_func = "swig_${field}_get";
    $self->$member_func();
}

sub STORE {
    my ($self,$field,$newval) = @_;
    my $member_func = "swig_${field}_set";
    $self->$member_func($newval);
}

sub this {
    my $ptr = shift;
    return tied(%$ptr);
}


# ------- FUNCTION WRAPPERS --------

package Math::GSL::Sum;

*gsl_error = *Math::GSL::Sumc::gsl_error;
*gsl_stream_printf = *Math::GSL::Sumc::gsl_stream_printf;
*gsl_strerror = *Math::GSL::Sumc::gsl_strerror;
*gsl_set_error_handler = *Math::GSL::Sumc::gsl_set_error_handler;
*gsl_set_error_handler_off = *Math::GSL::Sumc::gsl_set_error_handler_off;
*gsl_set_stream_handler = *Math::GSL::Sumc::gsl_set_stream_handler;
*gsl_set_stream = *Math::GSL::Sumc::gsl_set_stream;
*gsl_sum_levin_u_alloc = *Math::GSL::Sumc::gsl_sum_levin_u_alloc;
*gsl_sum_levin_u_free = *Math::GSL::Sumc::gsl_sum_levin_u_free;
*gsl_sum_levin_u_accel = *Math::GSL::Sumc::gsl_sum_levin_u_accel;
*gsl_sum_levin_u_minmax = *Math::GSL::Sumc::gsl_sum_levin_u_minmax;
*gsl_sum_levin_u_step = *Math::GSL::Sumc::gsl_sum_levin_u_step;
*gsl_sum_levin_utrunc_alloc = *Math::GSL::Sumc::gsl_sum_levin_utrunc_alloc;
*gsl_sum_levin_utrunc_free = *Math::GSL::Sumc::gsl_sum_levin_utrunc_free;
*gsl_sum_levin_utrunc_accel = *Math::GSL::Sumc::gsl_sum_levin_utrunc_accel;
*gsl_sum_levin_utrunc_minmax = *Math::GSL::Sumc::gsl_sum_levin_utrunc_minmax;
*gsl_sum_levin_utrunc_step = *Math::GSL::Sumc::gsl_sum_levin_utrunc_step;

############# Class : Math::GSL::Sum::gsl_sum_levin_u_workspace ##############

package Math::GSL::Sum::gsl_sum_levin_u_workspace;
use vars qw(@ISA %OWNER %ITERATORS %BLESSEDMEMBERS);
@ISA = qw( Math::GSL::Sum );
%OWNER = ();
%ITERATORS = ();
*swig_size_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_size_get;
*swig_size_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_size_set;
*swig_i_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_i_get;
*swig_i_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_i_set;
*swig_terms_used_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_terms_used_get;
*swig_terms_used_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_terms_used_set;
*swig_sum_plain_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_sum_plain_get;
*swig_sum_plain_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_sum_plain_set;
*swig_q_num_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_q_num_get;
*swig_q_num_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_q_num_set;
*swig_q_den_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_q_den_get;
*swig_q_den_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_q_den_set;
*swig_dq_num_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_dq_num_get;
*swig_dq_num_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_dq_num_set;
*swig_dq_den_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_dq_den_get;
*swig_dq_den_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_dq_den_set;
*swig_dsum_get = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_dsum_get;
*swig_dsum_set = *Math::GSL::Sumc::gsl_sum_levin_u_workspace_dsum_set;
sub new {
    my $pkg = shift;
    my $self = Math::GSL::Sumc::new_gsl_sum_levin_u_workspace(@_);
    bless $self, $pkg if defined($self);
}

sub DESTROY {
    return unless $_[0]->isa('HASH');
    my $self = tied(%{$_[0]});
    return unless defined $self;
    delete $ITERATORS{$self};
    if (exists $OWNER{$self}) {
        Math::GSL::Sumc::delete_gsl_sum_levin_u_workspace($self);
        delete $OWNER{$self};
    }
}

sub DISOWN {
    my $self = shift;
    my $ptr = tied(%$self);
    delete $OWNER{$ptr};
}

sub ACQUIRE {
    my $self = shift;
    my $ptr = tied(%$self);
    $OWNER{$ptr} = 1;
}


############# Class : Math::GSL::Sum::gsl_sum_levin_utrunc_workspace ##############

package Math::GSL::Sum::gsl_sum_levin_utrunc_workspace;
use vars qw(@ISA %OWNER %ITERATORS %BLESSEDMEMBERS);
@ISA = qw( Math::GSL::Sum );
%OWNER = ();
%ITERATORS = ();
*swig_size_get = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_size_get;
*swig_size_set = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_size_set;
*swig_i_get = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_i_get;
*swig_i_set = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_i_set;
*swig_terms_used_get = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_terms_used_get;
*swig_terms_used_set = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_terms_used_set;
*swig_sum_plain_get = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_sum_plain_get;
*swig_sum_plain_set = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_sum_plain_set;
*swig_q_num_get = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_q_num_get;
*swig_q_num_set = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_q_num_set;
*swig_q_den_get = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_q_den_get;
*swig_q_den_set = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_q_den_set;
*swig_dsum_get = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_dsum_get;
*swig_dsum_set = *Math::GSL::Sumc::gsl_sum_levin_utrunc_workspace_dsum_set;
sub new {
    my $pkg = shift;
    my $self = Math::GSL::Sumc::new_gsl_sum_levin_utrunc_workspace(@_);
    bless $self, $pkg if defined($self);
}

sub DESTROY {
    return unless $_[0]->isa('HASH');
    my $self = tied(%{$_[0]});
    return unless defined $self;
    delete $ITERATORS{$self};
    if (exists $OWNER{$self}) {
        Math::GSL::Sumc::delete_gsl_sum_levin_utrunc_workspace($self);
        delete $OWNER{$self};
    }
}

sub DISOWN {
    my $self = shift;
    my $ptr = tied(%$self);
    delete $OWNER{$ptr};
}

sub ACQUIRE {
    my $self = shift;
    my $ptr = tied(%$self);
    $OWNER{$ptr} = 1;
}


# ------- VARIABLE STUBS --------

package Math::GSL::Sum;

*GSL_VERSION = *Math::GSL::Sumc::GSL_VERSION;
*GSL_MAJOR_VERSION = *Math::GSL::Sumc::GSL_MAJOR_VERSION;
*GSL_MINOR_VERSION = *Math::GSL::Sumc::GSL_MINOR_VERSION;
*GSL_POSZERO = *Math::GSL::Sumc::GSL_POSZERO;
*GSL_NEGZERO = *Math::GSL::Sumc::GSL_NEGZERO;
*GSL_SUCCESS = *Math::GSL::Sumc::GSL_SUCCESS;
*GSL_FAILURE = *Math::GSL::Sumc::GSL_FAILURE;
*GSL_CONTINUE = *Math::GSL::Sumc::GSL_CONTINUE;
*GSL_EDOM = *Math::GSL::Sumc::GSL_EDOM;
*GSL_ERANGE = *Math::GSL::Sumc::GSL_ERANGE;
*GSL_EFAULT = *Math::GSL::Sumc::GSL_EFAULT;
*GSL_EINVAL = *Math::GSL::Sumc::GSL_EINVAL;
*GSL_EFAILED = *Math::GSL::Sumc::GSL_EFAILED;
*GSL_EFACTOR = *Math::GSL::Sumc::GSL_EFACTOR;
*GSL_ESANITY = *Math::GSL::Sumc::GSL_ESANITY;
*GSL_ENOMEM = *Math::GSL::Sumc::GSL_ENOMEM;
*GSL_EBADFUNC = *Math::GSL::Sumc::GSL_EBADFUNC;
*GSL_ERUNAWAY = *Math::GSL::Sumc::GSL_ERUNAWAY;
*GSL_EMAXITER = *Math::GSL::Sumc::GSL_EMAXITER;
*GSL_EZERODIV = *Math::GSL::Sumc::GSL_EZERODIV;
*GSL_EBADTOL = *Math::GSL::Sumc::GSL_EBADTOL;
*GSL_ETOL = *Math::GSL::Sumc::GSL_ETOL;
*GSL_EUNDRFLW = *Math::GSL::Sumc::GSL_EUNDRFLW;
*GSL_EOVRFLW = *Math::GSL::Sumc::GSL_EOVRFLW;
*GSL_ELOSS = *Math::GSL::Sumc::GSL_ELOSS;
*GSL_EROUND = *Math::GSL::Sumc::GSL_EROUND;
*GSL_EBADLEN = *Math::GSL::Sumc::GSL_EBADLEN;
*GSL_ENOTSQR = *Math::GSL::Sumc::GSL_ENOTSQR;
*GSL_ESING = *Math::GSL::Sumc::GSL_ESING;
*GSL_EDIVERGE = *Math::GSL::Sumc::GSL_EDIVERGE;
*GSL_EUNSUP = *Math::GSL::Sumc::GSL_EUNSUP;
*GSL_EUNIMPL = *Math::GSL::Sumc::GSL_EUNIMPL;
*GSL_ECACHE = *Math::GSL::Sumc::GSL_ECACHE;
*GSL_ETABLE = *Math::GSL::Sumc::GSL_ETABLE;
*GSL_ENOPROG = *Math::GSL::Sumc::GSL_ENOPROG;
*GSL_ENOPROGJ = *Math::GSL::Sumc::GSL_ENOPROGJ;
*GSL_ETOLF = *Math::GSL::Sumc::GSL_ETOLF;
*GSL_ETOLX = *Math::GSL::Sumc::GSL_ETOLX;
*GSL_ETOLG = *Math::GSL::Sumc::GSL_ETOLG;
*GSL_EOF = *Math::GSL::Sumc::GSL_EOF;

@EXPORT_OK = qw/
               gsl_sum_levin_u_alloc
               gsl_sum_levin_u_free
               gsl_sum_levin_u_accel
               gsl_sum_levin_u_minmax
               gsl_sum_levin_u_step
               gsl_sum_levin_utrunc_alloc
               gsl_sum_levin_utrunc_free
               gsl_sum_levin_utrunc_accel
               gsl_sum_levin_utrunc_minmax
               gsl_sum_levin_utrunc_step
             /;
%EXPORT_TAGS = ( all => \@EXPORT_OK );

__END__

=encoding utf8

=head1 NAME

Math::GSL::Sum - Sum series with the Levin u-transform

=head1 SYNOPSIS

    use Math::GSL::Sum qw/:all/;

    my $w = gsl_sum_levin_u_alloc(5);
    $values = [8,2,3,4,6];
    my ($status, $sum_accel, $abserr) = gsl_sum_levin_u_accel($values, 5, $w);
    gsl_sum_levin_u_free($w);

    my $w2 = gsl_sum_levin_utrunc_alloc(5);
    my ($status2, $sum_accel2, $abserr_trunc) = gsl_sum_levin_utrunc_accel($values, 5, $w2);
    gsl_sum_levin_utrunc_free($w);

=head1 DESCRIPTION

These functions accelerate the convergence of a series using the Levin u-transform.

=over

=item * gsl_sum_levin_u_alloc($n)

This function allocates a workspace for a Levin u-transform of $n terms.

=item * gsl_sum_levin_u_free($w)

- This function frees the memory associated with the workspace $w.

=item * gsl_sum_levin_u_accel($array, $array_size, $w)

This function takes the terms of a series in the array reference $array of size
$array_size and computes the extrapolated limit of the series using a Levin
u-transform. Additional working space must be provided in $w. The function
returns multiple values in this order : 0 if the operation succeeded, 1
otherwise, the extrapolated sum and an estimate of the absolute error. The
actual term-by-term sum is returned in $w->{sum_plain}. The algorithm
calculates the truncation error (the difference between two successive
extrapolations) and round-off error (propagated from the individual terms) to
choose an optimal number of terms for the extrapolation. All the terms of the
series passed in through array should be non-zero.

=item * gsl_sum_levin_u_minmax

=item * gsl_sum_levin_u_step

=item * gsl_sum_levin_utrunc_alloc($n)

This function allocates a workspace for a Levin u-transform of $n terms,
without error estimation.

=item * gsl_sum_levin_utrunc_free($w)

This function frees the memory associated with the workspace $w.

=item * gsl_sum_levin_utrunc_accel($array, $array_size, $w)

This function takes the terms of a series in the array reference $array of size
$array_size and computes the extrapolated limit of the series using a Levin
u-transform. Additional working space must be provided in $w. The function
returns multiple values in this order : 0 if the operation succeeded, 1
otherwise, the extrapolated sum and an estimate of the error. The actual
term-by-term sum is returned in $w->{sum_plain}. The algorithm terminates when
the difference between two successive extrapolations reaches a minimum or is
sufficiently small. To improve the reliability of the algorithm the
extrapolated values are replaced by moving averages when calculating the
truncation error, smoothing out any fluctuations.

=item * gsl_sum_levin_utrunc_minmax

=item * gsl_sum_levin_utrunc_step

=back

=head1 AUTHORS

Jonathan "Duke" Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008-2021 Jonathan "Duke" Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
