#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2018-2022 -- leonerd@leonerd.org.uk

use v5.26;
use Object::Pad 0.57;

package Device::Chip::MCP3221 0.13;
class Device::Chip::MCP3221
   :isa(Device::Chip);

use Future::AsyncAwait;

use constant PROTOCOL => "I2C";

=encoding UTF-8

=head1 NAME

C<Device::Chip::MCP3221> - chip driver for F<MCP3221>

=head1 SYNOPSIS

   use Device::Chip::MCP3221;
   use Future::AsyncAwait;

   my $chip = Device::Chip::MCP3221->new;
   await $chip->mount( Device::Chip::Adapter::...->new );

   printf "The reading is %d\n", await $chip->read_adc;

=head1 DESCRIPTION

This L<Device::Chip> subclass provides specific communications to a
F<Microchip> F<MCP3221> chip.

The reader is presumed to be familiar with the general operation of this chip;
the documentation here will not attempt to explain or define chip-specific
concepts or features, only the use of this module to access them.

=cut

=head1 MOUNT PARAMETERS

=head2 addr

The I²C address of the device. Can be specified in decimal, octal or hex with
leading C<0> or C<0x> prefixes.

=cut

sub I2C_options ( $, %params )
{
   my $addr = delete $params{addr} // 0x4D;
   $addr = oct $addr if $addr =~ m/^0/;

   return (
      addr        => $addr,
      max_bitrate => 400E3,
   );
}

=head1 METHODS

The following methods documented in an C<await> expression return L<Future>
instances.

=cut

# Chip has no config registers
async method read_config () { return {} }
async method change_config (%) { }

=head2 read_adc

   $value = await $chip->read_adc;

Performs a conversion and returns the result as a plain unsigned 12-bit
integer.

=cut

async method read_adc ()
{
   my $buf = await $self->protocol->read( 2 );

   return unpack "S>", $buf;
}

=head2 read_adc_ratio

   $ratio = await $chip->read_adc_ratio;

Performs a conversion and returns the result as a floating-point number
between 0 and 1.

=cut

async method read_adc_ratio ()
{
   # MCP3221 is 12-bit
   return ( await $self->read_adc ) / 2**12;
}

=head1 AUTHOR

Paul Evans <leonerd@leonerd.org.uk>

=cut

0x55AA;
