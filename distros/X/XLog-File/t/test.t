use 5.012;
use warnings;
use lib 't/lib'; use MyTest;
use Test::More;
use Test::Catch;
use UniEvent::Fs;

catch_run('[log-file]');

my $dir = "t/var";
my $file = "$dir/file.log";

sub test ($&) {
    my ($name, $sub) = @_;
    subtest $name => $sub;
    (undef) = UniEvent::Fs::remove_all($dir); # ignore errors for windows
}

test "log" => sub {
    XLog::set_logger(XLog::File->new({file => $file, buffered => 0}));
    XLog::set_format("%m");
    XLog::set_level(XLog::DEBUG);

    XLog::debug("hello world");
    XLog::set_logger(undef);

    is readfile($file), "hello world\n";
};

test 'buffered' => sub {
    my $logger = XLog::File->new({
        file      => $file,
        buffered => 1,
    });
    XLog::set_logger($logger);
    XLog::set_format("%m");
    XLog::set_level(XLog::DEBUG);

    XLog::debug("hello");

    $logger->flush();
    is readfile($file), "hello\n";

    XLog::debug("world");

    $logger->flush();
    is readfile($file), "hello\nworld\n";
};

done_testing();

sub readfile {
    my $file = shift;
    open my $fh, '<', $file or die $!;
    my $content = join '', <$fh>;
    close $fh;
    return $content;
}
