package Venus::Process;

use 5.018;

use strict;
use warnings;

use overload (
  '""' => 'explain',
  '~~' => 'explain',
  fallback => 1,
);

use Venus::Class;

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';

require Config;
require Cwd;
require File::Spec;
require POSIX;

state $GETCWD = Cwd->getcwd;
state $MAPSIG = {%SIG};

# HOOKS

sub _chdir {
  CORE::chdir(shift);
}

sub _exit {
  POSIX::_exit(shift);
}

sub _exitcode {
  $?;
}

sub _fork {
  CORE::fork();
}

sub _forkable {
  $Config::Config{d_pseudofork} ? 0 : 1;
}

sub _kill {
  CORE::kill(@_);
}

sub _open {
  CORE::open(shift, shift, shift);
}

sub _pid {
  $$;
}

sub _setsid {
  POSIX::setsid();
}

sub _waitpid {
  CORE::waitpid(shift, shift);
}

# METHODS

sub chdir {
  my ($self, $path) = @_;

  $path ||= $GETCWD;

  _chdir($path) or do {
    my $throw;
    my $error = "Can't chdir $path: $!";
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->stash(pid => _pid());
    $throw->error;
  };

  return $self;
}

sub check {
  my ($self, $pid) = @_;

  my $result = _waitpid($pid, POSIX::WNOHANG());

  return wantarray ? ($result, _exitcode) : $result;
}

sub daemon {
  my ($self) = @_;

  if (my $process = $self->fork) {
    return $process->disengage->do('setsid');
  }
  else {
    return $self->exit;
  }
}

sub default {
  return _pid();
}

sub disengage {
  my ($self) = @_;

  $self->chdir(File::Spec->rootdir);

  $self->$_(File::Spec->devnull) for qw(stdin stdout stderr);

  return $self;
}

sub engage {
  my ($self) = @_;

  $self->chdir;

  $self->$_ for qw(stdin stdout stderr);

  return $self;
}

