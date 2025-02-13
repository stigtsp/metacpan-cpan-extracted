#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2018 -- leonerd@leonerd.org.uk

package Commandable 0.08;

use v5.14;
use warnings;

=head1 NAME

C<Commandable> - utilities for commandline-based programs

=head1 DESCRIPTION

This distribution contains a collection of utilities extracted from various
commandline-based programs I have written, in the hope of trying to find a
standard base to build these from in future.

Note that "commandline" does not necessarily mean "plain-text running in a
terminal"; simply that the mode of operation is that the user types a textual
representation of some action, and the program parses this text in order to
perform it. This could equally apply to a command input text area in a GUI
program.

=cut

=head1 AUTHOR

Paul Evans <leonerd@leonerd.org.uk>

=cut

0x55AA;
