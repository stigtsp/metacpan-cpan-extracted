use Test::More;

if ( not $ENV{AUTHOR_TESTING} ) {
    my $msg = 'Set $ENV{AUTHOR_TESTING} to run author tests.';
    plan( skip_all => $msg );
}

eval "use Test::Dependencies exclude => [qw/ WWW::Wookie /], style => q{heavy}";
plan skip_all => "Test::Dependencies required for testing dependencies" if $@;

TODO: {
    todo_skip q{Test::Dependencies can't do WWW::Wookie::Connector::Service}, 1
      if 1;    #!-f q{META.yml};
    ok_dependencies();
}
