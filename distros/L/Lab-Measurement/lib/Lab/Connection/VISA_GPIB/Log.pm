package Lab::Connection::VISA_GPIB::Log;
#ABSTRACT: Add logging capability to a VISA_GPIB connection
$Lab::Connection::VISA_GPIB::Log::VERSION = '3.821';
use v5.20;

use warnings;
use strict;

use parent 'Lab::Connection::VISA_GPIB';

use Role::Tiny::With;
use Carp;
use autodie;

our %fields = (
    logfile   => undef,
    log_index => 0,
);

with 'Lab::Connection::Log';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Lab::Connection::VISA_GPIB::Log - Add logging capability to a VISA_GPIB connection

=head1 VERSION

version 3.821

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by the Lab::Measurement team; in detail:

  Copyright 2016       Simon Reinhardt
            2017       Andreas K. Huettel
            2020       Andreas K. Huettel


This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
