use strict;
use warnings;
package Software::License::None;
$Software::License::None::VERSION = '0.104002';
use parent 'Software::License';
# ABSTRACT: describes a "license" that gives no license for re-use

sub name      { q("No License" License) }
sub url       { undef }

sub meta_name  { 'restrictive' }
sub meta2_name { 'restricted'  }

1;

=pod

=encoding UTF-8

=head1 NAME

Software::License::None - describes a "license" that gives no license for re-use

=head1 VERSION

version 0.104002

=head1 PERL VERSION

This module is part of CPAN toolchain, or is treated as such.  As such, it
follows the agreement of the Perl Toolchain Gang to require no newer version of
perl than v5.8.1.  This version may change by agreement of the Toolchain Gang,
but for now is governed by the L<Lancaster
Consensus|https://github.com/Perl-Toolchain-Gang/toolchain-site/blob/master/lancaster-consensus.md>
of 2013.

=head1 AUTHOR

Ricardo Signes <rjbs@semiotic.systems>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by Ricardo Signes.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__DATA__
__NOTICE__
This software is copyright (c) {{$self->year}} by {{$self->_dotless_holder}}.  No
license is granted to other entities.
__LICENSE__
All rights reserved.
