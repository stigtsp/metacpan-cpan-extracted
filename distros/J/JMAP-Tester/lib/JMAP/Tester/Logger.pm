package JMAP::Tester::Logger 0.102;

use Moo::Role;

use JMAP::Tester::LogWriter;
use Params::Util qw(_CODELIKE _HANDLE _SCALAR0);

use namespace::clean;

has writer => (
  is  => 'ro',
  isa => sub {
    die "no writer provided" unless $_[0];
    die "writer provided can't be called as code" unless $_[0]->does('JMAP::Tester::LogWriter');
  },
  coerce   => sub {
    my $value = $_[0];
    return JMAP::Tester::LogWriter::Code->new({ code => $value })
      if _CODELIKE($value);

    return JMAP::Tester::LogWriter::Handle->new({ handle => $value })
      if _HANDLE($value);

    return JMAP::Tester::LogWriter::Code->new({ code => sub{} })
      if _SCALAR0($value) && ! defined $$value;

    if (defined $value && ! ref $value && length $value) {
      if ($value =~ /\A-([1-9][0-9]*)\z/) {
        open my $handle, '>&', "$1"
          or die "can't dup fd $1 for logger output: $!";
        $handle->autoflush(1);
        return JMAP::Tester::LogWriter::Handle->new({ handle => $handle });
      }

      return JMAP::Tester::LogWriter::Filename->new({
        filename_template => $value
      });
    }

    return $value;
  },
  required => 1,
);

sub write {
  my ($self, $string) = @_;
  $self->writer->write( $string );
}

requires 'log_jmap_request';
requires 'log_jmap_response';

requires 'log_upload_request';
requires 'log_upload_response';

requires 'log_download_request';
requires 'log_download_response';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

JMAP::Tester::Logger

=head1 VERSION

version 0.102

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by FastMail, Ltd.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
