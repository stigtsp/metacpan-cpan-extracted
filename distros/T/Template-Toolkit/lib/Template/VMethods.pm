#============================================================= -*-Perl-*-
#
# Template::VMethods
#
# DESCRIPTION
#   Module defining virtual methods for the Template Toolkit
#
# AUTHOR
#   Andy Wardley   <abw@wardley.org>
#
# COPYRIGHT
#   Copyright (C) 1996-2015 Andy Wardley.  All Rights Reserved.
#
#   This module is free software; you can redistribute it and/or
#   modify it under the same terms as Perl itself.
#
# REVISION
#   $Id$
#
#============================================================================

package Template::VMethods;

use strict;
use warnings;
use Scalar::Util qw( blessed looks_like_number );
use Template::Filters;

our $VERSION = '3.100';
our $DEBUG   = 0 unless defined $DEBUG;

our $ROOT_VMETHODS = {
    inc     => \&root_inc,
    dec     => \&root_dec,
};

our $TEXT_VMETHODS = {
    item        => \&text_item,
    list        => \&text_list,
    hash        => \&text_hash,
    length      => \&text_length,
    size        => \&text_size,
    empty       => \&text_empty,
    defined     => \&text_defined,
    upper       => \&text_upper,
    lower       => \&text_lower,
    ucfirst     => \&text_ucfirst,
    lcfirst     => \&text_lcfirst,
    match       => \&text_match,
    search      => \&text_search,
    repeat      => \&text_repeat,
    replace     => \&text_replace,
    remove      => \&text_remove,
    split       => \&text_split,
    chunk       => \&text_chunk,
    substr      => \&text_substr,
    trim        => \&text_trim,
    collapse    => \&text_collapse,
    squote      => \&text_squote,
    dquote      => \&text_dquote,
    html        => \&Template::Filters::html_filter,
    xml         => \&Template::Filters::xml_filter,
};

our $HASH_VMETHODS = {
    item    => \&hash_item,
    hash    => \&hash_hash,
    size    => \&hash_size,
    empty   => \&hash_empty,
    each    => \&hash_each,
    keys    => \&hash_keys,
    values  => \&hash_values,
    items   => \&hash_items,
    pairs   => \&hash_pairs,
    list    => \&hash_list,
    exists  => \&hash_exists,
    defined => \&hash_defined,
    delete  => \&hash_delete,
    import  => \&hash_import,
    sort    => \&hash_sort,
    nsort   => \&hash_nsort,
};

our $LIST_VMETHODS = {
    item    => \&list_item,
    list    => \&list_list,
    hash    => \&list_hash,
    push    => \&list_push,
    pop     => \&list_pop,
    unshift => \&list_unshift,
    shift   => \&list_shift,
    max     => \&list_max,
    size    => \&list_size,
    empty   => \&list_empty,
    defined => \&list_defined,
    first   => \&list_first,
    last    => \&list_last,
    reverse => \&list_reverse,
    grep    => \&list_grep,
    join    => \&list_join,
    sort    => \&list_sort,
    nsort   => \&list_nsort,
    unique  => \&list_unique,
    import  => \&list_import,
    merge   => \&list_merge,
    slice   => \&list_slice,
    splice  => \&list_splice,
};

# Template::Stash needs the above, so defer loading this module
# until they are defined.
require Template::Stash;
our $PRIVATE = $Template::Stash::PRIVATE;

#========================================================================
# root virtual methods
#========================================================================

sub root_inc {
    no warnings;
    my $item = shift;
    ++$item;
}

sub root_dec {
    no warnings;
    my $item = shift;
    --$item;
}


#========================================================================
# text virtual methods
#========================================================================

sub text_item {
    $_[0];
}

sub text_list {
    [ $_[0] ];
}

sub text_hash {
    { value => $_[0] };
}

sub text_length {
    length $_[0];
}

sub text_size {
    return 1;
}

sub text_empty {
    return 0 == text_length($_[0]) ? 1 : 0;
}

sub text_defined {
    return 1;
}

sub text_upper {
    return uc $_[0];
}

sub text_lower {
    return lc $_[0];
}

sub text_ucfirst {
    return ucfirst $_[0];
}

