package Cassandra::Client::Policy::Retry::Default;
our $AUTHORITY = 'cpan:TVDW';
$Cassandra::Client::Policy::Retry::Default::VERSION = '0.19';
use 5.010;
use strict;
use warnings;

use Cassandra::Client::Policy::Retry qw/
    try_next_host
    retry
    rethrow
/;

sub new {
    my ($class, %args)= @_;
    my $max_retries;
    foreach(qw/max_retries_read_timeout max_retries_unavailable max_retries_write_timeout max_retries_request_error/) {
        $max_retries->{$_} = exists $args{$_} ? 0+ delete $args{$_} : 1;
    }

    if (%args) {
        die 'Unknown arguments '. (join ', ', keys %args);
    }
    return bless {
        max_retries => $max_retries,
    }, $class;
}

sub on_read_timeout {
    my ($self, $statement, $consistency_level, $required_responses, $received_responses, $data_retrieved, $nr_retries)= @_;

    return rethrow if $nr_retries >= $self->{max_retries}{max_retries_read_timeout};
    return retry if $received_responses < $required_responses;
    return retry if $received_responses >= $required_responses and !$data_retrieved;
    return rethrow;
}

sub on_unavailable {
    my ($self, $statement, $consistency_level, $required_replicas, $alive_replicas, $nr_retries)= @_;

    return rethrow if $nr_retries >= $self->{max_retries}{max_retries_unavailable};
    return try_next_host;
}

sub on_write_timeout {
    my ($self, $statement, $consistency_level, $write_type, $required_acks, $received_acks, $nr_retries)= @_;

    return rethrow if $nr_retries >= $self->{max_retries}{max_retries_write_timeout};
    return retry if $write_type eq 'BATCH_LOG' or $statement->{idempotent};
    return rethrow;
}

sub on_request_error {
    my ($self, $statement, $consistency_level, $error, $nr_retries)= @_;

    return rethrow if $nr_retries >= $self->{max_retries}{max_retries_request_error};
    return try_next_host;
}

1;

__END__

=pod

=head1 NAME

Cassandra::Client::Policy::Retry::Default

=head1 VERSION

version 0.19

=head1 AUTHOR

Tom van der Woerdt <tvdw@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by Tom van der Woerdt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
