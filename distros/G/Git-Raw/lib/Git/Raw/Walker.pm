package Git::Raw::Walker;
$Git::Raw::Walker::VERSION = '0.88';
use strict;
use warnings;

use Git::Raw;

=head1 NAME

Git::Raw::Walker - Git revwalker class

=head1 VERSION

version 0.88

=head1 SYNOPSIS

    use Git::Raw;

    # open the Git repository at $path
    my $repo = Git::Raw::Repository -> open($path);

    # create a new walker
    my $log  = $repo -> walker;

    # push the head of the repository
    $log -> push_head;

    # print all commit messages
    while (my $commit = $log -> next) {
      say $commit -> message;
    }

=head1 DESCRIPTION

A L<Git::Raw::Walker> represents a graph walker used to walk through the
repository's revisions (sort of like C<git log>).

B<WARNING>: The API of this module is unstable and may change without warning
(any change will be appropriately documented in the changelog).

=head1 METHODS

=head2 create( $repo )

Create a new revision walker.

=head2 sorting( \@order )

Change the sorting mode when iterating through the repository's contents.
Values for C<@order> may be one or more of the following:

=over 4

=item * "none"

Sort the repository contents in no particular ordering, that is, sorting is
arbitrary, implementation-specific and subject to change at any time. (Default)

=item * "topological"

Sort the repository contents in topological order (parents before children).
This sorting mode may be combined with time sorting.

=item * "time"

Sort the repository contents by commit time. This sorting mode may be combined
with topological sorting.

=item * "reverse"

Iterate through the repository contents in reverse order. This sorting mode may
be combined with any of the above.

=back

=head2 push( $commit )

Push a L<Git::Raw::Commit> to the list of commits to be used as roots when
starting a revision walk.

=head2 push_glob( $glob )

Push references by C<$glob> to the list of commits to be used as roots when
starting a revision walk.

=head2 push_ref( $name )

Push a reference by C<$name> to the list of commits to be used as roots when
starting a revision walk.

=head2 push_head( )

Push HEAD of the repository to the list of commits to be used as roots when
starting a revision walk.

=head2 push_range( $start, $end )

Push and hide the respective endpoints of the given range. C<$start> and C<$end>
should be C<"commitish">, that is, it should be a L<Git::Raw::Commit> or
L<Git::Raw::Reference> object, or alternatively a commit id or commit id prefix.

=head2 push_range( $range )

Push and hide the respective endpoints of the given range. C<$range> should be
of the form C<"start_commit_id..end_commit_id">.

=head2 hide( $commit )

Hide a L<Git::Raw::Commit> and its ancestors from the walker.

=head2 hide_glob( $glob )

Hide references by C<$glob> and all ancestors from the walker.

=head2 hide_ref( $name )

Hide a reference by C<$name> and its ancestors from the walker.

=head2 hide_head( )

Hide HEAD of the repository and its ancestors from the walker.

=head2 next( )

Retrieve the next commit from the revision walk. Returns a L<Git::Raw::Commit>
object or C<undef> if there are no commits.

=head2 all( )

Retrieve all commits. Returns a list of L<Git::Raw::Commit> objects.

=head2 reset( )

Reset the revision walker (this is done automatically at the end of a walk).

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Git::Raw::Walker