sub text_lcfirst {
    return lcfirst $_[0];
}

sub text_trim {
    for ($_[0]) {
        s/^\s+//;
        s/\s+$//;
    }
    return $_[0];
}

sub text_collapse {
    for ($_[0]) {
        s/^\s+//;
        s/\s+$//;
        s/\s+/ /g
    }
    return $_[0];
}

sub text_match {
    my ($str, $search, $global) = @_;
    return $str unless defined $str and defined $search;
    my @matches = $global ? ($str =~ /$search/g)
        : ($str =~ /$search/);
    return @matches ? \@matches : '';
}

sub text_search {
    my ($str, $pattern) = @_;
    return $str unless defined $str and defined $pattern;
    return $str =~ /$pattern/;
}

sub text_repeat {
    my ($str, $count) = @_;
    $str = '' unless defined $str;
    return '' unless $count;
    $count ||= 1;
    return $str x $count;
}

sub text_replace {
    my ($text, $pattern, $replace, $global) = @_;
    $text    = '' unless defined $text;
    $pattern = '' unless defined $pattern;
    $replace = '' unless defined $replace;
    $global  = 1  unless defined $global;

    if ($replace =~ /\$\d+/) {
        # replacement string may contain backrefs
        my $expand = sub {
            my ($chunk, $start, $end) = @_;
            $chunk =~ s{ \\(\\|\$) | \$ (\d+) }{
                $1 ? $1
                    : ($2 > $#$start || $2 == 0 || !defined $start->[$2]) ? ''
                    : substr($text, $start->[$2], $end->[$2] - $start->[$2]);
            }exg;
            $chunk;
        };
        if ($global) {
            $text =~ s{$pattern}{ &$expand($replace, [@-], [@+]) }eg;
        }
        else {
            $text =~ s{$pattern}{ &$expand($replace, [@-], [@+]) }e;
        }
    }
    else {
        if ($global) {
            $text =~ s/$pattern/$replace/g;
        }
        else {
            $text =~ s/$pattern/$replace/;
        }
    }
    return $text;
}

sub text_remove {
    my ($str, $search) = @_;
    return $str unless defined $str and defined $search;
    $str =~ s/$search//g;
    return $str;
}

sub text_split {
    my ($str, $split, $limit) = @_;
    $str = '' unless defined $str;

    # For versions of Perl prior to 5.18 we have to be very careful about
    # spelling out each possible combination of arguments because split()
    # is very sensitive to them, for example C<split(' ', ...)> behaves
    # differently to C<$space=' '; split($space, ...)>.  Test 33 of 
    # vmethods/text.t depends on this behaviour.

    if ($] < 5.018) {
        if (defined $limit) {
            return [ defined $split
                     ? split($split, $str, $limit)
                     : split(' ', $str, $limit) ];
        }
        else {
            return [ defined $split
                     ? split($split, $str)
                     : split(' ', $str) ];
        }
    }

    # split's behavior changed in Perl 5.18.0 making this:
    # C<$space=' '; split($space, ...)>
    # behave the same as this:
    # C<split(' ', ...)>
    # qr// behaves the same, so use that for user-defined split.

    my $split_re;
    if (defined $split) {
        eval {
            $split_re = qr/$split/;
        };
    }
    $split_re = ' ' unless defined $split_re;
    $limit ||= 0;
    return [split($split_re, $str, $limit)];
}

sub text_chunk {
    my ($string, $size) = @_;
    my @list;
    $size ||= 1;
    if ($size < 0) {
        # sexeger!  It's faster to reverse the string, search
        # it from the front and then reverse the output than to
        # search it from the end, believe it nor not!
        $string = reverse $string;
        $size = -$size;
        unshift(@list, scalar reverse $1)
            while ($string =~ /((.{$size})|(.+))/g);
    }
    else {
        push(@list, $1) while ($string =~ /((.{$size})|(.+))/g);
    }
    return \@list;
}

sub text_substr {
    my ($text, $offset, $length, $replacement) = @_;
    $offset ||= 0;

    if(defined $length) {
        if (defined $replacement) {
            substr( $text, $offset, $length, $replacement );
            return $text;
        }
        else {
            return substr( $text, $offset, $length );
        }
    }
    else {
        return substr( $text, $offset );
    }
}

