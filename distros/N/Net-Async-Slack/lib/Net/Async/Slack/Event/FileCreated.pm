package Net::Async::Slack::Event::FileCreated;

use strict;
use warnings;

our $VERSION = '0.011'; # VERSION

use Net::Async::Slack::EventType;

=head1 NAME

Net::Async::Slack::Event::FileCreated - A file was created

=head1 DESCRIPTION

Example input data:

    files:read

=cut

sub type { 'file_created' }

1;

__END__

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2016-2022. Licensed under the same terms as Perl itself.
