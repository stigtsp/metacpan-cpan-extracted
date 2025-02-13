package # hide from PAUSE
App::DBBrowser::DB;

use warnings;
use strict;
use 5.014;

our $VERSION = '2.303';

#use bytes; # required
use Scalar::Util qw( looks_like_number );


sub new {
    my ( $class, $info, $opt ) = @_;
    my $db_module  = $info->{plugin};
    eval "require $db_module" or die $@;
    my $plugin = $db_module->new( $info, $opt );
    bless { Plugin => $plugin }, $class;
}


sub get_db_driver {
    my ( $sf ) = @_;
    my $driver = $sf->{Plugin}->get_db_driver();
    return $driver;
}


sub get_db_handle {
    my ( $sf, $db ) = @_;
    my $dbh = $sf->{Plugin}->get_db_handle( $db );
    if ( $dbh->{Driver}{Name} eq 'SQLite' ) {
        $dbh->sqlite_create_function( 'regexp', 3, sub {
                my ( $regex, $string, $case_sensitive ) = @_;
                $string = '' if ! defined $string;
                return $string =~ m/$regex/sm if $case_sensitive;
                return $string =~ m/$regex/ism;
            }
        );
        $dbh->sqlite_create_function( 'truncate', 2, sub {
                my ( $number, $places ) = @_;
                if ( ! looks_like_number( $number ) ) {
                    return $number;
                }
                #my $nu = $number  . '';
                #return int( $nu * 10 ** $places ) / 10 ** $places;
                elsif ( ! $places ) {
                    return 0 + ( $number =~ /^([-+]?[0-9]+)/ )[0];
                }
                elsif ( $number =~ /^([-+]?[0-9]+\.[0-9]{1,$places})/ ) {
                    return 0 + $1;
                }
                return $number;
            }
        );
        $dbh->sqlite_create_function( 'bit_length', 1, sub {
                require bytes;
                return if ! defined $_[0];
                return 8 * bytes::length $_[0];
            }
        );
        $dbh->sqlite_create_function( 'char_length', 1, sub {
                return length $_[0];
            }
        );
    }
    return $dbh;
}


sub get_schemas {
    my ( $sf, $dbh, $db ) = @_;
    my ( $user_schema, $sys_schema );
    if ( $sf->{Plugin}->can( 'get_schemas' ) ) {
        ( $user_schema, $sys_schema ) = $sf->{Plugin}->get_schemas( $dbh, $db );
    }
    else {
        my $driver = $dbh->{Driver}{Name}; #
        if ( $driver eq 'SQLite' ) {
            $user_schema = [ 'main' ]; # [ undef ];
        }
        elsif( $driver =~ /^(?:mysql|MariaDB)\z/ ) {
            # MySQL 5.7 Reference Manual  /  MySQL Glossary:
            # In MySQL, physically, a schema is synonymous with a database.
            # You can substitute the keyword SCHEMA instead of DATABASE in MySQL SQL syntax,
            $user_schema = [ $db ];
        }
        elsif( $driver eq 'Pg' ) {
            my $sth = $dbh->table_info( undef, '%', undef, undef );
            # pg_schema: the unquoted name of the schema
            my $info = $sth->fetchall_hashref( 'pg_schema' );
            my $qr = qr/^(?:pg_|information_schema$)/;
            for my $schema ( keys %$info ) {
                if ( $schema =~ /$qr/ ) {
                    push @$sys_schema, $schema;
                }
                else {
                    push @$user_schema, $schema;
                }
            }
        }
        else {
            my $sth = $dbh->table_info( undef, '%', undef, undef );
            my $info = $sth->fetchall_hashref( 'TABLE_SCHEM' );
            $user_schema = [ keys %$info ];
        }
    }
    $user_schema = [] if ! defined $user_schema;
    $sys_schema  = [] if ! defined $sys_schema;
    return $user_schema, $sys_schema;
}


sub read_login_data {
    my ( $sf ) = @_;
    return [] if ! $sf->{Plugin}->can( 'read_login_data' );
    my $read_args = $sf->{Plugin}->read_login_data();
    return [] if ! defined $read_args;
    return $read_args;
}