sub text_squote {
    my $text = shift;
    for ($text) {
        s/(['\\])/\\$1/g;
    }
    return $text;
}

sub text_dquote {
    my $text = shift;
    for ($text) {
        s/(["\\])/\\$1/g;
        s/\n/\\n/g;
    }
    return $text;
}

#========================================================================
# hash virtual methods
#========================================================================


sub hash_item {
    my ($hash, $item) = @_;
    $item = '' unless defined $item;
    return if $PRIVATE && $item =~ /$PRIVATE/;
    $hash->{ $item };
}

sub hash_hash {
    $_[0];
}

sub hash_size {
    scalar keys %{$_[0]};
}

sub hash_empty {
    return 0 == hash_size($_[0]) ? 1 : 0;
}

sub hash_each {
    # this will be changed in TT3 to do what hash_pairs() does
    [ %{ $_[0] } ];
}

sub hash_keys {
    [ keys   %{ $_[0] } ];
}

sub hash_values {
    [ values %{ $_[0] } ];
}

sub hash_items {
    [ %{ $_[0] } ];
}

sub hash_pairs {
    [ map {
        { key => $_ , value => $_[0]->{ $_ } }
      }
      sort keys %{ $_[0] }
    ];
}

sub hash_list {
    my ($hash, $what) = @_;
    $what ||= '';
    return ($what eq 'keys')   ? [   keys %$hash ]
        :  ($what eq 'values') ? [ values %$hash ]
        :  ($what eq 'each')   ? [        %$hash ]
        :  # for now we do what pairs does but this will be changed
           # in TT3 to return [ $hash ] by default
        [ map { { key => $_ , value => $hash->{ $_ } } }
          sort keys %$hash
          ];
}

sub hash_exists {
    exists $_[0]->{ $_[1] };
}

sub hash_defined {
    # return the item requested, or 1 if no argument
    # to indicate that the hash itself is defined
    my $hash = shift;
    return @_ ? defined $hash->{ $_[0] } : 1;
}

sub hash_delete {
    my $hash = shift;
    delete $hash->{ $_ } for @_;
}

sub hash_import {
    my ($hash, $imp) = @_;
    $imp = {} unless ref $imp eq 'HASH';
    @$hash{ keys %$imp } = values %$imp;
    return '';
}

sub hash_sort {
    my ($hash) = @_;
    [ sort { lc $hash->{$a} cmp lc $hash->{$b} } (keys %$hash) ];
}

sub hash_nsort {
    my ($hash) = @_;
    [ sort { $hash->{$a} <=> $hash->{$b} } (keys %$hash) ];
}


#========================================================================
# list virtual methods
#========================================================================


sub list_item {
    $_[0]->[ $_[1] || 0 ];
}

sub list_list {
    $_[0];
}

sub list_hash {
    my $list = shift;
    if (@_) {
        my $n = shift || 0;
        return { map { ($n++, $_) } @$list };
    }
    no warnings;
    return { @$list };
}

sub list_push {
    my $list = shift;
    push(@$list, @_);
    return '';
}

sub list_pop {
    my $list = shift;
    pop(@$list);
}

sub list_unshift {
    my $list = shift;
    unshift(@$list, @_);
    return '';
}

sub list_shift {
    my $list = shift;
    shift(@$list);
}

sub list_max {
    no warnings;
    my $list = shift;
    $#$list;
}

sub list_size {
    no warnings;
    my $list = shift;
    $#$list + 1;
}

sub list_empty {
    return 0 == list_size($_[0]) ? 1 : 0;
}

sub list_defined {
    # return the item requested, or 1 if no argument to
    # indicate that the hash itself is defined
    my $list = shift;
    return 1 unless @_;                     # list.defined is always true
    return unless looks_like_number $_[0];  # list.defined('bah') is always false
    return defined $list->[$_[0]];          # list.defined(n)
}

sub list_first {
    my $list = shift;
    return $list->[0] unless @_;
    return [ @$list[0..$_[0]-1] ];
}

sub list_last {
    my $list = shift;
    return $list->[-1] unless @_;
    return [ @$list[-$_[0]..-1] ];
}

sub list_reverse {
    my $list = shift;
    [ reverse @$list ];
}

sub list_grep {
    my ($list, $pattern) = @_;
    $pattern ||= '';
    return [ grep /$pattern/, @$list ];
}

sub list_join {
    my ($list, $joint) = @_;
    join(defined $joint ? $joint : ' ',
         map { defined $_ ? $_ : '' } @$list);
}

sub _list_sort_make_key {
   my ($item, $fields) = @_;
   my @keys;

   if (ref($item) eq 'HASH') {
       @keys = map { $item->{ $_ } } @$fields;
   }
   elsif (blessed $item) {
       @keys = map { $item->can($_) ? $item->$_() : $item } @$fields;
   }
   else {
       @keys = $item;
   }

   # ugly hack to generate a single string using a delimiter that is
   # unlikely (but not impossible) to be found in the wild.
   return lc join('/*^UNLIKELY^*/', map { defined $_ ? $_ : '' } @keys);
}

sub list_sort {
    my ($list, @fields) = @_;
    return $list unless @$list > 1;         # no need to sort 1 item lists
    return [
        @fields                          # Schwartzian Transform
        ?   map  { $_->[0] }                # for case insensitivity
            sort { $a->[1] cmp $b->[1] }
            map  { [ $_, _list_sort_make_key($_, \@fields) ] }
            @$list
        :  map  { $_->[0] }
           sort { $a->[1] cmp $b->[1] }
           map  { [ $_, lc $_ ] }
           @$list,
    ];
}

sub list_nsort {
    my ($list, @fields) = @_;
    return $list unless @$list > 1;     # no need to sort 1 item lists

    my $sort = sub {
        my $cmp;

        if(@fields) {
            # compare each field individually
            for my $field (@fields) {
                my $A = _list_sort_make_key($a, [ $field ]);
                my $B = _list_sort_make_key($b, [ $field ]);
                ($cmp = $A <=> $B) and last;
            }
        }
        else {
            my $A = _list_sort_make_key($a);
            my $B = _list_sort_make_key($b);
            $cmp = $A <=> $B;
        }

        $cmp;
    };

    return [ sort $sort @{ $list } ];
}

sub list_unique {
    my %u;
    [ grep { ++$u{$_} == 1 } @{$_[0]} ];
}

sub list_import {
    my $list = shift;
    push(@$list, grep defined, map ref eq 'ARRAY' ? @$_ : undef, @_);
    return $list;
}

sub list_merge {
    my $list = shift;
    return [ @$list, grep defined, map ref eq 'ARRAY' ? @$_ : undef, @_ ];
}

sub list_slice {
    my ($list, $from, $to) = @_;
    $from ||= 0;
    $to    = $#$list unless defined $to;
    $from += @$list if $from < 0;
    $to   += @$list if $to   < 0;
    return [ @$list[$from..$to] ];
}

sub list_splice {
    my ($list, $offset, $length, @replace) = @_;
    if (@replace) {
        # @replace can contain a list of multiple replace items, or
        # be a single reference to a list
        @replace = @{ $replace[0] }
        if @replace == 1 && ref $replace[0] eq 'ARRAY';
        return [ splice @$list, $offset, $length, @replace ];
    }
    elsif (defined $length) {
        return [ splice @$list, $offset, $length ];
    }
    elsif (defined $offset) {
        return [ splice @$list, $offset ];
    }
    else {
        return [ splice(@$list) ];
    }
}

1;

__END__

=head1 NAME

Template::VMethods - Virtual methods for variables

=head1 DESCRIPTION

The C<Template::VMethods> module implements the virtual methods
that can be applied to variables.

Please see L<Template::Manual::VMethods> for further information.

=head1 AUTHOR

Andy Wardley E<lt>abw@wardley.orgE<gt> L<http://wardley.org/>

=head1 COPYRIGHT

Copyright (C) 1996-2007 Andy Wardley.  All Rights Reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<Template::Stash>, L<Template::Manual::VMethods>

=cut

# Local Variables:
# mode: perl
# perl-indent-level: 4
# indent-tabs-mode: nil
# End:
#
# vim: expandtab shiftwidth=4:
