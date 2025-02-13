package Venus::Try;

use 5.018;

use strict;
use warnings;

use Venus::Class;

base 'Venus::Kind::Utility';

use Scalar::Util ();

# ATTRIBUTES

attr 'invocant';
attr 'arguments';
attr 'on_try';
attr 'on_catch';
attr 'on_default';
attr 'on_finally';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    on_try => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  $self->on_catch([]) if !defined $self->on_catch;

  return $self;
}

# METHODS

sub call {
  my ($self, $callback) = @_;

  $self->on_try($self->callback($callback));

  return $self;
}

sub callback {
  my ($self, $callback) = @_;

  if (not(UNIVERSAL::isa($callback, 'CODE'))) {
    my $invocant = $self->invocant;
    my $method = $invocant ? $invocant->can($callback) : $self->can($callback);

    $self->throw->error({
      message => sprintf(qq(Can't locate object method "%s" on package "%s"),
        ($callback, $invocant ? ref($invocant) : ref($self)))
    })
    if !$method;

    $callback = sub {goto $method};
  }

  return $callback;
}

sub catch {
  my ($self, $package, $callback) = @_;

  push @{$self->on_catch}, [$package, $self->callback($callback)];

  return $self;
}

sub default {
  my ($self, $callback) = @_;

  $self->on_default($self->callback($callback));

  return $self;
}

sub error {
  my ($self, $variable) = @_;

  $self->on_default(sub{($$variable) = @_});

  return $self;
}

sub execute {
  my ($self, $callback, @args) = @_;

  unshift @args, @{$self->arguments}
    if $self->arguments && @{$self->arguments};
  unshift @args, $self->invocant
    if $self->invocant;

  return wantarray ? ($callback->(@args)) : $callback->(@args);
}

sub finally {
  my ($self, $callback) = @_;

  $self->on_finally($self->callback($callback));

  return $self;
}

sub maybe {
  my ($self) = @_;

  $self->on_default(sub{''});

  return $self;
}

sub no_catch {
  my ($self) = @_;

  $self->on_catch([]);

  return $self;
}

sub no_default {
  my ($self) = @_;

  $self->on_default(undef);

  return $self;
}

sub no_finally {
  my ($self) = @_;

  $self->on_finally(undef);

  return $self;
}

sub no_try {
  my ($self) = @_;

  $self->on_try(undef);

  return $self;
}

sub result {
  my ($self, @args) = @_;

  my $dollarat = $@;
  my @returned;

  # try
  my $error = do {
    local $@;
    eval {
      my $tryer = $self->on_try;
      @returned = ($self->execute($tryer, @args));
    };
    $@;
  };

  # catch
  if ($error) {
    my $caught = $error;
    my $catchers = $self->on_catch;
    my $default = $self->on_default;

    for my $catcher (@$catchers) {
      if (UNIVERSAL::isa($caught, $catcher->[0])) {
        @returned = ($catcher->[1]->($caught));
        last;
      }
    }

    # catchall
    if(!@returned) {
      if ($default) {
        @returned = ($default->($caught))
      }
    }

    # uncaught
    if(!@returned) {
      if (Scalar::Util::blessed($caught)) {
        die $caught;
      }
      else {
        if (UNIVERSAL::isa($caught, 'Venus::Error')) {
          $caught->throw;
        }
        else {
          require Venus::Error;
          Venus::Error->throw($caught);
        }
      }
    }
  }

  # finally
  if (my $finally = $self->on_finally) {
    $self->execute($finally, @args);
  }

  $@ = $dollarat;

  return wantarray ? (@returned) : $returned[0];
}

1;



=head1 NAME

Venus::Try - Try Class

=cut

=head1 ABSTRACT

Try Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    # try something

    return time;
  });

  $try->catch('Example::Error', sub {
    my ($caught) = @_;

    # caught an error (exception)

    return;
  });

  $try->default(sub {
    my ($caught) = @_;

    # catch the uncaught

    return;
  });

  $try->finally(sub {
    my (@args) = @_;

    # always run after try/catch

    return;
  });

  my @args;

  my $result = $try->result(@args);

=cut

=head1 DESCRIPTION

This package provides an object-oriented interface for performing complex
try/catch operations.

=cut

=head1 ATTRIBUTES

This package has the following attributes:

=cut

=head2 invocant

  invocant(Object)

This attribute is read-only, accepts C<(Object)> values, and is optional.

=cut

=head2 arguments

  arguments(ArrayRef)

This attribute is read-only, accepts C<(ArrayRef)> values, and is optional.

=cut

=head2 on_try

  on_try(CodeRef)

This attribute is read-write, accepts C<(CodeRef)> values, and is optional.

=cut

=head2 on_catch

  on_catch(ArrayRef[CodeRef])

This attribute is read-write, accepts C<(ArrayRef[CodeRef])> values, is optional, and defaults to C<[]>.

=cut

=head2 on_default

  on_default(CodeRef)

This attribute is read-write, accepts C<(CodeRef)> values, and is optional.

=cut

=head2 on_finally

  on_finally(CodeRef)

This attribute is read-write, accepts C<(CodeRef)> values, and is optional.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind::Utility>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 call

  call(Str | CodeRef $method) (Try)

The call method takes a method name or coderef, registers it as the tryable
routine, and returns the object. When invoked, the callback will received an
C<invocant> if one was provided to the constructor, the default C<arguments> if
any were provided to the constructor, and whatever arguments were provided by
the invocant.




I<Since C<0.01>>

=over 4

=item call example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  my $call = $try->call(sub {
    my (@args) = @_;

    return [@args];
  });

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 callback

  callback(Str | CodeRef $method) (CodeRef)

The callback method takes a method name or coderef, and returns a coderef for
registration. If a coderef is provided this method is mostly a passthrough.