sub env_variables {
    my ( $sf ) = @_;
    return [] if ! $sf->{Plugin}->can( 'env_variables' );
    my $env_variables = $sf->{Plugin}->env_variables();
    return [] if ! defined $env_variables;
    return $env_variables;
}


sub read_attributes {
    my ( $sf ) = @_;
    return [] if ! $sf->{Plugin}->can( 'read_attributes' );
    my $read_attributes = $sf->{Plugin}->read_attributes();
    return [] if ! defined $read_attributes;
    return $read_attributes;
}


sub set_attributes {
    my ( $sf ) = @_;
    return [] if ! $sf->{Plugin}->can( 'set_attributes' );
    my $set_attributes = $sf->{Plugin}->set_attributes();
    return [] if ! defined $set_attributes;
    return $set_attributes;
}


sub get_databases {
    my ( $sf ) = @_;
    my ( $user_db, $sys_db ) = $sf->{Plugin}->get_databases();
    $user_db = [] if ! defined $user_db;
    $sys_db  = [] if ! defined $sys_db;
    return $user_db, $sys_db;
}


sub tables_info { # not public
    my ( $sf, $dbh, $schema ) = @_;
    my $tables_info = {};
    # The table names in the $tables_info keys are used in the tables menu but not in SQL code. To get the table names
    # for SQL code it is used the 'quote_table' routine.
    my ( $table_schem, $table_name );
    if ( $sf->get_db_driver eq 'Pg' ) {
        $table_schem = 'pg_schema';
        $table_name  = 'pg_table';
        # DBD::Pg  3.7.4:
        # The TABLE_SCHEM and TABLE_NAME will be quoted via quote_ident().
        # Two additional fields specific to DBD::Pg are returned:
        # pg_schema: the unquoted name of the schema
        # pg_table: the unquoted name of the table
    }
    else {
        $table_schem = 'TABLE_SCHEM';
        $table_name  = 'TABLE_NAME';
    }
    my @keys = ( 'TABLE_CAT', $table_schem, $table_name, 'TABLE_TYPE' );
    my $sth = $dbh->table_info( undef, $schema, undef, undef );
    my $info_tables = $sth->fetchall_arrayref( { map { $_ => 1 } @keys } );
    my %equal_table_names;
    for my $info_table ( @$info_tables ) {
        next if $info_table->{TABLE_TYPE} eq 'INDEX';
        next if $info_table->{TABLE_TYPE} =~ /^SYSTEM/ && ! $sf->{Plugin}{o}{G}{metadata};
        my $table;
        if ( $sf->get_db_driver eq 'SQLite' && ! defined $schema ) {
            # The $schema is undefined if: SQLite + attached databases
            if ( $info_table->{$table_schem} =~ /^main\z/i ) {
                $table = sprintf "[%s] %s", "\x{001f}" . $info_table->{$table_schem}, $info_table->{$table_name};
                # \x{001f} keeps the main tables on top of the tables menu.
            }
            else {
                $table = sprintf "[%s] %s", $info_table->{$table_schem}, $info_table->{$table_name};
            }
        }
        else {
            $table = $info_table->{$table_name};
        }
        $tables_info->{$table} = [ @{$info_table}{@keys} ];
    }
    return $tables_info;
}