sub exit {
  my ($self, $code) = @_;

  return _exit($code // 0);
}

sub explain {
  my ($self) = @_;

  return $self->get;
}

sub fork {
  my ($self, $code, @args) = @_;

  if (not(_forkable())) {
    my $throw;
    my $error = "Can't fork process @{[_pid()]}: Fork emulation not supported";
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(process => _pid());
    $throw->error;
  }
  if (defined(my $pid = _fork())) {
    my $process;

    if ($pid) {
      return wantarray ? (undef, $pid) : undef;
    }

    $process = $self->class->new;

    if ($code) {
      local $_ = $process;
      $process->$code(@args);
    }

    return wantarray ? ($process, _pid()) : $process;
  }
  else {
    my $throw;
    my $error = "Can't fork process @{[_pid()]}: $!";
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(process => _pid());
    $throw->error;
  }
}

sub forks {
  my ($self, $count, $code, @args) = @_;

  my $pid;
  my @pids;
  my $process;

  for (my $i = 1; $i <= ($count || 0); $i++) {
    ($process, $pid) = $self->fork($code, @args, $i);
    if (!$process) {
      push @pids, $pid;
    }
    if ($process) {
      last;
    }
  }

  return wantarray ? ($process ? ($process, []) : ($process, [@pids]) ) : $process;
}

sub kill {
  my ($self, $name, @pids) = @_;

  return _kill(uc($name), @pids);
}

sub setsid {
  my ($self) = @_;

  return _setsid != -1 || do {
    my $throw;
    my $error = "Can't start a new session: $!";
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(pid => _pid());
    $throw->error;
  };
}

sub stderr {
  my ($self, $path) = @_;

  state $STDERR;

  if (!$STDERR) {
    _open($STDERR, '>&', \*STDERR);
  }
  if (!$path) {
    _open(\*STDERR, '>&', $STDERR);
  }
  else {
    _open(\*STDERR, '>&', IO::File->new($path, 'w')) or do {
      my $throw;
      my $error = "Can't redirect STDERR to $path: $!";
      $throw = $self->throw;
      $throw->message($error);
      $throw->stash(path => $path);
      $throw->stash(pid => _pid());
      $throw->error;
    };
  }

  return $self;
}

sub stdin {
  my ($self, $path) = @_;

  state $STDIN;

  if (!$STDIN) {
    _open($STDIN, '<&', \*STDIN);
  }
  if (!$path) {
    _open(\*STDIN, '<&', $STDIN);
  }
  else {
    _open(\*STDIN, '<&', IO::File->new($path, 'r')) or do {
      my $throw;
      my $error = "Can't redirect STDIN to $path: $!";
      $throw = $self->throw;
      $throw->message($error);
      $throw->stash(path => $path);
      $throw->stash(pid => _pid());
      $throw->error;
    };
  }

  return $self;
}

sub stdout {
  my ($self, $path) = @_;

  state $STDOUT;

  if (!$STDOUT) {
    _open($STDOUT, '>&', \*STDOUT);
  }
  if (!$path) {
    _open(\*STDOUT, '>&', $STDOUT);
  }
  else {
    _open(\*STDOUT, '>&', IO::File->new($path, 'w')) or do {
      my $throw;
      my $error = "Can't redirect STDOUT to $path: $!";
      $throw = $self->throw;
      $throw->message($error);
      $throw->stash(path => $path);
      $throw->stash(pid => _pid());
      $throw->error;
    };
  }

  return $self;
}

sub trap {
  my ($self, $name, $expr) = @_;

  $SIG{uc($name)} = !ref($expr) ? uc($expr) : sub {
    local($!, $?);
    return $expr->(@_);
  };

  return $self;
}

sub wait {
  my ($self, $pid) = @_;

  my $result = _waitpid($pid, 0);

  return wantarray ? ($result, _exitcode) : $result;
}

sub work {
  my ($self, $code, @args) = @_;

  my @returned = $self->fork(sub{
    my ($process) = @_;
    local $_ = $process;
    $process->$code(@args);
    $process->exit;
  });

  return $returned[-1];
}

sub untrap {
  my ($self, $name) = @_;

  if ($name) {
    $SIG{uc($name)} = $$MAPSIG{uc($name)};
  }
  else {
    %SIG = %$MAPSIG;
  }

  return $self;
}

1;



=head1 NAME

Venus::Process - Process Class

=cut

=head1 ABSTRACT

Process Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $process = $parent->fork;

  if ($process) {
    # do something in child process ...
    $process->exit;
  }
  else {
    # do something in parent process ...
    $parent->wait(-1);
  }

  # $parent->exit;

=cut

=head1 DESCRIPTION

This package provides methods for handling and forking processes.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind::Utility>

=cut

=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Accessible>

L<Venus::Role::Buildable>

L<Venus::Role::Explainable>

L<Venus::Role::Valuable>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 chdir

  chdir(Str $path) (Process)

The chdir method changes the working directory the current process is operating
within.

I<Since C<0.06>>

=over 4

=item chdir example 1

  # given: synopsis;

  $parent = $parent->chdir;

  # bless({...}, 'Venus::Process')

=back

=over 4

=item chdir example 2

  # given: synopsis;

  $parent = $parent->chdir('/tmp');

  # bless({...}, 'Venus::Process')

=back

=over 4

=item chdir example 3

  # given: synopsis;

  $parent = $parent->chdir('/xyz');

  # Exception! Venus::Process::Error (isa Venus::Error)

=back

=cut

=head2 check

  check(Int $pid) (Int, Int)

The check method does a non-blocking L<perlfunc/waitpid> operation and returns
the wait status. In list context, returns the specified process' exit code (if
terminated).

I<Since C<0.06>>

=over 4

=item check example 1

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my $check = $parent->check($pid);

  # 0

=back

=over 4

=item check example 2

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my ($check, $status) = $parent->check('00000');

  # (-1, -1)

=back

=over 4

=item check example 3

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork(sub{ $_->exit(1) });

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my ($check, $status) = $parent->check($pid);

  # ($pid, 1)

=back

=cut

=head2 daemon

  daemon() (Process)

The daemon method detaches the process from controlling terminal and runs it in
the background as system daemon. This method internally calls L</disengage> and
L</setsid> and attempts to change the working directory to the root directory.

I<Since C<0.06>>

=over 4

=item daemon example 1

  # given: synopsis;

  my $daemon = $parent->daemon; # exits parent immediately

  # in forked process ...

  # $daemon->exit;

=back

=cut

=head2 disengage

  disengage() (Process)

The disengage method limits the interactivity of the process by changing the
working directory to the root directory and redirecting its standard file
descriptors from and to C</dev/null>, or the OS' equivalent. These state
changes can be undone by calling the L</engage> method.

I<Since C<0.06>>

=over 4

=item disengage example 1

  # given: synopsis;

  $parent = $parent->disengage;

  # bless({...}, 'Venus::Process')

=back

=cut

=head2 engage

  engage() (Process)

The engage method ensures the interactivity of the process by changing the
working directory to the directory used to launch the process, and by
redirecting/returning its standard file descriptors from and to their defaults.
This method effectively does the opposite of the L</disengage> method.

I<Since C<0.06>>

=over 4

=item engage example 1

  # given: synopsis;

  $parent = $parent->engage;

  # bless({...}, 'Venus::Process')

=back

=cut

=head2 exit

  exit(Int $status) (Int)

The exit method exits the program immediately.

I<Since C<0.06>>

=over 4

