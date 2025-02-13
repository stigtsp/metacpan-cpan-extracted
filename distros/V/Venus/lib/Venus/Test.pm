package Venus::Test;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Data';

with 'Venus::Role::Buildable';

use Test::More;

use Exporter 'import';

our @EXPORT = 'test';

# EXPORTS

sub test {
  __PACKAGE__->new($_[0]);
}

# BUILDERS

sub build_self {
  my ($self, $data) = @_;

  $self->SUPER::build_self($data);
  for my $item (qw(name abstract tagline synopsis description)) {
    @{$self->find(undef, $item)} || $self->throw->error({
      message => "Test missing pod section =$item",
    });
  }

  return $self;
};

# METHODS

sub data {
  my ($self, $name, @args) = @_;

  my $method = "data_for_$name";

  $self->throw->error if !$self->can($method);

  wantarray ? ($self->$method(@args)) : $self->$method(@args);
}

sub data_for_abstract {
  my ($self) = @_;

  my $data = $self->find(undef, 'abstract');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_attributes {
  my ($self) = @_;

  my $data = $self->find(undef, 'attributes');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_attribute {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'attribute',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_authors {
  my ($self) = @_;

  my $data = $self->find(undef, 'authors');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_description {
  my ($self) = @_;

  my $data = $self->find(undef, 'description');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_example {
  my ($self, $number, $name) = @_;

  my $data = $self->search({
    list => "example-$number",
    name => quotemeta($name),
  });

  $self->throw->error if !@$data;

  my $example = join "\n\n", @{$data->[0]{data}};

  my @includes;

  if ($example =~ /# given: synopsis/) {
    push @includes, $self->data('synopsis');
  }

  if (my ($number, $name) = $example =~ /# given: example-(\d+) (\w+)/) {
    push @includes, $self->data('example', $number, $name);
  }

  $example =~ s/.*# given: .*//g;

  return join "\n\n", @includes, $example;
}

sub data_for_feature {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'feature',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_function {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'function',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_includes {
  my ($self) = @_;

  my $data = $self->find(undef, 'includes');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_inherits {
  my ($self) = @_;

  my $data = $self->find(undef, 'inherits');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_integrates {
  my ($self) = @_;

  my $data = $self->find(undef, 'integrates');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_libraries {
  my ($self) = @_;

  my $data = $self->find(undef, 'libraries');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_license {
  my ($self) = @_;

  my $data = $self->find(undef, 'license');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_metadata {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'metadata',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_method {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'method',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_name {
  my ($self) = @_;

  my $data = $self->find(undef, 'name');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_operator {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'operator',
    name => quotemeta($name),
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_project {
  my ($self) = @_;

  my $data = $self->find(undef, 'project');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_signature {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'signature',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_synopsis {
  my ($self) = @_;

  my $data = $self->find(undef, 'synopsis');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_tagline {
  my ($self) = @_;

  my $data = $self->find(undef, 'tagline');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_version {
  my ($self) = @_;

  my $data = $self->find(undef, 'version');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub default {
  my ($self) = @_;

  return '';
}

sub eval {
  my ($self, $perl) = @_;

  local $@;

  my @result = CORE::eval(join("\n\n", "no warnings q(redefine);", $perl));

  die $@ if $@;

  return wantarray ? (@result) : $result[0];
}

sub for {
  my ($self, $name, @args) = @_;

  my $result;

  my $method = "test_for_$name";

  $self->throw->error if !$self->can($method);

  subtest(join(' ', $method, grep !ref, @args), sub {
    $result = $self->$method(@args);
  });

  return $result;
}

sub head1 {
  my ($self, $name, @data) = @_;

  return join("\n", "", "=head1 \U$name", "", grep(defined, @data), "", "=cut");
}

sub head2 {
  my ($self, $name, @data) = @_;

  return join("\n", "", "=head2 \L$name", "", grep(defined, @data), "", "=cut");
}

sub item {
  my ($self, $name, $data) = @_;

  return ("=item $name\n", "$data\n");
}

sub link {
  my ($self, @data) = @_;

  return ("L<@{[join('|', @data)]}>");
}

sub over {
  my ($self, @data) = @_;

  return join("\n", "", "=over 4", "", grep(defined, @data), "=back");
}

sub pdml {
  my ($self, $name, @args) = @_;

  my $method = "pdml_for_$name";

  $self->throw->error if !$self->can($method);

  wantarray ? ($self->$method(@args)) : $self->$method(@args);
}

sub pdml_for_abstract {
  my ($self) = @_;

  my $output;

  my $text = $self->text('abstract');

  return $text ? ($self->head1('abstract', $text)) : ();
}

sub pdml_for_attribute_type1 {
  my ($self, $name, $is, $pre, $isa, $def) = @_;

  my @output;

  $is = $is eq 'ro' ? 'read-only' : 'read-write';
  $pre = $pre eq 'req' ? 'required' : 'optional';

  push @output, "  $name($isa)\n";
  push @output, "This attribute is $is, accepts C<($isa)> values, ". (
    $def ? "is $pre, and defaults to $def." : "and is $pre."
  );

  return ($self->head2($name, @output));
}

sub pdml_for_attribute_type2 {
  my ($self, $name) = @_;

  my @output;

  my $metadata = $self->text('metadata', $name);
  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('attribute', $name);

  return () if !$text;

  push @output, $text;

  if ($metadata) {
    local $@;
    if ($metadata = eval $metadata) {
      if (my $since = $metadata->{since}) {
        push @output, "", "I<Since C<$since>>";
      }
    }
  }

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, $self->pdml('example', $i, $name),
  }

  return ($self->head2($name, @output));
}

sub pdml_for_attributes {
  my ($self) = @_;

  my $method = $self->text('attributes')
    ? 'pdml_for_attributes_type1'
    : 'pdml_for_attributes_type2';

  return $self->$method;
}

sub pdml_for_attributes_type1 {
  my ($self) = @_;

  my @output;

  my $text = $self->text('attributes');

  return () if !$text;

  for my $line (split /\n/, $text) {
    push @output, $self->pdml('attribute_type1', (
      map { split /,\s*/ } split /:\s*/, $line, 2
    ));
  }

  return () if !@output;

  if (@output) {
    unshift @output, $self->head1('attributes',
      "This package has the following attributes:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_attributes_type2 {
  my ($self) = @_;

  my @output;

  for my $list ($self->search({list => 'attribute'})) {
    push @output, $self->pdml('attribute_type2', $list->{name});
  }

  if (@output) {
    unshift @output, $self->head1('attributes',
      "This package has the following attributes:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_authors {
  my ($self) = @_;

  my $output;

  my $text = $self->text('authors');

  return $text ? ($self->head1('authors', $text)) : ();
}

sub pdml_for_description {
  my ($self) = @_;

  my $output;

  my $text = $self->text('description');

  return $text ? ($self->head1('description', $text)) : ();
}

sub pdml_for_example {
  my ($self, $number, $name) = @_;

  my @output;

  my $text = $self->text('example', $number, $name);

  return $text ? ($self->over($self->item("$name example $number", $text))) : ();
}

sub pdml_for_feature {
  my ($self, $name) = @_;

  my @output;

  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('feature', $name);

  return () if !$text;

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", $self->text('example', $i, $name);
  }

  return ($self->over($self->item($name, join "\n\n", $text, @output)));
}

sub pdml_for_features {
  my ($self) = @_;

  my @output;

  for my $list ($self->search({list => 'feature'})) {
    push @output, $self->pdml('feature', $list->{name});
  }

  if (@output) {
    unshift @output, $self->head1('features',
      "This package provides the following features:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_function {
  my ($self, $name) = @_;

  my @output;

  my $metadata = $self->text('metadata', $name);
  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('function', $name);

  return () if !$text;

  push @output, $text;

  if ($metadata) {
    local $@;
    if ($metadata = eval $metadata) {
      if (my $since = $metadata->{since}) {
        push @output, "", "I<Since C<$since>>";
      }
    }
  }

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, $self->pdml('example', $i, $name),
  }

  return ($self->head2($name, @output));
}

sub pdml_for_functions {
  my ($self) = @_;

  my @output;

  my $type = 'function';
  my $text = $self->text('includes');

  for my $name (sort map /:\s*(\w+)$/, grep /^$type/, split /\n/, $text) {
    push @output, $self->pdml($type, $name);
  }

  if (@output) {
    unshift @output, $self->head1('functions',
      "This package provides the following functions:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_include {
  my ($self) = @_;

  my $output;

  my $text = $self->text('include');

  return $output;
}

sub pdml_for_includes {
  my ($self) = @_;

  my $output;

  my $text = $self->text('includes');

  return $output;
}

sub pdml_for_inherits {
  my ($self) = @_;

  my $text = $self->text('inherits');

  my @output = map +($self->link($_), ""), grep defined,
    split /\n/, $self->text('inherits');

  return '' if !@output;

  pop @output;

  return $self->head1('inherits',
    "This package inherits behaviors from:",
    "",
    @output,
  );
}

sub pdml_for_integrates {
  my ($self) = @_;

  my $text = $self->text('integrates');

  my @output = map +($self->link($_), ""), grep defined,
    split /\n/, $self->text('integrates');

  return '' if !@output;

  pop @output;

  return $self->head1('integrates',
    "This package integrates behaviors from:",
    "",
    @output,
  );
}

sub pdml_for_libraries {
  my ($self) = @_;

  my $text = $self->text('libraries');

  my @output = map +($self->link($_), ""), grep defined,
    split /\n/, $self->text('libraries');

  return '' if !@output;

  pop @output;

  return $self->head1('libraries',
    "This package uses type constraints from:",
    "",
    @output,
  );
}

sub pdml_for_license {
  my ($self) = @_;

  my $output;

  my $text = $self->text('license');

  return $text ? ($self->head1('license', $text)) : ();
}

sub pdml_for_method {
  my ($self, $name) = @_;

  my @output;

  my $metadata = $self->text('metadata', $name);
  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('method', $name);

  return () if !$text;

  push @output, $text;

  if ($metadata) {
    local $@;
    if ($metadata = eval $metadata) {
      if (my $since = $metadata->{since}) {
        push @output, "", "I<Since C<$since>>";
      }
    }
  }

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, $self->pdml('example', $i, $name),
  }

  return ($self->head2($name, @output));
}

sub pdml_for_methods {
  my ($self) = @_;

  my @output;

  my $type = 'method';
  my $text = $self->text('includes');

  for my $name (sort map /:\s*(\w+)$/, grep /^$type/, split /\n/, $text) {
    push @output, $self->pdml($type, $name);
  }

  if (@output) {
    unshift @output, $self->head1('methods',
      "This package provides the following methods:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_name {
  my ($self) = @_;

  my $output;

  my $name = join ' - ', map $self->text($_), 'name', 'tagline';

  return $name ? ($self->head1('name', $name)) : ();
}

sub pdml_for_operator {
  my ($self, $name) = @_;

  my @output;

  my $text = $self->text('operator', $name);

  return () if !$text;

  my @results = $self->search({name => quotemeta($name)});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", $self->text('example', $i, $name);
  }

  return ($self->over($self->item("operation: C<$name>", join "\n\n", $text, @output)));
}

sub pdml_for_operators {
  my ($self) = @_;

  my @output;

  for my $list ($self->search({list => 'operator'})) {
    push @output, $self->pdml('operator', $list->{name});
  }

  if (@output) {
    unshift @output, $self->head1('operators',
      "This package overloads the following operators:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_project {
  my ($self) = @_;

  my $output;

  my $text = $self->text('project');

  return $text ? ($self->head1('project', $text)) : ();
}

sub pdml_for_synopsis {
  my ($self) = @_;

  my $output;

  my $text = $self->text('synopsis');

  return $text ? ($self->head1('synopsis', $text)) : ();
}

sub pdml_for_tagline {
  my ($self) = @_;

  my $output;

  my $text = $self->text('tagline');

  return $text ? ($self->head1('tagline', $text)) : ();
}

sub pdml_for_version {
  my ($self) = @_;

  my $output;

  my $text = $self->text('version');

  return $text ? ($self->head1('version', $text)) : ();
}

sub render {
  my ($self, $file) = @_;

  require Venus::Path;

  my $path = Venus::Path->new($file);

  $path->parent->mkdirs;

  $path->write(join "\n", grep !!$_, map $self->pdml($_), qw(
    name
    abstract
    version
    synopsis
    description
    attributes
    inherits
    integrates
    libraries
    functions
    methods
    features
    operators
    authors
    license
    project
  ));

  return $path;
}

sub test_for_abstract {
  my ($self, $code) = @_;

  my $data = $self->data('abstract');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, '=abstract');

  return $result;
}

sub test_for_attributes {
  my ($self, $code) = @_;

  my $data = $self->data('attributes');
  my $package = $self->data('name');

  $code ||= sub {
    for my $line (split /\n/, $data) {
      my ($name, $is, $pre, $isa, $def) = map { split /,\s*/ } split /:\s*/,
        $line, 2;
      ok($package->can($name), "$package has $name");
      ok((($is eq 'ro' || $is eq 'rw')
      && ($pre eq 'opt' || $pre eq 'req')
      && $isa), $line);
    }
    $data
  };

  my $result = $code->();

  ok($result, "=attributes");

  return $result;
}

sub test_for_attribute {
  my ($self, $name, $code) = @_;

  my $data = $self->data('attribute', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=attribute $name");

  my $package = $self->data('name');

  ok($package->can($name), "$package has $name");

  return $result;
}

sub test_for_authors {
  my ($self, $code) = @_;

  my $data = $self->data('author');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, '=author');

  return $result;
}

sub test_for_description {
  my ($self, $code) = @_;

  my $data = $self->data('description');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, '=description');

  return $result;
}

sub test_for_example {
  my ($self, $number, $name, $code) = @_;

  my $data = $self->data('example', $number, $name);

  $code ||= sub{1};

  my $result = $code->($self->try('eval', $data));

  ok($data, "=example-$number $name");
  ok($result, "=example-$number $name returns ok");

  return $result;
}

sub test_for_feature {
  my ($self, $name, $code) = @_;

  my $data = $self->data('feature', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=feature $name");

  return $result;
}

sub test_for_function {
  my ($self, $name, $code) = @_;

  my $data = $self->data('function', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=function $name");

  return $result;
}

sub test_for_include {
  my ($self, $text) = @_;

  my ($type, $name) = @$text;

  my $blocks = [$self->search({ list => $type, name => $name })];

  ok(@$blocks, "=$type $name");

  return $blocks;
}

sub test_for_includes {
  my ($self, $code) = @_;

  my $data = $self->data('includes');

  $code ||= $self->can('test_for_include');

  ok($data, '=includes');

  my $results = [];

  push @$results, $self->$code($_) for map [split /\:\s*/], split /\n/, $data;

  return $results;
}

sub test_for_inherits {
  my ($self, $code) = @_;

  my $data = $self->data('inherits');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=inherits");

  my $package = $self->data('name');

  ok($package->isa($_), "$package isa $_") for split /\n/, $data;

  return $result;
}

sub test_for_integrates {
  my ($self, $code) = @_;

  my $data = $self->data('integrates');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=integrates");

  my $package = $self->data('name');

  ok($package->can('does'), "$package has does");
  ok($package->does($_), "$package does $_") for split /\n/, $data;

  return $result;
}

sub test_for_libraries {
  my ($self, $name, $code) = @_;

  my $data = $self->data('libraries');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=libraries");
  ok(eval("require $_"), "$_ ok") for split /\n/, $data;

  return $result;
}

sub test_for_license {
  my ($self, $name, $code) = @_;

  my $data = $self->data('license');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=license");

  return $result;
}

sub test_for_method {
  my ($self, $name, $code) = @_;

  my $data = $self->data('method', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=method $name");

  my $package = $self->data('name');

  ok($package->can($name), "$package has $name");

  return $result;
}

sub test_for_name {
  my ($self, $code) = @_;

  my $data = $self->data('name');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, '=name');
  ok(eval("require $data"), $data);

  return $result;
}

sub test_for_operator {
  my ($self, $name, $code) = @_;

  my $data = $self->data('operator', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=operator $name");

  return $result;
}

sub test_for_project {
  my ($self, $name, $code) = @_;

  my $data = $self->data('project');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=project");

  return $result;
}

sub test_for_synopsis {
  my ($self, $code) = @_;

  my $data = $self->data('synopsis');

  $code ||= sub{$_[0]->result};

  my $result = $code->($self->try('eval', $data));

  ok($data, '=synopsis');
  ok($result, '=synopsis returns ok');

  return $result;
}

sub test_for_tagline {
  my ($self, $name, $code) = @_;

  my $data = $self->data('tagline');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=tagline");

  return $result;
}

sub test_for_version {
  my ($self, $name, $code) = @_;

  my $data = $self->data('version');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=version");

  my $package = $self->data('name');

  ok(($package->VERSION // '') eq $data, "$data matched");

  return $result;
}

sub text {
  my ($self, $name, @args) = @_;

  my $method = "text_for_$name";

  $self->throw->error if !$self->can($method);

  my $result = $self->$method(@args);

  return join "\n", @$result;
}

sub text_for_abstract {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'abstract');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_attributes {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'attributes');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_attribute {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'attribute', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_authors {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'authors');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_description {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'description');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_example {
  my ($self, $number, $name) = @_;

  my $output = [];

  my $data = $self->search({
    list => "example-$number",
    name => quotemeta($name),
  });

  push @$output, join "\n\n", @{$data->[0]{data}} if @$data;

  return $output;
}

sub text_for_feature {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'feature', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_function {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'function', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_include {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'include');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_includes {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'includes');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_inherits {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'inherits');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_integrates {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'integrates');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_libraries {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'libraries');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_license {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'license');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_metadata {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'metadata', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_method {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'method', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_name {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'name');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_operator {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'operator', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_project {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'project');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_signature {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'signature', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_synopsis {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'synopsis');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_tagline {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'tagline');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_version {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'version');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  if (!@$output) {
    my $name = $self->text_for_name;
    if (my $version = ($name->[0] =~ m/([:\w]+)/m)[0]->VERSION) {
      push @$output, $version;
    }
  }

  return $output;
}

1;



=head1 NAME

Venus::Test - Test Automation

=cut

=head1 ABSTRACT

Test Automation for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Test;

  my $test = test 't/Venus_Test.t';

  # $test->for('name');

=cut

=head1 DESCRIPTION

This package aims to provide a standard for documenting L<Venus> derived
software projects, a framework writing tests, test automation, and
documentation generation.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Data>

=cut

=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Buildable>

=cut

=head1 FUNCTIONS

This package provides the following functions:

=cut

=head2 test

  test(Str $file) (Test)

The test function is exported automatically and returns a L<Venus::Test> object
for the test file given.

I<Since C<0.09>>

=over 4

=item test example 1

  package main;

  use Venus::Test;

  my $test = test 't/Venus_Test.t';

  # bless( { ..., 'value' => 't/Venus_Test.t' }, 'Venus::Test' )

=back

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 data

  data(Str $name, Any @args) (Str)

The data method attempts to find and return the POD content based on the name
provided. If the content cannot be found an exception is raised.

I<Since C<0.09>>

=over 4

=item data example 1

  # given: synopsis

  my $data = $test->data('name');

  # Venus::Test

=back

=over 4

=item data example 2

  # given: synopsis

  my $data = $test->data('unknown');

  # Exception!

=back

=cut

=head2 for

  for(Str $name | CodeRef $code, Any @args) Any

The for method attempts to find the POD content based on the name provided and
executes the corresponding predefined test, optionally accepting a callback
which, if provided, will be passes a L<Venus::Try> object containing the
POD-driven test. The callback, if provided, must always return a true value.
B<Note:> All automated tests disable the I<"redefine"> class of warnings to
prevent warnings when redeclaring packages in examples.

I<Since C<0.09>>

=over 4

=item for example 1

  # given: synopsis

  my $data = $test->for('name');

  # Venus::Test

=back

=over 4

=item for example 2

  # given: synopsis

  my $data = $test->for('synosis');

  # true

=back

=over 4

=item for example 3

  # given: synopsis

  my $data = $test->for('example', 1, 'data', sub {
    my ($tryable) = @_;
    my $result = $tryable->result;
    ok length($result) > 1;

    $result
  });

  # Venus::Test

=back

=cut

=head2 pdml

  pdml(Str $name | CodeRef $code, Any @args) Str

The pdml method attempts to find the POD content based on the name provided and
return a POD string for use in documentation.

I<Since C<0.09>>

=over 4

=item pdml example 1

  # given: synopsis

  my $pdml = $test->pdml('name');

  # =head1 NAME
  #
  # Venus::Test - Test Automation
  #
  # =cut

=back

=over 4

=item pdml example 2

  # given: synopsis

  my $pdml = $test->pdml('synopsis');

  # =head1 SYNOPSIS
  #
  # package main;
  #
  # use Venus::Test;
  #
  # my $test = test 't/Venus_Test.t';
  #
  # # $test->for('name');
  #
  # =cut

=back

=over 4

=item pdml example 3

  # given: synopsis

  my $pdml = $test->pdml('example', 1, 'data');

  # =over 4
  #
  # =item data example 1
  #
  #   # given: synopsis
  #
  #   my $data = $test->data(\'name\');
  #
  #   # Venus::Test
  #
  # =back

=back

=cut

=head2 render

  render(Str $file) Path

The render method returns a string representation of a valid POD document.

I<Since C<0.09>>

=over 4

=item render example 1

  # given: synopsis

  my $path = $test->render('t/Test_Venus.pod');

  # =over 4
  #
  # =item data example 1
  #
  #   # given: synopsis
  #
  #   my $data = $test->data(\'name\');
  #
  #   # Venus::Test
  #
  # =back

=back

=cut

=head2 text

  text(Str $name, Any @args) (Str)

The text method attempts to find and return the POD content based on the name
provided. If the content cannot be found an empty string is returned. If the
POD block is not recognized, an exception is raised.

I<Since C<0.09>>

=over 4

=item text example 1

  # given: synopsis

  my $text = $test->text('name');

  # Venus::Test

=back

=over 4

=item text example 2

  # given: synopsis

  my $text = $test->text('includes');

  # function: test
  # method: data
  # method: for
  # method: pdml
  # method: render
  # method: text

=back

=over 4

=item text example 3

  # given: synopsis

  my $text = $test->text('attributes');

  # ''

=back

=over 4

=item text example 4

  # given: synopsis

  my $text = $test->text('unknown');

  # Exception!

=back

=cut