sub first_column_is_autoincrement {
    my ( $sf, $dbh, $schema, $table ) = @_;
    if ( $sf->get_db_driver eq 'SQLite' ) {
        my $sql = "SELECT sql FROM sqlite_master WHERE name = ?";
        my ( $row ) = $dbh->selectrow_array( $sql, {}, $table );
        my $qt_table = $dbh->quote_identifier( $table );
        my $sth = $dbh->prepare( "SELECT * FROM " . $qt_table . " LIMIT 0" );
        my $col = $sth->{NAME}[0];
        my $qt_col = $dbh->quote_identifier( $col );
        if ( $row =~ /^\s*CREATE\s+TABLE\s+(?:\Q$table\E|\Q$qt_table\E)\s+\(\s*(?:\Q$col\E|\Q$qt_col\E)\s+INTEGER\s+PRIMARY\s+KEY[^,]*,/i ) {
            return 1;
        }
    }
    elsif ( $sf->get_db_driver =~ /^(?:mysql|MariaDB)\z/ ) {
        my $sql = "SELECT COUNT(*) FROM information_schema.columns WHERE
                    TABLE_SCHEMA = ?
                AND TABLE_NAME = ?
                AND ORDINAL_POSITION = 1
                AND DATA_TYPE = 'int'
                AND COLUMN_DEFAULT IS NULL
                AND IS_NULLABLE = 'NO'
                AND EXTRA like '%auto_increment%'";
        my ( $first_col_is_autoincrement ) = $dbh->selectrow_array( $sql, {}, $schema, $table );
        return $first_col_is_autoincrement;
    }
    elsif ( $sf->get_db_driver eq 'Pg' ) {
        my $sql = "SELECT COUNT(*) FROM information_schema.columns WHERE
                    TABLE_SCHEMA = ?
                AND TABLE_NAME = ?
                AND ORDINAL_POSITION = 1
                AND DATA_TYPE = 'integer'
                AND IS_NULLABLE = 'NO'
                AND (
                       UPPER(column_default) LIKE 'NEXTVAL%'
                    OR UPPER(identity_generation) = 'BY DEFAULT'
                )";
        my ( $first_col_is_autoincrement ) = $dbh->selectrow_array( $sql, {}, $schema, $table );
        return $first_col_is_autoincrement;
    }
    elsif ( $sf->get_db_driver eq 'Firebird' ) {
        my $sql = "SELECT COUNT(*) FROM RDB\$RELATION_FIELDS WHERE
                RDB\$RELATION_NAME = ?
            AND RDB\$FIELD_POSITION = 0
            AND (
                   RDB\$IDENTITY_TYPE = 0
                OR RDB\$IDENTITY_TYPE = 1
            )";
        my ( $first_col_is_autoincrement ) = $dbh->selectrow_array( $sql, {}, $table );
        return $first_col_is_autoincrement;
    }
    return;
}


sub primary_key_autoincrement_constraint {
    # provide "primary_key_autoincrement_constraint" only if also "first_col_is_autoincrement" is available
    my ( $sf, $dbh ) = @_;
    if ( $sf->get_db_driver eq 'SQLite' ) {
        return "INTEGER PRIMARY KEY";
    }
    if ( $sf->get_db_driver =~ /^(?:mysql|MariaDB)\z/ ) {
        return "INT NOT NULL AUTO_INCREMENT PRIMARY KEY";
        # mysql: NOT NULL added automatically with AUTO_INCREMENT
    }
    if ( $sf->get_db_driver eq 'Pg' ) {
        my ( $pg_version ) = $dbh->selectrow_array( "SELECT version()" );
        if ( $pg_version =~ /^\S+\s+([0-9]+)(?:\.[0-9]+)*\s/ && $1 >= 10 ) {
            # since PostgreSQL version 10
            return "INT generated BY DEFAULT AS IDENTITY PRIMARY KEY";
        }
        else {
            return "SERIAL PRIMARY KEY";
        }
    }
    if ( $sf->get_db_driver eq 'Firebird' ) {
        my ( $firebird_version ) = $dbh->selectrow_array( "SELECT RDB\$GET_CONTEXT('SYSTEM', 'ENGINE_VERSION') FROM RDB\$DATABASE" );
        my $firebird_major_version = $firebird_version =~ s/^(\d+).+\z/$1/r;
        if ( $firebird_major_version >= 4 ) {
            return "INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY";
        }
        elsif ( $firebird_major_version >= 3 ) {
            return "INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY";
        }
    }
}


sub regexp {
    my ( $sf, $col, $do_not_match, $case_sensitive ) = @_;
    if ( $sf->get_db_driver eq 'SQLite' ) {
        if ( $do_not_match ) {
            return sprintf ' NOT REGEXP(?,%s,%d)', $col, $case_sensitive;
        }
        else {
            return sprintf ' REGEXP(?,%s,%d)', $col, $case_sensitive;
        }
    }
    elsif ( $sf->get_db_driver =~ /^(?:mysql|MariaDB)\z/ ) {
        if ( $do_not_match ) {
            return ' ' . $col . ' NOT REGEXP ?'        if ! $case_sensitive;
            return ' ' . $col . ' NOT REGEXP BINARY ?' if   $case_sensitive;
        }
        else {
            return ' ' . $col . ' REGEXP ?'            if ! $case_sensitive;
            return ' ' . $col . ' REGEXP BINARY ?'     if   $case_sensitive;
        }
    }
    elsif ( $sf->get_db_driver eq 'Pg' ) {
        if ( $do_not_match ) {
            return ' ' . $col . '::text' . ' !~* ?' if ! $case_sensitive;
            return ' ' . $col . '::text' . ' !~ ?'  if   $case_sensitive;
        }
        else {
            return ' ' . $col . '::text' . ' ~* ?'  if ! $case_sensitive;
            return ' ' . $col . '::text' . ' ~ ?'   if   $case_sensitive;
        }
    }
    elsif ( $sf->get_db_driver eq 'Firebird' ) {
        if ( $do_not_match ) {
            return ' ' . $col . ' NOT SIMILAR TO ? ESCAPE \'#\'';
        }
        else {
            return ' ' . $col . ' SIMILAR TO ? ESCAPE \'#\'';
        }
    }
}


sub function_with_col {
    my ( $sf, $func, $col ) = @_;
    $func = uc( $func );
    if ( $func eq 'LTRIM' ) {
        return "TRIM(LEADING FROM $col)"  if $sf->get_db_driver =~ /^(?:Pg|Firebird)\z/;
        return "LTRIM($col)";
    }
    elsif ( $func eq 'RTRIM' ) {
        return "TRIM(TRAILING FROM $col)" if $sf->get_db_driver =~ /^(?:Pg|Firebird)\z/;
        return "RTRIM($col)";
    }
    else {
        return "$func($col)";
    }
}


sub function_with_col_and_arg {
    my ( $sf, $func, $col, $arg ) = @_;
    $func = uc( $func );
    if ( $func eq 'CAST' ) {
        return "CAST($col AS $arg)";
    }
    elsif ( $func eq 'ROUND' ) {
        return "ROUND($col,$arg)";
    }
    elsif ( $func eq 'TRUNCATE' ) {
        #if ( $sf->get_db_driver eq 'SQLite' ) {
        #    my $prec_num = '1' . '0' x $arg;
        #    return "cast( ( $col * $prec_num ) as int ) / $prec_num.0";
        #}
        return "TRUNC($col,$arg)"     if $sf->get_db_driver =~ /^(?:Pg|Firebird)\z/;
        return "TRUNCATE($col,$arg)";
    }
}


sub concatenate {
    my ( $sf, $arguments, $sep ) = @_;
    my $arg;
    if ( defined $sep && length $sep ) {
        my $qt_sep = "'" . $sep . "'";
        for ( @$arguments ) {
            push @$arg, $_, $qt_sep;
        }
        pop @$arg;
    }
    else {
        $arg = $arguments
    }
    return "CONCAT(" . join( ',', @$arg ) . ")"  if $sf->get_db_driver =~ /^(?:mysql|MariaDB)\z/;
    return join( " || ", @$arg );
}


sub epoch_to_date {
    my ( $sf, $col, $interval ) = @_;
    return "DATE($col/$interval,'unixepoch','localtime')"                        if $sf->get_db_driver eq 'SQLite';
    return "FROM_UNIXTIME($col/$interval,'%Y-%m-%d')"                            if $sf->get_db_driver =~ /^(?:mysql|MariaDB)\z/;
    return "TO_TIMESTAMP(${col}::bigint/$interval)::date"                        if $sf->get_db_driver eq 'Pg';
    return "DATEADD(CAST($col AS BIGINT)/$interval SECOND TO DATE '1970-01-01')" if $sf->get_db_driver eq 'Firebird';
}


sub epoch_to_datetime {
    my ( $sf, $col, $interval ) = @_;
    return "DATETIME($col/$interval,'unixepoch','localtime')"                                  if $sf->get_db_driver eq 'SQLite';
    return "FROM_UNIXTIME($col/$interval,'%Y-%m-%d %H:%i:%s')"                                 if $sf->get_db_driver =~ /^(?:mysql|MariaDB)\z/;        # mysql: FROM_UNIXTIME doesn't work with negative timestamps
    return "TO_TIMESTAMP(${col}::bigint/$interval)::timestamp"                                 if $sf->get_db_driver eq 'Pg';
    return "DATEADD(CAST($col AS BIGINT)/$interval SECOND TO TIMESTAMP '1970-01-01 00:00:00')" if $sf->get_db_driver eq 'Firebird';
}


sub replace {
    my ( $sf, $col, $string_to_replace, $replacement_string ) = @_;
    return "REPLACE($col,$string_to_replace,$replacement_string)";
}




1;


__END__

=pod

=encoding UTF-8

=head1 NAME

App::DBBrowser::DB - Database plugin documentation.

=head1 VERSION

Version 2.303

=head1 DESCRIPTION

A database plugin provides the database specific methods. C<App::DBBrowser> considers a module whose name matches
C</^App::DBBrowser::DB::[^:']+\z/> and which is located in one of the C<@INC> directories as a database plugin.

The user can add an installed database plugin to the available plugins in the options menu (C<db-browser -h>) by
selecting I<DB Options> and then I<DB Plugins>.

A suitable database plugin provides the methods named in this documentation.

=head1 METHODS

=head2 Required methods

=head3 new( $info, $opt )

The constructor method.

When C<db-browser> calls the plugin constructor it passes tow arguments:

    sub new {
        my ( $class, $info, $opt ) = @_;
        my $self = {
            info => $info,
            opt  => $opt
        };
        return bless $self, $class;
    }

    # $info->{app_dir}        -> path to the configuration directoriy of the app
    # $info->{search}         -> true if C<db-browser> was called with the argument C<-s|--search>
    # $opt->{G}{metadata}     -> Options/Sql/System data

Returns the created object.

=head3 get_db_driver()

Returns the name of the C<DBI> database driver used by the plugin.

=head3 get_databases();

Returns two array references: the first reference refers to the array of user-databases the second refers to the array
of system-databases. The second array reference is optional.

If the option I<System data> is true, user-databases and system-databases are used else only the user-databases are
used.

=head3 get_db_handle( $database )

Returns the database handle.

C<db-browser> expects a C<DBI> database handle with the attribute I<RaiseError> enabled.

=head2 Optional methods

=head4 get_schemas( $dbh, $database )

C<$dbh> is the database handle returned by the method C<db_hanlde>.

Returns the user-schemas as an array-reference and the system-schemas as an array-reference (if any).

If the option I<metadata> is true, user-schemas and system-schemas are used else only the user-schemas are used.

=begin comment

=head3 DB configuration methods

If the following methods are available, the C<db-brower> user can configure the different database settings in the
options menu.

If the database driver is C<SQLite>, only C<set_attributes> is used.

=head4 read_login_data()

Returns a reference to an array of hashes. The hashes have one or two key-value pairs:

    { name => 'string', secret => true/false }

C<name> holds the field name for example like "user" or "host".

If C<secret> is true, the user input should not be echoed to the terminal. Also the data is not stored in the plugin
configuration file if C<secret> is true.

An example C<read_login_data> method:

    sub read_login_data {
        my ( $self ) = @_;
        return [
            { name => 'host', secret => 0 },
            { name => 'port', secret => 0 },
            { name => 'user', secret => 0 },
            { name => 'pass', secret => 1 },
        ];
    }

The information returned by the method C<read_login_data> is used to build the I<DB Settings> menu entry I<Fields> and
I<Login Data>.

=head4 env_variables()

Returns a reference to an array of environment variables.

An example C<env_variables> method:

    sub env_variables {
        my ( $self ) = @_;
        return [ qw( DBI_DSN DBI_HOST DBI_PORT DBI_USER DBI_PASS ) ];
    }

See the option I<ENV Variables> in I<DB Settings>.

=head4 set_attributes()

Returns a reference to an array of hashes. The hashes have two or three key-value pairs:

    { name => 'string', default => index, values => [ value_1, value_2, value_3, ... ] }

The value of C<name> is the name of the database connection attribute.

C<values> holds the available values for that attribute as an array reference.

The C<values> array entry of the index position C<default> is used as the default value.

Example from the plugin C<App::DBBrowser::DB::SQLite>:

    sub set_attributes {
        my ( $self ) = @_;
        return [
            { name => 'sqlite_unicode',             default => 1, values => [ 0, 1 ] },
            { name => 'sqlite_see_if_its_a_number', default => 1, values => [ 0, 1 ] },
        ];
    }

The information returned by the method C<set_attributes> is used to build the menu entry I<Set Attributes> in
L<db-browser/OPTIONS>.

=head4 read_attributes()

Returns a reference to an array of hashes. The hashes have one to two key-value pairs:

    { name => 'string', prompt => 'string' }

The value of C<name> is the name of the database connection attribute.

The value of C<default> is used as the default value. The C<default> entry is optional.

Example from the plugin C<App::DBBrowser::DB::Firebird>:

    sub read_attributes {
        my ( $sf ) = @_;
        return [
            { name => 'ib_dialect',                   },
            { name => 'ib_role',                      },
            { name => 'ib_charset', default => 'UTF8' },
        ];
    }

The information returned by the method C<read_attributes> is used to build the menu entry I<Read Attributes> in
L<db-browser/OPTIONS>.

The I<DB Options> can be accessd with the module C<App::DBBrowser::Opt::DBGet> as shown here in an example
for a C<mysql> database:

    use App::DBBrowser::Opt::DBGet;

    my $db_opt_get = App::DBBrowser::Opt::DBGet->new( $info, $opt );

    my $login_data  = $db_opt_get->login_data( $db );
    my $env_var_yes = $db_opt_get->enabled_env_vars( $db );
    my $attributes  = $db_opt_get->attributes( $db );

If C<$db> is defined, the settings for C<$db> are returned else the global plugin settings are returned.

The available C<$login_data> keys are the result of the I<Fields>* settings, the C<name> values are the result of the
I<Login Data>* settings:

    $login_data:
    {
        host => { name => 'localhost', secret => 0 },
        user => { name => 'user_name', secret => 0 },
        pass => { name => undef,       secret => 1 },
    }


The result of the I<ENV Variables>* settings:

    $env_var_yes:
    {
        DBI_DSN  => 0,
        DBI_HOST => 1,
        DBI_PORT => 1,
        DBI_USER => 0,
        DBI_PASS => 0,
    }

The result of the I<Attributes>* settings:

    $attributes:
    {
        mysql_enable_utf8        => 0,
        mysql_enable_utf8mb4     => 1,
        mysql_bind_type_guessing => 1,
    }

* OPTIONS/DB Options/DB Settings/$plugin

=end comment

=head1 EXAMPLE

    package App::DBBrowser::DB::MyPlugin;
    use strict;
    use DBI;

    sub new {
        my ( $class ) = @_;
        return bless {}, $class;
    }

    sub get_db_driver {
        my ( $self ) = @_;
        return 'Pg';
    }

    sub get_db_handle {
        my ( $self, $db ) = @_;
        my $dbh = DBI->connect( "DBI:Pg:dbname=$db", 'user', 'password', {
            RaiseError => 1,
            PrintError => 0,
        }) or die $DBI::errstr;
        return $dbh;
    }

    sub get_databases {
        my ( $self ) = @_;
        return [ 'My_DB_1', 'My_DB_2' ];
    }

    1;

=head1 AUTHOR

Matthäus Kiem <cuer2s@gmail.com>

=head1 LICENSE AND COPYRIGHT

Copyright 2012-2022 Matthäus Kiem.

THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE
IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl 5.10.0. For
details, see the full text of the licenses in the file LICENSE.

=cut
