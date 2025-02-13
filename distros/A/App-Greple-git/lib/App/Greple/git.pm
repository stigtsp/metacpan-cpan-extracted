package App::Greple::git;

our $VERSION = "0.02";

1;

=encoding utf-8

=head1 NAME

git - Greple git module

=head1 SYNOPSIS

    greple -Mgit ...

=head1 DESCRIPTION

App::Greple::git is a greple module to handle git output.

=head1 OPTIONS

=over 7

=item B<--color-blame-line>, B<--color-blame>

=item B<--color-blame-label>

Read L<git-blame(1)> output and apply unique color for each commit
ids.  Option B<--color-blame> and B<--color-blame-line> colorize whole
line, while B<--color-blame-label> does only labels.

Set F<$HOME/.gitconfig> like this:

    [pager]
	blame = greple -Mgit --color-blame-line | env LESSANSIENDCHARS=mK less -cR

=begin html

<p><img width="75%" src="https://raw.githubusercontent.com/kaz-utashiro/greple-git/main/images/git-blame-small.jpg">

=end html

=begin html

<p><img width="75%" src="https://raw.githubusercontent.com/kaz-utashiro/greple-git/main/images/git-blame-label-small.jpg">

=end html

=back

=head1 ENVIRONMENT

=over 7

=item B<LESS>

=item B<LESSANSIENDCHARS>

Since B<greple> produces ANSI Erase Line terminal sequence, it is
convenient to set B<less> command understand them.

    LESS=-cR
    LESSANSIENDCHARS=mK

=back

=head1 INSTALL

=head2 CPANMINUS

    $ cpanm App::Greple::git

=head1 SEE ALSO

L<App::Greple>

L<App::sdif>: git diff support

=head1 AUTHOR

Kazumasa Utashiro

=head1 LICENSE

Copyright 2021-2022 Kazumasa Utashiro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__DATA__

define :ID:      [0-9a-f^][0-9a-f]{7,39}
define :LINE:    ^:ID:\b.+
define :LABEL:   ^:ID:\b.+?\d\)
define :UNIQSUB: sub{s/\s.*//r}

option --color-blame --color-blame-line

option --color-blame-line \
	--all --uniqcolor --uniqsub :UNIQSUB: \
	--re :LINE: --face +E-D

option --color-blame-label \
	--all --uniqcolor --uniqsub :UNIQSUB: \
	--re :LABEL: --face -D
