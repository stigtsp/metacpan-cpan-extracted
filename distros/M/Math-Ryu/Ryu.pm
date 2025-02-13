## This file generated by InlineX::C2XS (version 0.26) using Inline::C (version 0.79_001)
package Math::Ryu;
use warnings;
use strict;

require Exporter;
*import = \&Exporter::import;
require DynaLoader;

our $VERSION = '0.03';
#$VERSION = eval $VERSION;
DynaLoader::bootstrap Math::Ryu $VERSION;

@Math::Ryu::EXPORT = ();
@Math::Ryu::EXPORT_OK = qw(
    d2s s2d
    d2s_buffered_n d2s_buffered d2fixed_buffered_n d2fixed_buffered
    d2fixed d2fixed d2exp_buffered_n d2exp_buffered d2exp
    );

%Math::Ryu::EXPORT_TAGS = (all => [qw(
    d2s s2d
    d2s_buffered_n d2s_buffered d2fixed_buffered_n d2fixed_buffered
    d2fixed d2fixed d2exp_buffered_n d2exp_buffered d2exp
    )]);

sub dl_load_flags {0} # Prevent DynaLoader from complaining and croaking

1;
