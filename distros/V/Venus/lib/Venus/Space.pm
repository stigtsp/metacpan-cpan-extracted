package Venus::Space;

use 5.018;

use strict;
use warnings;

use Venus::Class;

base 'Venus::Name';

# BUILDERS

sub build_self {
  my ($self, $data) = @_;

  $self->{value} = $self->package if !$self->lookslike_a_pragma;

  return $self;
}

# METHODS

sub all {
  my ($self, $name, @args) = @_;

  my $result = [];
  my $class = $self->class;

  for my $package ($self->package, @{$self->inherits}) {
    push @$result, [$package, $class->new($package)->$name(@args)];
  }

  return $result;
}

sub append {
  my ($self, @args) = @_;

  my $class = $self->class;

  my $path = join '/',
    $self->path, map $class->new($_)->path, @args;

  return $class->new($path);
}

sub array {
  my ($self, $name) = @_;

  no strict 'refs';

  my $class = $self->package;

  return [@{"${class}::${name}"}];
}

sub arrays {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  my $arrays = [
    sort grep !!@{"${class}::$_"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${class}::"}
  ];

  return $arrays;
}

sub attributes {
  my ($self) = @_;

  return $self->meta->local('attrs');
}

sub authority {
  my ($self) = @_;

  return $self->scalar('AUTHORITY');
}

sub basename {
  my ($self) = @_;

  return $self->parse->[-1];
}

sub blessed {
  my ($self, $data) = @_;

  $data //= {};

  my $class = $self->load;

  return CORE::bless($data, $class);
}

sub build {
  my ($self, @args) = @_;

  my $class = $self->load;

  return $self->call('new', $class, @args);
}

sub call {
  my ($self, $func, @args) = @_;

  my $class = $self->load;

  unless ($func) {
    my $throw;
    my $error = qq(Attempt to call undefined class method in package "$class");
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(package => $self->package);
    $throw->stash(routine => $func);
    $throw->error;
  }

  my $next = $class->can($func);

  unless ($next) {
    if ($class->can('AUTOLOAD')) {
      $next = sub { no strict 'refs'; &{"${class}::${func}"}(@args) };
    }
  }

  unless ($next) {
    my $throw;
    my $error = qq(Unable to locate class method "$func" via package "$class");
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(package => $self->package);
    $throw->stash(routine => $func);
    $throw->error;
  }

  @_ = @args; goto $next;
}

sub chain {
  my ($self, @steps) = @_;

  my $result = $self;

  for my $step (@steps) {
    my ($name, @args) = (ref($step) eq 'ARRAY') ? @$step : ($step);

    $result = $result->$name(@args);
  }

  return $result;
}

sub child {
  my ($self, @args) = @_;

  return $self->append(@args);
}

sub children {
  my ($self) = @_;

  my %list;
  my $path;
  my $type;

  $path = quotemeta $self->path;
  $type = 'pm';

  my $regexp = qr/$path\/[^\/]+\.$type/;

  for my $item (keys %INC) {
    $list{$item}++ if $item =~ /$regexp$/;
  }

  my %seen;

  for my $dir (@INC) {
    next if $seen{$dir}++;

    my $re = quotemeta $dir;
    map { s/^$re\///; $list{$_}++ }
    grep !$list{$_}, glob "$dir/@{[$self->path]}/*.$type";
  }

  my $class = $self->class;

  return [
    map $class->new($_),
    map {s/(.*)\.$type$/$1/r}
    sort keys %list
  ];
}

sub cop {
  my ($self, $func, @args) = @_;

  my $class = $self->load;

  unless ($func) {
    my $throw;
    my $error = qq(Attempt to cop undefined object method from package "$class");
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(package => $self->package);
    $throw->stash(routine => $func);
    $throw->error;
  }

  my $next = $class->can($func);

  unless ($next) {
    my $throw;
    my $error = qq(Unable to locate object method "$func" via package "$class");
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(package => $self->package);
    $throw->stash(routine => $func);
    $throw->error;
  }

  return sub { $next->(@args ? (@args, @_) : @_) };
}

sub data {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  local $.;

  my $handle = \*{"${class}::DATA"};

  return '' if !fileno $handle;

  seek $handle, 0, 0;

  my $data = join '', <$handle>;

  $data =~ s/^.*\n__DATA__\r?\n/\n/s;
  $data =~ s/\n__END__\r?\n.*$/\n/s;

  return $data;
}

sub eval {
  my ($self, @args) = @_;

  local $@;

  my $result = eval join ' ', map "$_", "package @{[$self->package]};", @args;

  if (my $error = $@) {
    my $throw;
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(package => $self->package);
    $throw->error;
  }

  return $result;
}

sub explain {
  my ($self) = @_;

  return $self->package;
}

sub hash {
  my ($self, $name) = @_;

  no strict 'refs';

  my $class = $self->package;

  return {%{"${class}::${name}"}};
}

sub hashes {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  return [
    sort grep !!%{"${class}::$_"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${class}::"}
  ];
}

sub id {
  my ($self) = @_;

  return $self->label;
}

sub init {
  my ($self) = @_;

  $self->tryload;

  $self->eval('sub import') if !$self->loaded;

  return $self->package;
}

sub inherits {
  my ($self) = @_;

  return $self->array('ISA');
}

sub included {
  my ($self) = @_;

  return $INC{$self->format('path', '%s.pm')};
}

sub inject {
  my ($self, $name, $coderef) = @_;

  no strict 'refs';
  no warnings 'redefine';

  my $class = $self->package;

  return *{"${class}::${name}"} = $coderef || sub{$class};
}

sub load {
  my ($self) = @_;

  my $class = $self->package;

  return $class if $class eq 'main' || $self->loaded;

  my $error = do{local $@; eval "require $class"; $@};

  if ($error) {
    my $throw;
    $error = qq(Error attempting to load $class: @{[$error || 'cause unknown']});
    $throw = $self->throw;
    $throw->message($error);
    $throw->stash(package => $self->package);
    $throw->error;
  }

  return $class;
}

sub loaded {
  my ($self) = @_;

  return ($self->included || @{$self->routines}) ? 1 : 0;
}

sub locate {
  my ($self) = @_;

  my $found = '';

  my $file = $self->format('path', '%s.pm');

  for my $path (@INC) {
    do { $found = "$path/$file"; last } if -f "$path/$file";
  }

  return $found;
}

sub meta {
  my ($self) = @_;

  require Venus::Meta;

  return Venus::Meta->new(name => $self->package);
}

sub name {
  my ($self) = @_;

  return $self->package;
}

sub parent {
  my ($self) = @_;

  my @parts = @{$self->parse};

  pop @parts if @parts > 1;

  my $class = $self->class;

  return $class->new(join '/', @parts);
}

sub parse {
  my ($self) = @_;

  return [
    map ucfirst,
    map join('', map(ucfirst, split /[-_]/)),
    split /[^-_a-zA-Z0-9.]+/,
    $self->path
  ];
}

sub parts {
  my ($self) = @_;

  return $self->parse;
}

sub prepend {
  my ($self, @args) = @_;

  my $class = $self->class;

  my $path = join '/',
    (map $class->new($_)->path, @args), $self->path;

  return $class->new($path);
}

sub purge {
  my ($self) = @_;

  return $self if $self->unloaded;

  my $package = $self->package;

  no strict 'refs';

  for my $name (grep !/\A[^:]+::\z/, keys %{"${package}::"}) {
    undef *{"${package}::${name}"}; delete ${"${package}::"}{$name};
  }

  delete $INC{$self->format('path', '%s.pm')};

  return $self;
}

sub rebase {
  my ($self, @args) = @_;

  my $class = $self->class;

  my $path = join '/', map $class->new($_)->path, @args;

  return $class->new($self->basename)->prepend($path);
}

sub reload {
  my ($self) = @_;

  $self->unload;

  return $self->load;
}

sub require {
  my ($self, $target) = @_;

  $target = "'$target'" if -f $target;

  return $self->eval("require $target");
}

sub root {
  my ($self) = @_;

  return $self->parse->[0];
}

sub routine {
  my ($self, $name) = @_;

  no strict 'refs';

  my $class = $self->package;

  return *{"${class}::${name}"}{"CODE"};
}

sub routines {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  return [
    sort grep *{"${class}::$_"}{"CODE"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${class}::"}
  ];
}

sub scalar {
  my ($self, $name) = @_;

  no strict 'refs';

  my $class = $self->package;

  return ${"${class}::${name}"};
}

sub scalars {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  return [
    sort grep defined ${"${class}::$_"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${class}::"}
  ];
}

sub sibling {
  my ($self, @args) = @_;

  return $self->parent->append(@args);
}

sub siblings {
  my ($self) = @_;

  my %list;
  my $path;
  my $type;

  $path = quotemeta $self->parent->path;
  $type = 'pm';

  my $regexp = qr/$path\/[^\/]+\.$type/;

  for my $item (keys %INC) {
    $list{$item}++ if $item =~ /$regexp$/;
  }

  my %seen;

  for my $dir (@INC) {
    next if $seen{$dir}++;

    my $re = quotemeta $dir;
    map { s/^$re\///; $list{$_}++ }
    grep !$list{$_}, glob "$dir/@{[$self->path]}/*.$type";
  }

  my $class = $self->class;

  return [
    map $class->new($_),
    map {s/(.*)\.$type$/$1/r}
    sort keys %list
  ];
}

sub splice {
  my ($self, $offset, $length, @list) = @_;

  my $class = $self->class;
  my $parts = $self->parts;

  if (@list) {
    CORE::splice(@{$parts}, $offset, $length, @list);
  }
  elsif (defined $length) {
    CORE::splice(@{$parts}, $offset, $length);
  }
  elsif (defined $offset) {
    CORE::splice(@{$parts}, $offset);
  }

  return $class->new(join '/', @$parts);
}

sub tryload {
  my ($self) = @_;

  return do { local $@; eval { $self->load }; int!$@ };
}

sub use {
  my ($self, $target, @params) = @_;

  my $version;

  ($target, $version) = @$target if ref $target eq 'ARRAY';

  $self->require($target);

  require Scalar::Util;

  my @statement = (
    'no strict "subs";',
    (
      Scalar::Util::looks_like_number($version)
        ? "${target}->VERSION($version);" : ()
    ),
    'sub{ my ($target, @params) = @_; $target->import(@params)}'
  );

  $self->eval(join("\n", @statement))->($target, @params);

  return $self;
}

sub variables {
  my ($self) = @_;

  return [map [$_, [sort @{$self->$_}]], qw(arrays hashes scalars)];
}

sub version {
  my ($self) = @_;

  return $self->scalar('VERSION');
}

sub unload {
  my ($self) = @_;

  return $self if $self->unloaded;

  my $package = $self->package;

  no strict 'refs';

  for my $name (grep !/\A[^:]+::\z/, keys %{"${package}::"}) {
    undef *{"${package}::${name}"};
  }

  delete $INC{$self->format('path', '%s.pm')};

  return $self;
}

sub unloaded {
  my ($self) = @_;

  return $self->loaded ? 0 : 1;
}

sub visible {
  my ($self) = @_;

  no strict 'refs';

  my $package = $self->package;

  return (grep !/\A[^:]+::\z/, keys %{"${package}::"}) ? 1 : 0;
}

1;



=head1 NAME

Venus::Space - Space Class

=cut

=head1 ABSTRACT

Space Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/bar');

  # $space->package; # Foo::Bar

=cut

=head1 DESCRIPTION

This package provides methods for parsing and manipulating package namespaces.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Name>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 all

  all(Str $method, Any @args) (ArrayRef[Tuple[Str, Any]])

The all method executes any available method on the instance and all instances
representing packages inherited by the package represented by the invocant.
This method supports dispatching, i.e. providing a method name and arguments
whose return value will be acted on by this method.

I<Since C<0.01>>

=over 4

=item all example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus');

  my $all = $space->all('id');

  # [["Venus", "Venus"]]

=back

=over 4

=item all example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus/Space');

  my $all = $space->all('inherits');

  # [
  #   [
  #     "Venus::Space", ["Venus::Name"]
  #   ],
  #   [
  #     "Venus::Name", ["Venus::Kind::Utility"]
  #   ],
  # ]

=back

=over 4

=item all example 3

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus/Space');

  my $all = $space->all('locate');

  # [
  #   [
  #     "Venus::Space",
  #     "/path/to/lib/Venus/Space.pm",
  #   ],
  #   [
  #     "Venus::Name",
  #     "/path/to/lib/Venus/Name.pm",
  #   ],
  # ]

=back

=cut

=head2 append

  append(Str @path) (Space)

The append method modifies the object by appending to the package namespace
parts.

I<Since C<0.01>>

=over 4

=item append example 1

  # given: synopsis;

  my $append = $space->append('baz');

  # bless({ value => "Foo/Bar/Baz" }, "Venus::Space")

=back

=over 4

=item append example 2

  # given: synopsis;

  my $append = $space->append('baz', 'bax');

  # bless({ value => "Foo/Bar/Baz/Bax" }, "Venus::Space")

=back

=cut

=head2 array

  array(Str $name) (ArrayRef)

The array method returns the value for the given package array variable name.

I<Since C<0.01>>

=over 4

=item array example 1

  # given: synopsis;

  package Foo::Bar;

  our @handler = 'start';

  package main;

  my $array = $space->array('handler');

  # ["start"]

=back

=cut

=head2 arrays

  arrays() (ArrayRef)

The arrays method searches the package namespace for arrays and returns their
names.

I<Since C<0.01>>

=over 4

=item arrays example 1

  # given: synopsis;

  package Foo::Bar;

  our @handler = 'start';
  our @initial = ('next', 'prev');

  package main;

  my $arrays = $space->arrays;

  # ["handler", "initial"]

=back

=cut

=head2 attributes

  attributes() (ArrayRef)

The attributes method searches the package namespace for attributes and returns
their names. This will not include attributes from roles, mixins, or superclasses.

I<Since C<1.02>>

=over 4

=item attributes example 1

  package Foo::Attrs;

  use Venus::Class 'attr';

  attr 'start';
  attr 'abort';

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/attrs');

  my $attributes = $space->attributes;

  # ["start", "abort"]

=back

=over 4

=item attributes example 2

  package Foo::Base;

  use Venus::Class 'attr', 'base';

  attr 'start';
  attr 'abort';

  package Foo::Attrs;

  use Venus::Class 'attr';

  attr 'show';
  attr 'hide';

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/attrs');

  my $attributes = $space->attributes;

  # ["show", "hide"]

=back

=cut

=head2 authority

  authority() (Maybe[Str])

The authority method returns the C<AUTHORITY> declared on the target package,
if any.

I<Since C<0.01>>

=over 4

=item authority example 1

  package Foo::Boo;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/boo');

  my $authority = $space->authority;

  # undef

=back

=over 4

=item authority example 2

  package Foo::Boo;

  our $AUTHORITY = 'cpan:CPANERY';

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/boo');

  my $authority = $space->authority;

  # "cpan:CPANERY"

=back

=cut

=head2 basename

  basename() (Str)

The basename method returns the last segment of the package namespace parts.

I<Since C<0.01>>

=over 4

=item basename example 1

  # given: synopsis;

  my $basename = $space->basename;

  # "Bar"

=back

=cut

=head2 blessed

  blessed(Ref $data) (Self)

The blessed method blesses the given value into the package namespace and
returns an object. If no value is given, an empty hashref is used.

I<Since C<0.01>>

=over 4

=item blessed example 1

  # given: synopsis;

  package Foo::Bar;

  sub import;

  package main;

  my $blessed = $space->blessed;

  # bless({}, "Foo::Bar")

=back

=over 4

=item blessed example 2

  # given: synopsis;

  package Foo::Bar;

  sub import;

  package main;

  my $blessed = $space->blessed({okay => 1});

  # bless({ okay => 1 }, "Foo::Bar")

=back

=cut

=head2 build

  build(Any @args) (Self)

The build method attempts to call C<new> on the package namespace and if
successful returns the resulting object.

I<Since C<0.01>>

=over 4

=item build example 1

  # given: synopsis;

  package Foo::Bar::Baz;

  sub new {
    bless {}, $_[0];
  }

  package main;

  my $build = $space->child('baz')->build;

  # bless({}, "Foo::Bar::Baz")

=back

=over 4

=item build example 2

  # given: synopsis;

  package Foo::Bar::Bax;

  sub new {
    bless $_[1], $_[0];
  }

  package main;

  my $build = $space->child('bax')->build({okay => 1});

  # bless({ okay => 1 }, "Foo::Bar::Bax")

=back

=over 4

=item build example 3

  # given: synopsis;

  package Foo::Bar::Bay;

  sub new {
    bless $_[1], $_[0];
  }

  package main;

  my $build = $space->child('bay')->build([okay => 1]);

  # bless(["okay", 1], "Foo::Bar::Bay")

=back

=cut

=head2 call

  call(Any @args) (Any)

The call method attempts to call the given subroutine on the package namespace
and if successful returns the resulting value.

I<Since C<0.01>>

=over 4

=item call example 1

  package Foo;

  sub import;

  sub start {
    'started'
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo');

  my $result = $space->call('start');

  # "started"

=back

=over 4

=item call example 2

  package Zoo;

  sub import;

  sub AUTOLOAD {
    bless {};
  }

  sub DESTROY {
    ; # noop
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('zoo');

  my $result = $space->call('start');

  # bless({}, "Zoo")

=back

=over 4

=item call example 3

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo');

  my $result = $space->call('missing');

  # Exception! Venus::Space::Error (isa Venus::Error)

=back

=cut

=head2 chain

  chain(Str | Tuple[Str, Any] @steps) (Any)

The chain method chains one or more method calls and returns the result.

I<Since C<0.01>>

=over 4

=item chain example 1

  package Chu::Chu0;

  sub import;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Chu::Chu0');

  my $result = $space->chain('blessed');

  # bless({}, "Chu::Chu0")

=back

=over 4

=item chain example 2

  package Chu::Chu1;

  sub new {
    bless pop;
  }

  sub frame {
    [@_]
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Chu::Chu1');

  my $result = $space->chain(['blessed', {1..4}], 'frame');

  # [bless({ 1 => 2, 3 => 4 }, "Chu::Chu1")]

=back

=over 4

=item chain example 3

  package Chu::Chu2;

  sub new {
    bless pop;
  }

  sub frame {
    [@_]
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Chu::Chu2');

  my $chain = $space->chain('blessed', ['frame', {1..4}]);

  # [bless({}, "Chu::Chu2"), { 1 => 2, 3 => 4 }]

=back

=cut

=head2 child

  child(Str @path) (Space)

The child method returns a new L<Venus::Space> object for the child
package namespace.

I<Since C<0.01>>

=over 4

=item child example 1

  # given: synopsis;

  my $child = $space->child('baz');

  # bless({ value => "Foo/Bar/Baz" }, "Venus::Space")

=back

=cut

=head2 children

  children() (ArrayRef[Object])

The children method searches C<%INC> and C<@INC> and retuns a list of
L<Venus::Space> objects for each child namespace found (one level deep).

I<Since C<0.01>>

=over 4

=item children example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('c_p_a_n');

  my $children = $space->children;

  # [
  #   bless({ value => "CPAN/Author" }, "Venus::Space"),
  #   bless({ value => "CPAN/Bundle" }, "Venus::Space"),
  #   bless({ value => "CPAN/CacheMgr" }, "Venus::Space"),
  #   ...
  # ]

=back

=cut

=head2 cop

  cop(Str $method, Any @args) (CodeRef)

The cop method attempts to curry the given subroutine on the package namespace
and if successful returns a closure. This method supports dispatching, i.e.
providing a method name and arguments whose return value will be acted on by
this method.

I<Since C<0.01>>

=over 4

=item cop example 1

  package Foo::Bar;

  sub import;

  sub handler {
    [@_]
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/bar');

  my $code = $space->cop('handler', $space->blessed);

  # sub { Foo::Bar::handler(..., @_) }

=back

=over 4

=item cop example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/bar');

  my $code = $space->cop('missing', $space->blessed);

  # Exception! Venus::Space::Error (isa Venus::Error)

=back

=cut

=head2 data

  data() (Str)

The data method attempts to read and return any content stored in the C<DATA>
section of the package namespace.

I<Since C<0.01>>

=over 4

=item data example 1

  # given: synopsis;

  my $data = $space->data;

  # ""

=back

=cut

=head2 eval

  eval(Str @data) (Any)

The eval method takes a list of strings and evaluates them under the namespace
represented by the instance.

I<Since C<0.01>>

=over 4

=item eval example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo');

  my $eval = $space->eval('our $VERSION = 0.01');

  # 0.01

=back

=over 4

=item eval example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo');

  my $eval = $space->eval('die');

  # Exception! Venus::Space::Error (isa Venus::Error)

=back

=cut

=head2 explain

  explain() (Str)

The explain method returns the package name and is used in stringification
operations.

I<Since C<0.01>>

=over 4

=item explain example 1

  # given: synopsis;

  my $explain = $space->explain;

  # "Foo::Bar"

=back

=cut

=head2 hash

  hash(Str $name) (HashRef)

The hash method returns the value for the given package hash variable name.

I<Since C<0.01>>

=over 4

=item hash example 1

  # given: synopsis;

  package Foo::Bar;

  our %settings = (
    active => 1
  );

  package main;

  my $hash = $space->hash('settings');

  # { active => 1 }

=back

=cut

=head2 hashes

  hashes() (ArrayRef)

The hashes method searches the package namespace for hashes and returns their
names.

I<Since C<0.01>>

=over 4

=item hashes example 1

  # given: synopsis;

  package Foo::Bar;

  our %defaults = (
    active => 0
  );

  our %settings = (
    active => 1
  );

  package main;

  my $hashes = $space->hashes;

  # ["defaults", "settings"]

=back

=cut

=head2 id

  id() (Str)

The id method returns the fully-qualified package name as a label.

I<Since C<0.01>>

=over 4

=item id example 1

  # given: synopsis;

  my $id = $space->id;

  # "Foo_Bar"

=back

=cut

=head2 included

  included() (Str | Undef)

The included method returns the path of the namespace if it exists in C<%INC>.

I<Since C<0.01>>

=over 4

=item included example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus/Space');

  my $included = $space->included;

  # "/path/to/lib/Venus/Space.pm"

=back

=cut

=head2 inherits

  inherits() (ArrayRef)

The inherits method returns the list of superclasses the target package is
derived from.

I<Since C<0.01>>

=over 4

=item inherits example 1

  package Bar;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('bar');

  my $inherits = $space->inherits;

  # []

=back

=over 4

=item inherits example 2

  package Foo;

  sub import;

  package Bar;

  use base 'Foo';

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('bar');

  my $inherits = $space->inherits;

  # ["Foo"]

=back

=cut

=head2 init

  init() (Str)

The init method ensures that the package namespace is loaded and, whether
created in-memory or on-disk, is flagged as being loaded and loadable.

I<Since C<0.01>>

=over 4

=item init example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('kit');

  my $init = $space->init;

  # "Kit"

=back

=cut

=head2 inject

  inject(Str $name, Maybe[CodeRef] $coderef) (Any)

The inject method monkey-patches the package namespace, installing a named
subroutine into the package which can then be called normally, returning the
fully-qualified subroutine name.

I<Since C<0.01>>

=over 4

=item inject example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('kit');

  my $inject = $space->inject('build', sub { 'finished' });

  # *Kit::build

=back

=cut

=head2 load

  load() (Str)

The load method checks whether the package namespace is already loaded and if
not attempts to load the package. If the package is not loaded and is not
loadable, this method will throw an exception using confess. If the package is
loadable, this method returns truthy with the package name. As a workaround for
packages that only exist in-memory, if the package contains a C<new>, C<with>,
C<meta>, or C<import> routine it will be recognized as having been loaded.

I<Since C<0.01>>

=over 4

=item load example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('c_p_a_n');

  my $load = $space->load;

  # "CPAN"

=back

=over 4

=item load example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('no/thing');

  my $load = $space->load;

  # Exception! Venus::Space::Error (isa Venus::Error)

=back

=cut

=head2 loaded

  loaded() (Bool)

The loaded method checks whether the package namespace is already loaded and
returns truthy or falsy.

I<Since C<0.01>>

=over 4

=item loaded example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Kit');

  $space->init;

  $space->unload;

  my $loaded = $space->loaded;

  # 0

=back

=over 4

=item loaded example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Kit');

  $space->init;

  my $loaded = $space->loaded;

  # 1

=back

=cut

=head2 locate

  locate() (Str)

The locate method checks whether the package namespace is available in
C<@INC>, i.e. on disk. This method returns the file if found or an empty
string.

I<Since C<0.01>>

=over 4

=item locate example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('xyz');

  my $locate = $space->locate;

  # ""

=back

=over 4

=item locate example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('data/dumper');

  $space->load;

  my $locate = $space->locate;

  # "/path/to/lib/Data/Dumper.pm"

=back

=cut

=head2 meta

  meta() (Meta)

The meta method returns a L<Venus::Meta> object representing the underlying
package namespace. To access the meta object for the instance itself, use the
superclass' L<Venus::Core/META> method.

I<Since C<1.02>>

=over 4

=item meta example 1

  # given: synopsis

  package main;

  my $meta = $space->meta;

  # bless({'name' => 'Foo::Bar'}, 'Venus::Meta')

=back

=over 4

=item meta example 2

  # given: synopsis

  package main;

  my $meta = $space->META;

  # bless({'name' => 'Venus::Space'}, 'Venus::Meta')

=back

=cut

=head2 name

  name() (Str)

The name method returns the fully-qualified package name.

I<Since C<0.01>>

=over 4

=item name example 1

  # given: synopsis;

  my $name = $space->name;

  # "Foo::Bar"

=back

=cut

=head2 parent

  parent() (Space)

The parent method returns a new L<Venus::Space> object for the parent package
namespace.

I<Since C<0.01>>

=over 4

=item parent example 1

  # given: synopsis;

  my $parent = $space->parent;

  # bless({ value => "Foo" }, "Venus::Space")

=back

=cut

=head2 parse

  parse() (ArrayRef)

The parse method parses the string argument and returns an arrayref of package
namespace segments (parts).

I<Since C<0.01>>

=over 4

=item parse example 1

  # given: synopsis;

  my $parse = $space->parse;

  # ["Foo", "Bar"]

=back

=over 4

=item parse example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo/Bar');

  my $parse = $space->parse;

  # ["Foo", "Bar"]

=back

=over 4

=item parse example 3

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo\Bar');

  my $parse = $space->parse;

  # ["Foo", "Bar"]

=back

=over 4

=item parse example 4

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo-Bar');

  my $parse = $space->parse;

  # ["FooBar"]

=back

=over 4

=item parse example 5

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo_Bar');

  my $parse = $space->parse;

  # ["FooBar"]

=back

=cut

=head2 parts

  parts() (ArrayRef)

The parts method returns an arrayref of package namespace segments (parts).

I<Since C<0.01>>

=over 4

=item parts example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo');

  my $parts = $space->parts;

  # ["Foo"]

=back

=over 4

=item parts example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo/Bar');

  my $parts = $space->parts;

  # ["Foo", "Bar"]

=back

=over 4

=item parts example 3

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo_Bar');

  my $parts = $space->parts;

  # ["FooBar"]

=back

=cut

=head2 prepend

  prepend(Str @path) (Space)

The prepend method modifies the object by prepending to the package namespace
parts.

I<Since C<0.01>>

=over 4

=item prepend example 1

  # given: synopsis;

  my $prepend = $space->prepend('etc');

  # bless({ value => "Etc/Foo/Bar" }, "Venus::Space")

=back

=over 4

=item prepend example 2

  # given: synopsis;

  my $prepend = $space->prepend('etc', 'tmp');

  # bless({ value => "Etc/Tmp/Foo/Bar" }, "Venus::Space")

=back

=cut

=head2 purge

  purge() (Self)

The purge method purges a package space by expunging its symbol table and
removing it from C<%INC>.

I<Since C<1.02>>

=over 4

=item purge example 1

  package main;

  use Venus::Space;

  # Bar::Gen is generated with $VERSION as 0.01

  my $space = Venus::Space->new('Bar/Gen');

  $space->load;

  my $purge = $space->purge;

  # bless({ value => "Bar::Gen" }, "Venus::Space")

  # Bar::Gen->VERSION was 0.01, now undef

  # Symbol table is gone, $space->visible is 0

=back

=cut

=head2 rebase

  rebase(Str @path) (Space)

The rebase method returns an object by prepending the package namespace
specified to the base of the current object's namespace.

I<Since C<0.01>>

=over 4

=item rebase example 1

  # given: synopsis;

  my $rebase = $space->rebase('zoo');

  # bless({ value => "Zoo/Bar" }, "Venus::Space")

=back

=cut

=head2 reload

  reload() (Str)

The reload method attempts to delete and reload the package namespace using the
L</load> method. B<Note:> Reloading is additive and will overwrite existing
symbols but does not remove symbols.

I<Since C<0.01>>

=over 4

=item reload example 1

  package main;

  use Venus::Space;

  # Foo::Gen is generated with $VERSION as 0.01

  my $space = Venus::Space->new('Foo/Gen');

  my $reload = $space->reload;

  # Foo::Gen
  # Foo::Gen->VERSION is 0.01

=back

=over 4

=item reload example 2

  package main;

  use Venus::Space;

  # Foo::Gen is generated with $VERSION as 0.02

  my $space = Venus::Space->new('Foo/Gen');

  my $reload = $space->reload;

  # Foo::Gen
  # Foo::Gen->VERSION is 0.02

=back

=cut

=head2 require

  require(Str $target) (Any)

The require method executes a C<require> statement within the package namespace
specified.

I<Since C<0.01>>

=over 4

=item require example 1

  # given: synopsis;

  my $require = $space->require('Venus');

  # 1

=back

=cut

=head2 root

  root() (Str)

The root method returns the root package namespace segments (parts). Sometimes
separating the C<root> from the C<parts> helps identify how subsequent child
objects were derived.

I<Since C<0.01>>

=over 4

=item root example 1

  # given: synopsis;

  my $root = $space->root;

  # "Foo"

=back

=cut

=head2 routine

  routine(Str $name) (CodeRef)

The routine method returns the subroutine reference for the given subroutine
name.

I<Since C<0.01>>

=over 4

=item routine example 1

  package Foo;

  sub cont {
    [@_]
  }

  sub abort {
    [@_]
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo');

  my $routine = $space->routine('cont');

  # sub { ... }

=back

=cut

=head2 routines

  routines() (ArrayRef)

The routines method searches the package namespace for routines and returns
their names.

I<Since C<0.01>>

=over 4

=item routines example 1

  package Foo::Subs;

  sub start {
    1
  }

  sub abort {
    1
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/subs');

  my $routines = $space->routines;

  # ["abort", "start"]

=back

=cut

=head2 scalar

  scalar(Str $name) (Any)

The scalar method returns the value for the given package scalar variable name.

I<Since C<0.01>>

=over 4

=item scalar example 1

  # given: synopsis;

  package Foo::Bar;

  our $root = '/path/to/file';

  package main;

  my $scalar = $space->scalar('root');

  # "/path/to/file"

=back

=cut

=head2 scalars

  scalars() (ArrayRef)

The scalars method searches the package namespace for scalars and returns their
names.

I<Since C<0.01>>

=over 4

=item scalars example 1

  # given: synopsis;

  package Foo::Bar;

  our $root = 'root';
  our $base = 'path/to';
  our $file = 'file';

  package main;

  my $scalars = $space->scalars;

  # ["base", "file", "root"]

=back

=cut

=head2 sibling

  sibling(Str $path) (Space)

The sibling method returns a new L<Venus::Space> object for the sibling package
namespace.

I<Since C<0.01>>

=over 4

=item sibling example 1

  # given: synopsis;

  my $sibling = $space->sibling('baz');

  # bless({ value => "Foo/Baz" }, "Venus::Space")

=back

=cut

=head2 siblings

  siblings() (ArrayRef[Object])

The siblings method searches C<%INC> and C<@INC> and retuns a list of
L<Venus::Space> objects for each sibling namespace found (one level deep).

I<Since C<0.01>>

=over 4

=item siblings example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('encode/m_i_m_e');

  my $siblings = $space->siblings;

  # [
  #   bless({ value => "Encode/MIME/Header" }, "Venus::Space"),
  #   bless({ value => "Encode/MIME/Name" }, "Venus::Space"),
  #   ...
  # ]

=back

=cut

=head2 splice

  splice(Int $offset, Int $length, Any @list) (Space)

The splice method perform a Perl L<perlfunc/splice> operation on the package
namespace.

I<Since C<0.09>>

=over 4

=item splice example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/baz');

  my $splice = $space->splice(1, 0, 'bar');

  # bless({ value => "Foo/Bar/Baz" }, "Venus::Space")

=back

=over 4

=item splice example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/baz');

  my $splice = $space->splice(1, 1);

  # bless({ value => "Foo" }, "Venus::Space")

=back

=over 4

=item splice example 3

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/baz');

  my $splice = $space->splice(-2, 1);

  # bless({ value => "Baz" }, "Venus::Space")

=back

=over 4

=item splice example 4

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/baz');

  my $splice = $space->splice(1);

  # bless({ value => "Foo" }, "Venus::Space")

=back

=cut

=head2 tryload

  tryload() (Bool)

The tryload method attempt to C<load> the represented package using the
L</load> method and returns truthy/falsy based on whether the package was
loaded.

I<Since C<0.01>>

=over 4

=item tryload example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('c_p_a_n');

  my $tryload = $space->tryload;

  # 1

=back

=over 4

=item tryload example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('n_a_p_c');

  my $tryload = $space->tryload;

  # 0

=back

=cut

=head2 unload

  unload() (Self)

The unload method unloads a package space by nullifying its symbol table and
removing it from C<%INC>.

I<Since C<1.02>>

=over 4

=item unload example 1

  package main;

  use Venus::Space;

  # Bar::Gen is generated with $VERSION as 0.01

  my $space = Venus::Space->new('Bar/Gen');

  $space->load;

  my $unload = $space->unload;

  # bless({ value => "Bar::Gen" }, "Venus::Space")

  # Bar::Gen->VERSION was 0.01, now undef

  # Symbol table remains, $space->visible is 1

=back

=cut

=head2 use

  use(Str | Tuple[Str, Str] $target, Any @params) (Space)

The use method executes a C<use> statement within the package namespace
specified.

I<Since C<0.01>>

=over 4

=item use example 1

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/goo');

  my $use = $space->use('Venus');

  # bless({ value => "foo/goo" }, "Venus::Space")

=back

=over 4

=item use example 2

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/hoo');

  my $use = $space->use('Venus', 'error');

  # bless({ value => "foo/hoo" }, "Venus::Space")

=back

=over 4

=item use example 3

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/foo');

  my $use = $space->use(['Venus', 9.99], 'error');

=back

=cut

=head2 variables

  variables() (ArrayRef[Tuple[Str, ArrayRef]])

The variables method searches the package namespace for variables and returns
their names.

I<Since C<0.01>>

=over 4

=item variables example 1

  package Etc;

  our $init = 0;
  our $func = 1;

  our @does = (1..4);
  our %sets = (1..4);

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('etc');

  my $variables = $space->variables;

  # [
  #   ["arrays", ["does"]],
  #   ["hashes", ["sets"]],
  #   ["scalars", ["func", "init"]],
  # ]

=back

=cut

=head2 version

  version() (Maybe[Str])

The version method returns the C<VERSION> declared on the target package, if
any.

I<Since C<0.01>>

=over 4

=item version example 1

  package Foo::Boo;

  sub import;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/boo');

  my $version = $space->version;

  # undef

=back

=over 4

=item version example 2

  package Foo::Boo;

  our $VERSION = 0.01;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/boo');

  my $version = $space->version;

  # 0.01

=back

=cut

=head2 visible

  visible() (Bool)

The visible method returns truthy is the package namespace is visible, i.e. has
symbols defined.

I<Since C<1.02>>

=over 4

=item visible example 1

  # given: synopsis

  package main;

  my $visible = $space->visible;

  # 1

=back

=over 4

=item visible example 2

  package Foo::Fe;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/fe');

  my $visible = $space->visible;

  # 0

=back

=over 4

=item visible example 3

  package Foo::Fe;

  our $VERSION = 0.01;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/fe');

  my $visible = $space->visible;

  # 1

=back

=over 4

=item visible example 4

  package Foo::Fi;

  sub import;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/fi');

  my $visible = $space->visible;

  # 1

=back

=cut