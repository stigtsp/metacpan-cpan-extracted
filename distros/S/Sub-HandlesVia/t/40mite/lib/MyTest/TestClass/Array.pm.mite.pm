{
package MyTest::TestClass::Array;
use strict;
use warnings;

our $USES_MITE = "Mite::Class";
our $MITE_SHIM = "MyTest::Mite";
our $MITE_VERSION = "0.009000";

# Standard Moose/Moo-style constructor
sub new {
    my $class = ref($_[0]) ? ref(shift) : shift;
    my $meta  = ( $Mite::META{$class} ||= $class->__META__ );
    my $self  = bless {}, $class;
    my $args  = $meta->{HAS_BUILDARGS} ? $class->BUILDARGS( @_ ) : { ( @_ == 1 ) ? %{$_[0]} : @_ };
    my $no_build = delete $args->{__no_BUILD__};

    # Attribute attr (type: ArrayRef)
    # has declaration, file lib/MyTest/TestClass/Array.pm, line 41
    do { my $value = exists( $args->{"attr"} ) ? $args->{"attr"} : []; (ref($value) eq 'ARRAY') or MyTest::Mite::croak "Type check failed in constructor: %s should be %s", "attr", "ArrayRef"; $self->{"attr"} = $value; }; 


    # Call BUILD methods
    $self->BUILDALL( $args ) if ( ! $no_build and @{ $meta->{BUILD} || [] } );

    # Unrecognized parameters
    my @unknown = grep not( /\Aattr\z/ ), keys %{$args}; @unknown and MyTest::Mite::croak( "Unexpected keys in constructor: " . join( q[, ], sort @unknown ) );

    return $self;
}

# Used by constructor to call BUILD methods
sub BUILDALL {
    my $class = ref( $_[0] );
    my $meta  = ( $Mite::META{$class} ||= $class->__META__ );
    $_->( @_ ) for @{ $meta->{BUILD} || [] };
}

# Destructor should call DEMOLISH methods
sub DESTROY {
    my $self  = shift;
    my $class = ref( $self ) || $self;
    my $meta  = ( $Mite::META{$class} ||= $class->__META__ );
    my $in_global_destruction = defined ${^GLOBAL_PHASE}
        ? ${^GLOBAL_PHASE} eq 'DESTRUCT'
        : Devel::GlobalDestruction::in_global_destruction();
    for my $demolisher ( @{ $meta->{DEMOLISH} || [] } ) {
        my $e = do {
            local ( $?, $@ );
            eval { $demolisher->( $self, $in_global_destruction ) };
            $@;
        };
        no warnings 'misc'; # avoid (in cleanup) warnings
        die $e if $e;       # rethrow
    }
    return;
}

# Gather metadata for constructor and destructor
sub __META__ {
    no strict 'refs';
    no warnings 'once';
    my $class      = shift; $class = ref($class) || $class;
    my $linear_isa = mro::get_linear_isa( $class );
    return {
        BUILD => [
            map { ( *{$_}{CODE} ) ? ( *{$_}{CODE} ) : () }
            map { "$_\::BUILD" } reverse @$linear_isa
        ],
        DEMOLISH => [
            map { ( *{$_}{CODE} ) ? ( *{$_}{CODE} ) : () }
            map { "$_\::DEMOLISH" } @$linear_isa
        ],
        HAS_BUILDARGS => $class->can('BUILDARGS'),
        HAS_FOREIGNBUILDARGS => $class->can('FOREIGNBUILDARGS'),
    };
}

# See UNIVERSAL
sub DOES {
    my ( $self, $role ) = @_;
    our %DOES;
    return $DOES{$role} if exists $DOES{$role};
    return 1 if $role eq __PACKAGE__;
    return $self->SUPER::DOES( $role );
}

# Alias for Moose/Moo-compatibility
sub does {
    shift->DOES( @_ );
}

my $__XS = !$ENV{MITE_PURE_PERL} && eval { require Class::XSAccessor; Class::XSAccessor->VERSION("1.19") };

# Accessors for attr
# has declaration, file lib/MyTest/TestClass/Array.pm, line 41
if ( $__XS ) {
    Class::XSAccessor->import(
        chained => 1,
        "getters" => { "attr" => "attr" },
    );
}
else {
    *attr = sub { @_ == 1 or MyTest::Mite::croak( 'Reader "attr" usage: $self->attr()' ); $_[0]{"attr"} };
}
sub _set_attr { @_ == 2 or MyTest::Mite::croak( 'Writer "_set_attr" usage: $self->_set_attr( $newvalue )' ); (ref($_[1]) eq 'ARRAY') or MyTest::Mite::croak( "Type check failed in %s: value should be %s", "writer", "ArrayRef" ); $_[0]{"attr"} = $_[1]; $_[0]; }


1;
}