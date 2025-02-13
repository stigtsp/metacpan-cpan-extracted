# encoding: Arabic
# This file is encoded in Arabic.
die "This file is not encoded in Arabic.\n" if q{��} ne "\x82\xa0";

use Arabic;

print "1..12\n";

# Arabic::eval qq{...} has Arabic::eval "..."
if (Arabic::eval qq{ Arabic::eval " if (Arabic::length(q{�����������������������������������������������}) == 47) { return 1 } else { return 0 } " }) {
    print qq{ok - 1 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 1 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has Arabic::eval qq{...}
if (Arabic::eval qq{ Arabic::eval qq{ if (Arabic::length(q{�����������������������������������������������}) == 47) { return 1 } else { return 0 } } }) {
    print qq{ok - 2 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 2 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has Arabic::eval '...'
if (Arabic::eval qq{ Arabic::eval ' if (Arabic::length(q{�����������������������������������������������}) == 47) { return 1 } else { return 0 } ' }) {
    print qq{ok - 3 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 3 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has Arabic::eval q{...}
if (Arabic::eval qq{ Arabic::eval q{ if (Arabic::length(q{�����������������������������������������������}) == 47) { return 1 } else { return 0 } } }) {
    print qq{ok - 4 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 4 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has Arabic::eval $var
my $var = q{q{ if (Arabic::length(q{�����������������������������������������������}) == 47) { return 1 } else { return 0 } }};
if (Arabic::eval qq{ Arabic::eval $var }) {
    print qq{ok - 5 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 5 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has Arabic::eval (omit)
$_ = "if (Arabic::length(q{�����������������������������������������������}) == 47) { return 1 } else { return 0 }";
if (Arabic::eval qq{ Arabic::eval }) {
    print qq{ok - 6 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 6 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has Arabic::eval {...}
if (Arabic::eval qq{ Arabic::eval { if (Arabic::length(q{�����������������������������������������������}) == 47) { return 1 } else { return 0 } } }) {
    print qq{ok - 7 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 7 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has "..."
if (Arabic::eval qq{ if (Arabic::length(q{�����������������������������������������������}) == 47) { return "1" } else { return "0" } }) {
    print qq{ok - 8 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 8 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has qq{...}
if (Arabic::eval qq{ if (Arabic::length(q{�����������������������������������������������}) == 47) { return qq{1} } else { return qq{0} } }) {
    print qq{ok - 9 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 9 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has '...'
if (Arabic::eval qq{ if (Arabic::length(q{�����������������������������������������������}) == 47) { return '1' } else { return '0' } }) {
    print qq{ok - 10 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 10 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has q{...}
if (Arabic::eval qq{ if (Arabic::length(q{�����������������������������������������������}) == 47) { return q{1} } else { return q{0} } }) {
    print qq{ok - 11 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 11 $^X @{[__FILE__]}\n};
}

# Arabic::eval qq{...} has $var
my $var1 = 1;
my $var0 = 0;
if (Arabic::eval qq{ if (Arabic::length(q{�����������������������������������������������}) == 47) { return $var1 } else { return $var0 } }) {
    print qq{ok - 12 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 12 $^X @{[__FILE__]}\n};
}

__END__
