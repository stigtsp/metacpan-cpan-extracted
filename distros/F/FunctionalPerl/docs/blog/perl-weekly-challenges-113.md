Check the [functional-perl website](http://functional-perl.org/) for
properly formatted versions of these documents.

---

# The Perl Weekly Challenges, #113

<small><i>[Christian J.](mailto:ch@christianjaeger.ch), 23 May 2021</i></small>

I've started solving [The Perl Weekly
Challenges](https://perlweeklychallenge.org/), and of course my main
attention is on seeing how FunctionalPerl fits. Sometimes a functional
approach will be a clear match (or so I think), sometimes solutions
without FunctionalPerl will be just as good and I won't contest it,
sometimes I won't see how it's going to be useful and I might end up
just using the repl and some bits during developments but not in the
final solutions, sometimes I might be using FunctionalPerl just
because I can. I'll probably skip tasks if I don't find they could
enlighten me or others in any way about how FunctionalPerl would fit
or not fit, and of course sometimes I won't have time.

Since I'm the author of `FunctionalPerl` and it's not widely used yet,
my main task in this blog will have to be to explain the bits of the
`FunctionalPerl` libraries that I'm using in my solutions, too.

I actually already solved one task from [The Weekly Challenge -
111](https://perlweeklychallenge.org/blog/perl-weekly-challenge-111/),
[111-1-search_matrix](../../examples/perl-weekly-challenges/111-1-search_matrix),
but didn't submit it. It led me to create a new module
`FP::SortedPureArray`, which represents an array sorted according to
some comparison function, and offers a method for a binary search that
was what that challenge required (for efficiency with large matrices,
anyway).

On to [the new tasks](https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/).

<with_toc>

## Task #2: Recreate Binary Tree

I solved this task first, so I'm going to write about it first,
too. The task description is
[here](https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2),
my solution is
[here](../../examples/perl-weekly-challenges/113-2-recreate_binary_tree). I'll
show the important pieces of the script below, but here you can see
the full context.

Trees and functional progamming are a good match, if the trees don't
have circular links. In that case the nodes can be pure data
structures, i.e. not allow mutation and instead return new nodes for
changes, which leaves the remainder of the tree intact, which is what
functional programming requires. Often trees in the imperative world
have links back to the parents, i.e. cycles, which aren't a problem in
Perl if weakening or destructors are used correctly, but which violate
the purely functional approach—how would you re-use the child nodes
if you create a new modified parent, but the children are still
pointing to the unmodified parent? But algorithms that need access to
the parent nodes can instead maintain linked lists to the parents
while diving down the tree, thus parent links aren't actually
necessary. Anyway, this task is very simple, none of this parent
business applies.

        use FP::Predicates qw(is_string maybe instance_of);
        *is_maybe_Node = maybe instance_of("PFLANZE::Node");

        use FP::Struct [
            [\&is_maybe_Node, "left"],
            [\&is_string,     "value"],
            [\&is_maybe_Node, "right"]
        ] => ("FP::Struct::Show", "FP::Struct::Equal");

I'm using `FP::Struct` as for all of my current functional code—I'm
still improving and gaining experience with it and it's too early for
me to know whether or how to introduce the features I want into
`Moose` or something similar. I like its simplicity, but obviously I'm
very biased. It simply takes an array of field definitions, each of
which can either be a string (the field name), or an array of
`[\&predicate, "fieldname"]`, where the predicate is a function that
must return true for the value that is being stored in field
`fieldname` (otherwise `FP::Struct`'s constructor and setters will
throw an exception). 

After the field definitions come parent classes; `FP::Struct::Show`
automatically implements the `show` function from `FP::Show`, which
shows Perl code that creates the data in question, which is useful at
the repl (from `FP::Repl`) during development; `FP::Struct::Equal`
implements the `equal` function from `FP::Equal`, which is used in the
tests.

You might be asking why I'm not using `overload` for these: for `show`
my answer is that it is stringification for debugging, not for the
general case. Say you've got a class `Path` representing a file system
path, you construct it via `Path("/foo/bar")` (`Path` is a constructor
function here, as I'm about to explain), and you want that path be
stringified to `"/foo/bar"` so you can transparently use it in Perl's
`open` or whatever. Now the repl wants to show you `Path("/foo/bar")`,
as that is what constructs such an object, and not `"/foo/bar"`, as
the latter would evaluate to a plain string and not be semantically
correct.

With regards to `equal`, one answer is that I'm gaining experience to
see. Partial other answers could be that Perl has just numeric and
string comparison to overload, and numeric comparison doesn't apply in
general and string comparison is going to be suffering from the same
issue as above.

        _END_

This concludes the class (constructs any missing accessor methods
etc.), and could potentially be made automatic, but as I said,
`FP::Struct` is experimental anyway at this point, so I don't care.

    PFLANZE::Node::constructors->import;

This imports the `Node` and `Node_` functions, which are nicer to use
and read constructors for the class. Functional languages generally
follow a convention of using uppercase initials for type names, and
lowercase initials for everything else, which makes it unambiguous
what constructs values. It's also nice to have `Node` as a function
instead of having to write `new Node` since the former can be passed
as a reference easily, as in something like `->map(\&Node)` (as can be
seen further down in the script, and yes, the `map` here passes 3
arguments to the function, and should probably be named something
else).

The algorithm is simple in that from each node's value, the sum of all
nodes' values has to be subtracted. Thus first walk over the tree
building the sum, then walk agan to create the nodes with the new
values. I've added a method `map` to the `Node` class (really
`PFLANZE::Node`, but I'm shortening it in my talking to the last
package name segment, like the constructor names do), which takes a
function that will be passed the `left` and `right` nodes already
mapped, and the old `value`:

        sub map ($self, $fn) {
            my $l  = $self->left;
            my $r  = $self->right;
            my $l2 = defined($l) ? $l->map($fn) : undef;
            my $r2 = defined($r) ? $r->map($fn) : undef;
            $fn->($l2, $self->value, $r2)
        }

This method should probably get a different name, like `fold`, I
haven't found the time yet to see what the commonly used naming
is. Summing and recreating can then both use this method.

    my $in = Node(Node(Node(undef, 4, Node(undef, 7, undef)), 2, undef),
        1, Node(Node(undef, 5, undef), 3, Node(undef, 6, undef)));

This constructs our input tree. The formatting of this code could be
better, but that's what `perltidy` gives me with the best set of
configurations that I could figure out.

    TEST { equal $in, $in->map(\&Node) } 1;

`TEST` is from `Chj::TEST`. The invention here is that I put tests
into the same file as the implementation, and they will still only be
run when running `run_tests` (and optionally aren't even kept in
memory). It also imples a comparison, `TEST { $expr } $result` is
pretty much (except for reporting the values for $expr and $results if
they don't match) the same as `ok equal($expr, $result)` put into a
separate file with `Test::More` loaded.

This particular test checks that the map method, when simply passed
the constructor, recreates the identical tree.

I've implemented the summing and recreating as functions instead of
putting them into the `Node` class as methods, since they are pretty
specific to this task, whereas the `Node` class could potentially grow
into a generic binary tree library.

    sub tree_sum($t) {
        $t->map(
            sub ($l, $value, $r) {
                $value + ($l // 0) + ($r // 0)
            }
        )
    }

    TEST { tree_sum $in } 28;

The Node `map` method passes `undef` for the `$l` and `$r` arguments
if there's no node in the respective position, that's how I can use
`// 0` to get the sum for empty subtrees.

    sub tree_recreate($t) {
        my $sum = tree_sum($t);
        $t->map(
            sub ($l, $value, $r) {
                Node($l, $sum - $value, $r)
            }
        )
    }

    TEST { tree_recreate $in }
    Node(Node(Node(undef, 24, Node(undef, 21, undef)), 26, undef),
        27, Node(Node(undef, 23, undef), 25, Node(undef, 22, undef)));

And there is the result as requested by the task. One could write a
formatter method that would print the ASCII representation as used in
the task description, but I'm off to other work.


## Task #1: Represent Integer

The task description is
[here](https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK1),
my solution is
[here](../../examples/perl-weekly-challenges/113-1-represent_integer).

> You are given a positive integer $N and a digit $D.

> Write a script to check if $N can be represented as a sum of positive
> integers [all] having $D at least once [in their decimal
> representation]. If check passes print 1 otherwise 0.

The description is ambiguous about whether the same integer can be
used multiple times or not. For example, the number `200`, when `$D`
is `9`, can be represented by `9 + 191` but also by for example `29 +
9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 +
9 + 9`. It's not clear whether the latter solution is forbidden. My
solution assumes that it is allowed.

Is there some kind of mathematical insight that can be used here? Not
being a math geek, I don't know. So for me, at least for now, it's
going to be some kind of brute force search of combinations, while
potentially finding some smart decisions that can be taken to make it
less costly. To get ahead: I found that a somewhat smartly executed
brute force search is reasonably efficient, and larger numbers have an
increasing chance of satisfying the representable tests, so it might
be possible to simply return true if $N is larger than a particular
cut off, thus the cost may be bounded. Anyway, let's brute force.

First let's get the valid numbers:

    sub valid_numbers ($N, $D) {
        purearray grep {/$D/} (1 .. $N)
    }

Nothing unusual aside the `purearray` call; this is a constructor
function from `FP::PureArray` making a "pure array", which is just a
Perl array blessed to `FP::_::PureArray` and changed to
immutable. This gives me easy access to all the utility methods that
come from `FP::PureArray` and sequences (`FP::Abstract::Sequence`) in
general.

To make development easier, I wanted to see what solution that my
search returns. So instead of just a boolean (like `''` and `1`), it
returns either the chosen numbers that sum up to `$N`, or
`undef`. This is still usable in a boolean context in Perl. I'm using
`undef` over `''` or `0` for the false value as that is more
explicitly "not a result", and I'm following a convention of prefixing
the names of functions that return either some value or nothing with
`maybe_`. This convention should make it visually clear to other
programmers that they are not necessarily getting a result
back. Functional languages generally use a `Maybe` or `Optional` type
for representing this pattern, with e.g. a `Some` wrapper for values
and the `Nothing` in absence of a value, which is safer in that the
programmer explicitly has to deal with the potential non-existence of
a value, and in that they are wrappers, meaning they can nest. I
haven't been tempted enough to create such a type in `FunctionalPerl`
yet, If I do it will probably be called `FP::Maybe`. For now, the
[Hungarian notation](https://en.wikipedia.org/wiki/Hungarian_notation)
will have to suffice (and given existing Perl code there will always
be a need to deal with such cases, which is why the need for that
convention will never go away):

    sub maybe_representable ($N, $D, $prefer_large = 1) {
        __ 'Returns the numbers containing $D that sum up to $N, or undef.
            If $prefer_large is true, tries to use large numbers,
            otherwise small (which is (much) less efficient).';
        ...
    }

You may wonder what the `__` bit is there. It comes from
`FP::Docstring`. It's my (hacky, without requiring core interpreter
changes) way to attach documentation to subroutines in a way that it
can be retrieved at runtime, usually from the repl. It allows for more
convenience while coding. Example:

    $ ./113-1-represent_integer --repl
    main> docstring \&maybe_representable 
    $VAR1 = 'Returns the numbers containing $D that sum up to $N, or undef.
            If $prefer_large is true, tries to use large numbers,
            otherwise small (which is (much) less efficient).';
    main> 

Or simply have the repl show what the code ref represents:

    main> \&maybe_representable 
    $VAR1 = sub { 'DUMMY: main::maybe_representable at "./113-1-represent_integer" line 200'; __ 'Returns the numbers containing $D that sum up to $N, or undef.
            If $prefer_large is true, tries to use large numbers,
            otherwise small (which is (much) less efficient).' };
    main> 

The code at `...` above is:

        my $ns = valid_numbers($N, $D);
        my $maybe_choose
            = ($prefer_large and not $ENV{NO_OPTIM})
            ? \&maybe_choose_optim_2
            : \&maybe_choose_brute;
        $maybe_choose->($N, $prefer_large ? $ns->reverse : $ns)

I originally had a `maybe_choose` function, before I went on and
renamed that to `maybe_choose_brute` and added `maybe_choose_optim_1`
and then `maybe_choose_optim_2` as I got new ideas on how to improve
performance. The `maybe_representable` function above selects the
right function: explicitly passing false for `$prefer_large` (or
setting `NO_OPTIM=1`) will switch from the optimized variant to the
initial slow one, which finds a different solution. That's not
particularly interesting except to see how it works by looking at the
corresponding results in the tests (like the `list(29, 9, 9, 9, 9, 9,
9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9)` case I mentioned in the
beginning). The optimized variants require $ns to be sorted in
descending order, which is why `maybe_representable` reverses it in
that case.

On to my quest to find a good algorithm:

### Dumb approach

The dumb approach is to combine "any" valid numbers (numbers from
`$ns`) until we find a match (they sum up to $N). We don't know how
many numbers we'll need, though, so I figured I couldn't use the cross
product (cartesian product) of say two `$ns`. I've since realized that
one could of course first try the cross_product of two $ns, then if
that fails, three, etc., like:

    use FP::Stream qw(stream_cartesian_product)
    # stream_cartesian_product only works on `list` or `stream`,
    # so convert the purearray to list first:
    my $ns = $ns->list;
    check(stream_cartesian_product $ns, $ns)
    or check(stream_cartesian_product $ns, $ns, $ns)
    or check(stream_cartesian_product $ns, $ns, $ns, $ns)
    ...

But instead, I just basically hand coded a cartesian product that
automatically extends itself to additional levels until that level is
shown to be exhausted (finds no match):

    sub maybe_choose_brute ($N, $ns) {
        __ 'Choose a combination of numbers from $ns (repetitions allowed)
            that added together equal $N; undef if not possible. This
            solution is brute force in that it is picking additional
            numbers from the left end of $ns, one after another,
            depth-first.';

        sub ($chosen) {
            my $check = __SUB__;
            warn "check (brute): " . show($chosen) if $verbose;
            my $sum = $chosen->sum;
            if ($sum == $N) {
                $chosen
            } elsif ($sum > $N) {
                undef
            } else {
                $ns->any(
                    sub ($n) {
                        $check->(cons($n, $chosen))
                    }
                )
            }
            }
            ->(null)
    }

(I don't know why `perltidy` chooses not to put the `}` on the
third-last line 4 spaces further to the left, so that it would lign up
with the `sub ($chosen) {` line. Anyone knows how to improve this?
Please tell.)

#### `__SUB__`

You may not be familiar with `__SUB__` from `use feature
'current_sub'`—if you are, skip this section. 

This is the best way for a local function to get access to itself, so
that it can be self-recursive. Note that this wouldn't work as the sub
is evaluated in the context before `$check` is introduced and thus
wouldn't have access to it:

    my $check= sub ($chosen) { ... sub { .. $check .. } .. };
    $check->(null)

This would work but leads to a cycle and thus memory leak (which
could be remedied by using an additional variable and then `weaken`ing
the self-referential variable, but `__SUB__` is going to be faster and
less to write):

    my $check;
    $check= sub ($chosen) { ... sub { .. $check .. } .. };
    $check->(null)

Same problem with `my sub check ($chosen) { ... }`.

Also note that `__SUB__` *has* to be assigned to a lexical variable
(`$check`) here, as we're only using it inside *another* nested sub,
thus `__SUB__` in *there* would be that other sub instead.

(Maybe Perl should introduce something like this

    my rec $check = sub ($chosen) { ... };
    $check->(null)

but I haven't thought about it deeply.)

#### The algorithm

The idea is to check a set of chosen numbers: if their sum is equal to
`$N`, we have found the solution and simply return that set. If the
sum is larger than `$N`, then there is no point adding any additional
number, and we can return `undef` to signal that there is no solution
with those choices. If we haven't reached `$N` yet, we need to add
another number from `$ns` and check again. We do this for *all*
numbers from `$ns` until we find a match. That latter bit is being
carried out by the `any` method which is implemented for all types
implementing `FP::Abstract::Sequence`, which includes the purearray
that `$ns` is. Shown again here:

            $ns->any(
                sub ($n) {
                    $check->(cons($n, $chosen))
                }
            )

What `any` does is, it iterates through the object (`$ns` in this
case), passes each of the elements to the function that was passed to
the method (`sub ($n) { .. }` in this case), and if that function
returns a true value, returns that same value itself (i.e. stopping
the iteration). Examples:

    purearray(20, 30, 40)->any(sub($v) { $v == 30 }) # returns 1
    purearray(20, 30, 40)->any(sub($v) { $v == 31 }) # returns ''
    purearray(20, 30, 40)->any(sub($v) { $v == 30 and "y" }) # returns "y"

Our local `$check` function is returning `undef` if there is no
result, and the set of numbers making a successful search in the other
case. Thus `any` returns the same. Thus `maybe_choose_brute` returns
the same, which is what we want. (I should perhaps have used a better
name for `$check`, perhaps `$maybe_choose`, to maintain the Hungarian
notation locally, too.)

#### Linked lists

The remaining bit to explain here is `cons`: this is from `FP::List`
and constructs a new list by prepending `$n` to the existing list
`$chosen`. Unlike `push`ing or `unshift`ing to an array, which mutates
the array and is visible to all code that has a reference to it, this
doesn't mutate `$chosen`. Both the list before prepending `$n` and the
one after exist at the same time, which is important since if
`$check->(cons($n, $chosen))` fails to find a result, `any` will go on
and in the next attempt, `$chosen` must be the original list since we
want to prepend *another* `$n` to it. Also, `cons` is efficient (it is
`O(1)`) unlike copying whole arrays. `FP::List` implements singly
linked lists.

        ->(null)

This calls our local sub and passes it the empty list: `null` is the
equivalent of `[]` but for `FP::List`.

Just to be clear, both `FP::List` and `FP::PureArray` are
implementing sequences (the `FP::Abstract::Sequence` protocol), and
they are interconvertible:

    main> purearray(10,11,13)->list
    $VAR1 = list(10, 11, 13);
    main> $VAR1->purearray
    $VAR1 = purearray(10, 11, 13);

The difference is that `list` offers efficient incremental adding of
elements, whereas `purearray` is using more efficient data storage and
offers efficient access to any random position:

    main> $VAR1->[1]
    $VAR1 = 11;

Whereas `list` does not offer array indexing (it offers a `ref` method
to access any element, but that is less efficient the longer the list
is).

#### Conclusion

Basically what this means is we're starting off the search with no
numbers chosen at all: `$chosen` will be the empty list at the
beginning. Then off it goes calling `any` on `$ns` to add the first
number to it, when that fails, add another one, until the sum is too
large, at which point it backtracks and continues trying the other
numbers until it finds a match or has run out of numbers from `$ns` to
try, at which point it backtracks more, until it finds a match or runs
out of any combinations to try.

You can enable the warn statement by setting `VERBOSE=1`, and
disabling the optimized algorithm:

    $ VERBOSE=1 NO_OPTIM=1 ./113-1-represent_integer --repl
    main> maybe_representable 25, 7
    check (brute): list() at ./113-1-represent_integer line 63.
    check (brute): list(17) at ./113-1-represent_integer line 63.
    check (brute): list(17, 17) at ./113-1-represent_integer line 63.
    check (brute): list(7, 17) at ./113-1-represent_integer line 63.
    check (brute): list(17, 7, 17) at ./113-1-represent_integer line 63.
    check (brute): list(7, 7, 17) at ./113-1-represent_integer line 63.
    check (brute): list(7) at ./113-1-represent_integer line 63.
    check (brute): list(17, 7) at ./113-1-represent_integer line 63.
    check (brute): list(17, 17, 7) at ./113-1-represent_integer line 63.
    check (brute): list(7, 17, 7) at ./113-1-represent_integer line 63.
    check (brute): list(7, 7) at ./113-1-represent_integer line 63.
    check (brute): list(17, 7, 7) at ./113-1-represent_integer line 63.
    check (brute): list(7, 7, 7) at ./113-1-represent_integer line 63.
    check (brute): list(17, 7, 7, 7) at ./113-1-represent_integer line 63.
    check (brute): list(7, 7, 7, 7) at ./113-1-represent_integer line 63.
    $VAR1 = undef;

As you can see, the list in `$chosen` grows on the left side, then
changes elements at the left end, then backtracks (e.g. from `list(7,
7, 17)` to `list(7)`). After trying `list(7, 7, 7, 7)`, it gives up,
as `list(7, 7, 7, 7)->sum` is 28, larger than 25, thus `$check`
returns `undef`, and `any` has reached the end of numbers from `$ns`
on all 4 levels involved here, thus the final result is `undef`, too.

(You can also see, that the algorithm checks both `list(7, 17)` and
`list(17, 7)`, which is of course pointless given that addition is
commutative.)

    main> maybe_representable 24, 7
    check (brute): list() at ./113-1-represent_integer line 63.
    check (brute): list(17) at ./113-1-represent_integer line 63.
    check (brute): list(17, 17) at ./113-1-represent_integer line 63.
    check (brute): list(7, 17) at ./113-1-represent_integer line 63.
    $VAR1 = list(7, 17);

In this case, `$check` found a match with `list(7, 17)`, which it
returns, which ends `any` on two levels and returns the same as the
final result.

### Optimize by looking ahead one level

One thing we can realize is that the dumb approach, as long as
`$chosen->sum` is too small, tries out all numbers from `$ns` until it
finds one that completes a match, or completes one indirectly (with
more numbers added on top). What if we first checked if the missing
difference is a number that's in `$ns` without walking all of `$ns`
sequentially? We can build a hash table with the values from `$ns`, so
that such a check is cheaper.

This won't make things faster if `$ns` is as small as just the two
values 7 and 17 as in the examples from the task, but will help if
`$N` and thus `$ns` is large.

    sub maybe_choose_optim_1 ($N, $ns) {
        __ 'Choose a combination of numbers from $ns (repetitions allowed)
            that added together equal $N; undef if not possible. This
            solution uses a hashtable to check for each additional number;
            i.e. it tries to minimize the number of numbers taken from
            $ns (it is still searching depth-first).';
        my %ns = map { $_ => 1 } $ns->values;

`%ns` is going to provide for the indexed check.

        sub ($chosen) {
            my $check = __SUB__;
            warn "check (optim 1): " . show($chosen) if $verbose;
            my $sum     = $chosen->sum;
            my $missing = $N - $sum;

`$missing` is how much is missing, and we're using that first to see
if we're done without adding more numbers, or are at a dead end (we
have overshot the target already), or whether we can simply take
`$missing` as the new number to add since it's a valid one itself, and
be done.

            if (not $missing) {
                $chosen
            } elsif ($missing < 0) {
                undef
            } else {
                if (exists $ns{$missing}) {

At this point, `$missing` is a valid number, and it's what's missing,
so we're done, we just need to add `$missing` to `$chosen`:

                    cons $missing, $chosen
                } else {

Otherwise we need to try all numbers in `$ns`, just like in
`maybe_choose_brute`:

                    $ns->any(
                        sub ($n) {
                            $check->(cons($n, $chosen))
                        }
                    )
                }
            }
            }
            ->(null)
    }

Timing the search with this new algorithm didn't yield much of an
improvement, though.

One thing to observe is that the algorithm does go deep first (it
tests the next level (via recursion) before returning and letting
`any` pick the next number on the upper level): this prioritizes
solutions that are composed of more numbers over those consisting of
fewer numbers. And that means that more levels of linear searches
through `$ns` have to happen than if the search were breadth-first.

Also, on any particular level, the call to `any` is stupidly checking
numbers in `$ns` even if they are all leading to too large of a
number—`any` isn't aware of the fact that `$ns` is ordered, and that
after reaching a particular point in `$ns` where `$check->(cons($n,
$chosen))` finds that the sum is too large, all subsequent attempts
will lead to too large sums, too.

NOTE: while writing this blog post I noticed that `$ns->reverse` in
`maybe_representable` is actually counter productive for the
`maybe_choose_optim_1` algorithm (for the numbers that I
tested). Intuitively I had thought that larger numbers should be
checked first, as that would lead to shorter number sets as results
even in the depth-first algorithm. But what seems to happen is that
when looking from the smaller numbers, adding them incrementally will
quickly lead to a case where the `$missing` check in `%ns` will give a
success. Somewhat fascinating.

### Doing a breadth-first search, and stopping early

(Note: I'm going to describe how this approach works basically two
times: in the next two paragraphs, and then again in the code. If you
don't get what I'm saying here maybe try going ahead and read the code
explanations; then come back. Maybe it makes more sense that way.)

Achieving the two stated aims as described in the previous section,
while still using "standard library functions" (of `FunctionalPerl`,
methods like `map`) is possible via a feature called lazy evaluation:
evaluating a value only when actually needed. When programming
imperatively, once can code the program so that it simply never
evaluates things it doesn't need to, like by exiting a loop
early. When using functions on sequences like `map` or `take_while`,
as we'll do, then there's no way to exit them via a `return`
statement—after all, they get a function as an argument, and returning
from that function would just, well, return from that function. But by
using lazy evaluation, if from the list that `map` generates we only
use part, the remainder will never be generated. This is like an
iterator, which is the imperative way to generate values on demand. In
the functional world we can achieve both short-cutting approaches, the
early return, and the iterator, with one feature, the lazy
evaluation.

`FunctionalPerl` offers lazy evaluation in two ways: via lazy
sequences (called "streams"), which embed lazy evaluation inside their
methods, and via using the `lazy` function directly. `lazy` takes a
block of code which is not evaluated right away, but simply wrapped
and returned as a code ref to be run only when the value is needed.
I'm going to use both here. The first to stop walking `$ns` early, and
the second to delay recursion (going deeper, to choose an additional
number) until after the previous level has finished checking all other
cases (i.e. to achieve the breadth-first search approach).

The code already has explanations, hopefully they make it clear
already:

    sub maybe_choose_optim_2 ($N, $_ns) {
        __ 'Choose a combination of numbers (repetitions allowed) from $ns
            which must be sorted in decrementing order that added together
            equal $N; undef if not possible. This solution does a
            breadth-first search (and uses the hashtable check to see if
            there will be a match with the next level like
            maybe_choose_optim_1)';

        # We want to use lazy evaluation to allow for the descriptive
        # solution below, thus turn the purearray to a lazy list:
        my $ns = $_ns->stream;

        my %ns = map { $_ => 1 } $_ns->values;

        sub ($chosen) {
            my $check = __SUB__;
            warn "check (optim 2): " . show($chosen) if $verbose;

            # Given an additional choice of a number $n (out of $ns) on
            # top of $chosen, decide whether there's a solution either
            # with the given numbers or when adding one more missing
            # number by looking at %ns; or whether the chosen numbers are
            # adding up to too much already (in which case undef is
            # returned), or the search needs to resume via recursively
            # calling $check. The latter case is not carried out
            # immediately, but returned as a lazy term (a promise), to
            # allow to delay diving deeper into the next recursion level
            # to *after* checking all numbers in the current level
            # (breadth-first search).

            # Using FP::Either's `Right` to indicate an immediate
            # solution, `Left` to indicate a case that needs recursion
            # (and only potentially yields a result), undef to signify a
            # dead end.

            my $decide = sub ($n) {
                warn "decide: checking $n on top of " . show($chosen) if $verbose;
                my $chosen  = cons $n, $chosen;
                my $missing = $N - ($chosen->sum);
                if (not $missing) {
                    Right $chosen
                } elsif ($missing < 0) {
                    undef
                } else {
                    if (exists $ns{$missing}) {
                        Right cons($missing, $chosen)
                    } else {
                        Left lazy {
                            $check->($chosen)
                        }
                    }
                }
            };

            # Since $ns are sorted in decrementing order, if $decide
            # returns undef, any subsequent number will fail, too, so we
            # can stop further checks; `take_while` will only take the
            # results up to that point.

            # Since $ns is a stream (a lazily computed list), the
            # following `map` and `take_while` steps are lazy, too;
            # $decide will never be evaluated for $n's that are smaller
            # (coming further along in the reverse-ordered $ns) than any
            # $n that can lead to a solution.

            my $decisions = $ns->map($decide)->take_while(\&is_defined);

            # Check for immediate solutions (solutions on our level)
            # first, if that fails, get and evaluate the promises to
            # recurse (go deeper):

            my $solutions  = rights $decisions;
            my $recursions = lefts $decisions;
            unless ($solutions->is_null) {
                $solutions->first
            } else {
                $recursions->any(\&force)
            }
            }
            ->(null)
    }

In a sense, thanks to doing breadth-first search, we're back at the
approach using `stream_cartesian_product` I hinted at above: checking
all the combinations of two lists first; then all the combinations
with three lists, etc. Although `maybe_choose_optim_2` will be faster
since it optimizes one of the combinations via `%ns`. That could also
be encoded in the search over the combinations, though, so I should
probably see whether nicer code couldn't be written by using that
approach. There's no time before submitting the solutions, though, so
I'll have to see.

</with_toc>

<p align="center"><big>⚘</big> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>

<em>If you'd like to comment, please see the instructions [here](index.md).</em>
