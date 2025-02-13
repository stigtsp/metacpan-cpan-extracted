package Lab::Connection::Socket::Trace;
#ABSTRACT: ???
$Lab::Connection::Socket::Trace::VERSION = '3.821';
use v5.20;

use warnings;
use strict;

use parent 'Lab::Connection::Socket';

use Role::Tiny::With;
use Carp;
use autodie;

our %fields = (
    logfile   => undef,
    log_index => 0,
);

with 'Lab::Connection::Trace';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Lab::Connection::Socket::Trace - ???

=head1 VERSION

version 3.821

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by the Lab::Measurement team; in detail:

  Copyright 2016       Charles Lane
            2017       Andreas K. Huettel
            2020       Andreas K. Huettel


This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
