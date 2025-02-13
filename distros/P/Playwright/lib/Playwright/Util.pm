package Playwright::Util;
$Playwright::Util::VERSION = '1.210';
use strict;
use warnings;

use v5.28;

use JSON::MaybeXS();
use Carp qw{confess};
use Sereal::Encoder;
use Sereal::Decoder;
use File::Temp;
use POSIX();

#ABSTRACT: Common utility functions for the Playwright module

no warnings 'experimental';
use feature qw{signatures};

sub request ( $method, $url, $port, $ua, %args ) {
    my $fullurl = "http://localhost:$port/$url";

    # Handle passing Playwright elements as arguments
    if ( ref $args{args} eq 'ARRAY' ) {
        @{ $args{args} } = map {
            my $transformed = $_;
            if ( ref($_) eq 'Playwright::ElementHandle' ) {
                $transformed = { uuid => $_->{guid} };
            }
            $transformed;
        } @{ $args{args} };
    }

    my $request = HTTP::Request->new( $method, $fullurl );
    $request->header( 'Content-type' => 'application/json' );
    $request->content( JSON::MaybeXS::encode_json( \%args ) );
    my $response = $ua->request($request);
    my $content  = $response->decoded_content();
    my $decoded  = JSON::MaybeXS::decode_json($content);
    my $msg      = $decoded->{message};

    confess($msg) if $decoded->{error};

    return $msg;
}

sub arr2hash ( $array, $primary_key, $callback = '' ) {
    my $inside_out = {};
    @$inside_out{
        map {
            $callback ? $callback->( $_->{$primary_key} ) : $_->{$primary_key}
        } @$array
    } = @$array;
    return $inside_out;
}

# Serialize a subprocess because NOTHING ON CPAN DOES THIS GRRRRR
sub async ($subroutine) {

    # The fork would result in the tmpdir getting whacked when it terminates.
    my ( undef, $filename ) = File::Temp::tempfile();
    my $pid = fork() // die "Could not fork";
    _child( $filename, $subroutine ) unless $pid;
    return { pid => $pid, file => $filename };
}

sub _child ( $filename, $subroutine ) {
    Sereal::Encoder->encode_to_file( $filename, $subroutine->() );

    # Prevent destructors from firing due to exiting instantly
    POSIX::_exit(0);
}

sub await ($to_wait) {
    waitpid( $to_wait->{pid}, 0 );
    confess("Timed out while waiting for event.")
      unless -f $to_wait->{file} && -s _;
    return Sereal::Decoder->decode_from_file( $to_wait->{file} );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Playwright::Util - Common utility functions for the Playwright module

=head1 VERSION

version 1.210

=head2 request(STRING method, STRING url, INTEGER port, LWP::UserAgent ua, HASH args) = HASH

De-duplicates request logic in the Playwright Modules.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Playwright|Playwright>

=back

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/teodesian/playwright-perl/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHORS

Current Maintainers:

=over 4

=item *

George S. Baugh <teodesian@gmail.com>

=back

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2020 Troglodyne LLC


Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=cut
