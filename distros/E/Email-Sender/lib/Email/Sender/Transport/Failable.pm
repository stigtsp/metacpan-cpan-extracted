package Email::Sender::Transport::Failable 2.500;
# ABSTRACT: a wrapper to makes things fail predictably

use Moo;
extends 'Email::Sender::Transport::Wrapper';

use MooX::Types::MooseLike::Base qw(ArrayRef);

#pod =head1 DESCRIPTION
#pod
#pod This transport extends L<Email::Sender::Transport::Wrapper>, meaning that it
#pod must be created with a C<transport> attribute of another
#pod Email::Sender::Transport.  It will proxy all email sending to that transport,
#pod but only after first deciding if it should fail.
#pod
#pod It does this by calling each coderef in its C<failure_conditions> attribute,
#pod which must be an arrayref of code references.  Each coderef will be called and
#pod will be passed the Failable transport, the Email::Abstract object, the
#pod envelope, and a reference to an array containing the rest of the arguments to
#pod C<send>.
#pod
#pod If any coderef returns a true value, the value will be used to signal failure.
#pod
#pod =cut

has 'failure_conditions' => (
  isa => ArrayRef,
  default => sub { [] },
  is      => 'ro',
  reader  => '_failure_conditions',
);

sub failure_conditions { @{$_[0]->_failure_conditions} }
sub fail_if { push @{shift->_failure_conditions}, @_ }
sub clear_failure_conditions { @{$_[0]->{failure_conditions}} = () }

around send_email => sub {
  my ($orig, $self, $email, $env, @rest) = @_;

  for my $cond ($self->failure_conditions) {
    my $reason = $cond->($self, $email, $env, \@rest);
    next unless $reason;
    die (ref $reason ? $reason : Email::Sender::Failure->new($reason));
  }

  return $self->$orig($email, $env, @rest);
};

no Moo;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Email::Sender::Transport::Failable - a wrapper to makes things fail predictably

=head1 VERSION

version 2.500

=head1 DESCRIPTION

This transport extends L<Email::Sender::Transport::Wrapper>, meaning that it
must be created with a C<transport> attribute of another
Email::Sender::Transport.  It will proxy all email sending to that transport,
but only after first deciding if it should fail.

It does this by calling each coderef in its C<failure_conditions> attribute,
which must be an arrayref of code references.  Each coderef will be called and
will be passed the Failable transport, the Email::Abstract object, the
envelope, and a reference to an array containing the rest of the arguments to
C<send>.

If any coderef returns a true value, the value will be used to signal failure.

=head1 PERL VERSION

This library should run on perls released even a long time ago.  It should work
on any version of perl released in the last five years.

Although it may work on older versions of perl, no guarantee is made that the
minimum required version will not be increased.  The version may be increased
for any reason, and there is no promise that patches will be accepted to lower
the minimum required perl.

=head1 AUTHOR

Ricardo Signes <rjbs@semiotic.systems>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Ricardo Signes.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
