package DBIx::Class::Helper::TableSample;

# ABSTRACT: Add support for tablesample clauses

use v5.10.1;

use strict;
use warnings;

use parent 'DBIx::Class::ResultSet';

use Ref::Util qw/ is_plain_arrayref is_plain_hashref is_plain_scalarref /;

# RECOMMEND PREREQ: Ref::Util::XS

use namespace::clean;

our $VERSION = 'v0.3.1';


sub _resolved_attrs {
    my $rs    = $_[0];

    $rs->next::method;

    my $attrs = $rs->{_attrs};

    if ( my $conf = delete $attrs->{tablesample} ) {

        my $from = $attrs->{from};

        $rs->throw_exception('tablesample on joins is not supported')
            if is_plain_arrayref($from) && @$from > 1;

        $conf = { fraction => $conf } unless is_plain_hashref($conf);

        $rs->throw_exception('tablesample must be a hashref')
            unless is_plain_hashref($conf);

        my $sqla = $rs->result_source->storage->sql_maker;

        my $part_sql = " tablesample";

        if (my $type = ($conf->{method} // $conf->{type})) {
            $part_sql .= " $type";
        }

        my $arg = $conf->{fraction};
        $arg = $$arg if is_plain_scalarref($arg);
        $part_sql .= "($arg)";

        if ( defined $conf->{repeatable} ) {
            my $seed = $conf->{repeatable};
            $seed = $$seed if is_plain_scalarref($seed);
            $part_sql .= sprintf( ' repeatable (%s)', $seed );
        }

        if (is_plain_arrayref($from)) {
            my $sql = $sqla->_from_chunk_to_sql($from->[0]) . $sqla->_sqlcase($part_sql);
            $from->[0] = \$sql;
        }
        else {
            my $sql = $sqla->_from_chunk_to_sql($from) . $sqla->_sqlcase($part_sql);
            $attrs->{from} = \$sql;
        }

    }

    return $attrs;
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

DBIx::Class::Helper::TableSample - Add support for tablesample clauses

=head1 VERSION

version v0.3.1

=head1 SYNOPSIS

In a resultset:

  package MyApp::Schema::ResultSet::Wobbles;

  use base qw/DBIx::Class::ResultSet/;

  __PACKAGE__->load_components( qw/
      Helper::TableSample
  /);

Using the resultset:

  my $rs = $schema->resultset('Wobbles')->search_rs(
    undef,
    {
      columns     => [qw/ id name /],
      tablesample => {
        method   => 'system',
        fraction => 0.5,
      },
    }
  );

This generates the SQL

  SELECT me.id, me.name FROM artist me TABLESAMPLE SYSTEM (0.5)

=head1 DESCRIPTION

This helper adds rudimentary support for tablesample queries
to L<DBIx::Class> resultsets.

The C<tablesample> key supports the following options as a hash
reference:

=over

=item C<fraction>

This is the percentage or fraction of the table to sample,
between 0 and 100, or a numeric expression that returns
such a value.

(Some databases may restrict this to an integer.)

The value is not checked by this helper, so you can use
database-specific extensions, e.g. C<1000 ROWS> or C<15 PERCENT>.

Scalar references are dereferenced, and expressions or
database-specific extensions should be specified has scalar
references, e.g.

  my $rs = $schema->resultset('Wobbles')->search_rs(
    undef,
    {
      columns     => [qw/ id name /],
      tablesample => {
        fraction => \ "1000 ROWS",
      },
    }
  );

=item C<method>

By default, there is no sampling method, e.g. you can simply use:

  my $rs = $schema->resultset('Wobbles')->search_rs(
    undef,
    {
      columns     => [qw/ id name /],
      tablesample => 5,
    }
  );

as an equivalent of

  my $rs = $schema->resultset('Wobbles')->search_rs(
    undef,
    {
      columns     => [qw/ id name /],
      tablesample => { fraction => 5 },
    }
  );

to generate

  SELECT me.id FROM artist me TABLESAMPLE (5)

If your database supports or requires a sampling method, you can
specify it, e.g. C<system> or C<bernoulli>.

  my $rs = $schema->resultset('Wobbles')->search_rs(
    undef,
    {
      columns     => [qw/ id name /],
      tablesample => {
         fraction => 5,
         method   => 'system',
      },
    }
  );

will generate

  SELECT me.id FROM artist me TABLESAMPLE SYSTEM (5)

See your database documentation for the allowable methods.

Prior to version 0.3.0, this was called C<type>. It is supported for
backwards compatability.

=item C<repeatable>

If this key is specified, then it will add a REPEATABLE clause,
e.g.

  my $rs = $schema->resultset('Wobbles')->search_rs(
    undef,
    {
      columns     => [qw/ id name /],
      tablesample => {
        fraction   => 5,
        repeatable => 123456,
      },
    }
  );

to generate

  SELECT me.id FROM artist me TABLESAMPLE (5) REPEATABLE (123456)

Scalar references are dereferenced, and expressions or
database-specific extensions should be specified has scalar
references.

=back

Resultsets with joins or inner queries are not supported.

Delete and update queries are not supported.

=head1 CAVEATS

This module is experimental.

Not all databases support table sampling, and those that do may have
different restrictions.  You should consult your database
documentation.

=head1 SEE ALSO

L<DBIx::Class>

=head1 SOURCE

The development version is on github at L<https://github.com/robrwo/-DBIX-Class-Helper-TableSample>
and may be cloned from L<git://github.com/robrwo/-DBIX-Class-Helper-TableSample.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/robrwo/-DBIX-Class-Helper-TableSample/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

The initial development of this module was sponsored by Science Photo
Library L<https://www.sciencephoto.com>.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2019-2022 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