=item exit example 1

  # given: synopsis;

  my $exit = $parent->exit;

  # 0

=back

=over 4

=item exit example 2

  # given: synopsis;

  my $exit = $parent->exit(1);

  # 1

=back

=cut

=head2 fork

  fork(Str | CodeRef $code, Any @args) (Process, Int)

The fork method calls the system L<perlfunc/fork> function and creates a new
process running the same program at the same point (or call site). This method
returns a new L<Venus::Process> object representing the child process (from
within the execution of the child process (or fork)), and returns C<undef> to
the parent (or originating) process. In list context, this method returns both
the process and I<PID> (or process ID) of the child process. If a callback or
argument is provided it will be executed in the child process.

I<Since C<0.06>>

=over 4

=item fork example 1

  # given: synopsis;

  $process = $parent->fork;

  # if ($process) {
  #   # in forked process ...
  #   $process->exit;
  # }
  # else {
  #   # in parent process ...
  #   $parent->wait(-1);
  # }

  # in child process

  # bless({...}, 'Venus::Process')

=back

=over 4

=item fork example 2

  # given: synopsis;

  my $pid;

  ($process, $pid) = $parent->fork;

  # if ($process) {
  #   # in forked process ...
  #   $process->exit;
  # }
  # else {
  #   # in parent process ...
  #   $parent->wait($pid);
  # }

  # in parent process

  # (undef, $pid)

=back

=over 4

=item fork example 3

  # given: synopsis;

  my $pid;

  ($process, $pid) = $parent->fork(sub{
    $$_{started} = time;
  });

  # if ($process) {
  #   # in forked process ...
  #   $process->exit;
  # }
  # else {
  #   # in parent process ...
  #   $parent->wait($pid);
  # }

  # in parent process

  # (undef, $pid)

=back

=over 4

=item fork example 4

  # given: synopsis;

  $process = $parent->fork(sub{});

  # simulate fork failure

  # no forking attempted if NOT supported

  # Exception! Venus::Process:Error (isa Venus::Error)

=back

=cut

=head2 forks

  forks(Str | CodeRef $code, Any @args) (Process, ArrayRef[Int])

The forks method creates multiple forks by calling the L</fork> method C<n>
times, based on the count specified. As with the L</fork> method, this method
returns a new L<Venus::Process> object representing the child process (from
within the execution of the child process (or fork)), and returns C<undef> to
the parent (or originating) process. In list context, this method returns both
the process and an arrayref of I<PID> values (or process IDs) for each of the
child processes created. If a callback or argument is provided it will be
executed in each child process.

I<Since C<0.06>>

=over 4

=item forks example 1

  # given: synopsis;

  $process = $parent->forks(5);

  # if ($process) {
  #   # do something in (each) forked process ...
  #   $process->exit;
  # }
  # else {
  #   # do something in parent process ...
  #   $parent->wait(-1);
  # }

  # bless({...}, 'Venus::Process')

=back

=over 4

=item forks example 2

  # given: synopsis;

  my $pids;

  ($process, $pids) = $parent->forks(5);

  # if ($process) {
  #   # do something in (each) forked process ...
  #   $process->exit;
  # }
  # else {
  #   # do something in parent process ...
  #   $parent->wait($_) for @$pids;
  # }

  # in parent process

  # (undef, $pids)

=back

=over 4

=item forks example 3

  # given: synopsis;

  my $pids;

  ($process, $pids) = $parent->forks(5, sub{
    my ($fork, $pid, $iteration) = @_;
    # $iteration is the fork iteration index
    $fork->exit;
  });

  # if ($process) {
  #   # do something in (each) forked process ...
  #   $process->exit;
  # }
  # else {
  #   # do something in parent process ...
  #   $parent->wait($_) for @$pids;
  # }

  # in child process

  # bless({...}, 'Venus::Process')

=back

=cut

=head2 kill

  kill(Str $signal, Int @pids) (Int)

The kill method calls the system L<perlfunc/kill> function which sends a signal
to a list of processes and returns truthy or falsy. B<Note:> A truthy result
doesn't necessarily mean all processes were successfully signalled.

I<Since C<0.06>>

=over 4

=item kill example 1

  # given: synopsis;

  if ($process = $parent->fork) {
    # in forked process ...
    $process->exit;
  }

  my $kill = $parent->kill('term', int$process);

  # 1

=back

=cut

=head2 setsid

  setsid() (Int)

The setsid method calls the L<POSIX/setsid> function and sets the process group
identifier of the current process.

I<Since C<0.06>>

=over 4

=item setsid example 1

  # given: synopsis;

  my $setsid = $parent->setsid;

  # 1

=back

=over 4

=item setsid example 2

  # given: synopsis;

  my $setsid = $parent->setsid;

  # Exception! Venus::Process::Error (isa Venus::Error)

=back

=cut

=head2 stderr

  stderr(Str $path) (Process)

The stderr method redirects C<STDERR> to the path provided, typically
C</dev/null> or some equivalent. If called with no arguments C<STDERR> will be
restored to its default.

I<Since C<0.06>>

=over 4

=item stderr example 1

  # given: synopsis;

  $parent = $parent->stderr;

  # bless({...}, 'Venus::Process')

=back

=over 4

=item stderr example 2

  # given: synopsis;

  $parent = $parent->stderr('/nowhere');

  # Exception! Venus::Process:Error (isa Venus::Error)

=back

=cut

=head2 stdin

  stdin(Str $path) (Process)

The stdin method redirects C<STDIN> to the path provided, typically
C</dev/null> or some equivalent. If called with no arguments C<STDIN> will be
restored to its default.

I<Since C<0.06>>

=over 4

=item stdin example 1

  # given: synopsis;

  $parent = $parent->stdin;

  # bless({...}, 'Venus::Process')

=back

=over 4

=item stdin example 2

  # given: synopsis;

  $parent = $parent->stdin('/nowhere');

  # Exception! Venus::Process::Error (isa Venus::Error)

=back

=cut

=head2 stdout

  stdout(Str $path) (Process)

The stdout method redirects C<STDOUT> to the path provided, typically
C</dev/null> or some equivalent. If called with no arguments C<STDOUT> will be
restored to its default.

I<Since C<0.06>>

=over 4

=item stdout example 1

  # given: synopsis;

  $parent = $parent->stdout;

  # bless({...}, 'Venus::Process')

=back

=over 4

=item stdout example 2

  # given: synopsis;

  $parent = $parent->stdout('/nowhere');

  # Exception! Venus::Process::Error (isa Venus::Process)

=back

=cut

=head2 trap

  trap(Str $name, Str | CodeRef $expr) (Process)

The trap method registers a process signal trap (or callback) which will be
invoked whenever the current process receives that matching signal. The signal
traps are globally installed and will overwrite any preexisting behavior.
Signal traps are inherited by child processes (or forks) but can be overwritten
using this method, or reverted to the default behavior by using the L</untrap>
method.

I<Since C<0.06>>

=over 4

=item trap example 1

  # given: synopsis;

  $parent = $parent->trap(term => sub{
    die 'Something failed!';
  });

  # bless({...}, 'Venus::Process')

=back

=cut

=head2 untrap

  untrap(Str $name) (Process)

The untrap method restores the process signal trap specified to its default
behavior. If called with no arguments, it restores all signal traps overwriting
any user-defined signal traps in the current process.

I<Since C<0.06>>

=over 4

=item untrap example 1

  # given: synopsis;

  $parent->trap(chld => 'ignore')->trap(term => sub{
    die 'Something failed!';
  });

  $parent = $parent->untrap('term');

  # bless({...}, 'Venus::Process')

=back

=over 4

=item untrap example 2

  # given: synopsis;

  $parent->trap(chld => 'ignore')->trap(term => sub{
    die 'Something failed!';
  });

  $parent = $parent->untrap;

  # bless({...}, 'Venus::Process')

=back

=cut

=head2 wait

  wait(Int $pid) (Int, Int)

The wait method does a blocking L<perlfunc/waitpid> operation and returns the
wait status. In list context, returns the specified process' exit code (if
terminated).

I<Since C<0.06>>

=over 4

=item wait example 1

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my $wait = $parent->wait($pid);

  # 0

=back

=over 4

=item wait example 2

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my ($wait, $status) = $parent->wait('00000');

  # (-1, -1)

=back

=over 4

=item wait example 3

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork(sub{ $_->exit(1) });

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my ($wait, $status) = $parent->wait($pid);

  # ($pid, 1)

=back

=cut

=head2 work

  work(Str | CodeRef $code, Any @args) (Int)

The work method forks the current process, runs the callback provided in the
child process, and immediately exits after. This method returns the I<PID> of
the child process. It is recommended to install an L<perlfunc/alarm> in the
child process (i.e. callback) to avoid creating zombie processes in situations
where the parent process might exit before the child process is done working.

I<Since C<0.06>>

=over 4

=item work example 1

  # given: synopsis;

  my $pid = $parent->work(sub{
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  # $pid

=back

=cut

=head1 OPERATORS

This package overloads the following operators:

=cut

=over 4

=item operation: C<("")>

This package overloads the C<""> operator.

B<example 1>

  # given: synopsis;

  my $result = "$parent";

  # $pid

=back

=over 4

=item operation: C<(~~)>

This package overloads the C<~~> operator.

B<example 1>

  # given: synopsis;

  my $result = $parent ~~ /^\d+$/;

  # 1

=back