I<Since C<0.01>>

=over 4

=item callback example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  my $callback = $try->callback(sub {
    my (@args) = @_;

    return [@args];
  });

  # sub { ... }

=back

=over 4

=item callback example 2

  package Example1;

  sub new {
    bless {};
  }

  sub test {
    my (@args) = @_;

    return [@args];
  }

  package main;

  use Venus::Try;

  my $try = Venus::Try->new(
    invocant => Example1->new,
  );

  my $callback = $try->callback('test');

  # sub { ... }

=back

=over 4

=item callback example 3

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  my $callback = $try->callback('missing_method');

  # Exception! Venus::Try::Error (isa Venus::Error)

=back

=cut

=head2 catch

  catch(Str $isa, Str | CodeRef $method) (Try)

The catch method takes a package or ref name, and when triggered checks whether
the captured exception is of the type specified and if so executes the given
callback.

I<Since C<0.01>>

=over 4

=item catch example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $catch = $try->catch('Venus::Try', sub {
    my (@args) = @_;

    return [@args];
  });

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 default

  default(Str | CodeRef $method) (Try)

The default method takes a method name or coderef and is triggered if no
C<catch> conditions match the exception thrown.

I<Since C<0.01>>

=over 4

=item default example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $default = $try->default(sub {
    my (@args) = @_;

    return [@args];
  });

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 error

  error(Ref $variable) (Try)

The error method takes a scalar reference and assigns any uncaught exceptions
to it during execution.

I<Since C<0.01>>

=over 4

=item error example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $error = $try->error(\my $object);

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 execute

  execute(CodeRef $code, Any @args) (Any)

The execute method takes a coderef and executes it with any given arguments.
When invoked, the callback will received an C<invocant> if one was provided to
the constructor, the default C<arguments> if any were provided to the
constructor, and whatever arguments were passed directly to this method. This
method can return a list of values in list-context.

I<Since C<0.01>>

=over 4

=item execute example 1

  package Example2;

  sub new {
    bless {};
  }

  package main;

  use Venus::Try;

  my $try = Venus::Try->new(
    invocant => Example2->new,
    arguments => [1,2,3],
  );

  my $execute = $try->execute(sub {
    my (@args) = @_;

    return [@args];
  });

  # [bless({}, "Example2"), 1, 2, 3]

=back

=cut

=head2 finally

  finally(Str | CodeRef $method) (Try)

The finally method takes a package or ref name and always executes the callback
after a try/catch operation. The return value is ignored. When invoked, the
callback will received an C<invocant> if one was provided to the constructor,
the default C<arguments> if any were provided to the constructor, and whatever
arguments were provided by the invocant.

I<Since C<0.01>>

=over 4

=item finally example 1

  package Example3;

  sub new {
    bless {};
  }

  package main;

  use Venus::Try;

  my $try = Venus::Try->new(
    invocant => Example3->new,
    arguments => [1,2,3],
  );

  $try->call(sub {
    my (@args) = @_;

    return $try;
  });

  my $finally = $try->finally(sub {
    my (@args) = @_;

    $try->{args} = [@args];
  });

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 maybe

  maybe() (Try)

The maybe method registers a default C<catch> condition that returns falsy,
i.e. an empty string, if an exception is encountered.

I<Since C<0.01>>

=over 4

=item maybe example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $maybe = $try->maybe;

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 no_catch

  no_catch() (Try)

The no_catch method removes any configured catch conditions and returns the
object.

I<Since C<0.01>>

=over 4

=item no_catch example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  $try->catch('Venus::Try', sub {
    my (@args) = @_;

    return [@args];
  });


  my $no_catch = $try->no_catch;

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 no_default

  no_default() (Try)

The no_default method removes any configured default condition and returns the
object.

I<Since C<0.01>>

=over 4

=item no_default example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $default = $try->default(sub {
    my (@args) = @_;

    return [@args];
  });

  my $no_default = $try->no_default;

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 no_finally

  no_finally() (Try)

The no_finally method removes any configured finally condition and returns the
object.

I<Since C<0.01>>

=over 4

=item no_finally example 1

  package Example4;

  sub new {
    bless {};
  }

  package main;

  use Venus::Try;

  my $try = Venus::Try->new(
    invocant => Example4->new,
    arguments => [1,2,3],
  );

  $try->call(sub {
    my (@args) = @_;

    return $try;
  });

  $try->finally(sub {
    my (@args) = @_;

    $try->{args} = [@args];
  });

  my $no_finally = $try->no_finally;

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 no_try

  no_try() (Try)

The no_try method removes any configured C<try> operation and returns the
object.

I<Since C<0.01>>

=over 4

=item no_try example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    return [@args];
  });

  my $no_try = $try->no_try;

  # bless({ on_catch => ... }, "Venus::Try")

=back

=cut

=head2 result

  result(Any @args) (Any)

The result method executes the try/catch/default/finally logic and returns
either 1) the return value from the successfully tried operation 2) the return
value from the successfully matched catch condition if an exception was thrown
3) the return value from the default catch condition if an exception was thrown
and no catch condition matched. When invoked, the C<try> and C<finally>
callbacks will received an C<invocant> if one was provided to the constructor,
the default C<arguments> if any were provided to the constructor, and whatever
arguments were passed directly to this method. This method can return a list of
values in list-context.

I<Since C<0.01>>

=over 4

=item result example 1

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    return [@args];
  });

  my $result = $try->result;

  # []

=back

=over 4

=item result example 2

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    return [@args];
  });

  my $result = $try->result(1..5);

  # [1..5]

=back

=over 4

=item result example 3

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {die});

  my $result = $try->result;

  # Exception! Venus::Error

=back

=cut