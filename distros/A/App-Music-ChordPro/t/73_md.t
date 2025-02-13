#! perl

use strict;
use warnings;
use utf8;

use App::Music::ChordPro::Testing;

my $test = 0;

BAIL_OUT("Missing md test data") unless -d "md";

opendir( my $dh, "md" ) || BAIL_OUT("Cannot open md test data");
my @files = grep { /^.+\.cho$/ } readdir($dh);
close($dh);
diag("Testing ", scalar(@files), " cho files");

our $options;

foreach my $file ( sort @files ) {
    $test++;
    my $decoda = $file =~ /^decoda/i;
    $file = "md/$file";
    #diag("Testing: $file");
    ( my $out = $file ) =~ s/\.cho/.tmp/;
    ( my $ref = $file ) =~ s/\.cho/.md/;
    @ARGV = ( "--no-default-configs",
	      "--generate", "Markdown",
	      "--output", $out,
	      $file );
    ::run();
    my $ok = !differ( $out, $ref );
    ok( $ok, $file );
    unlink($out) if $ok;
}

ok( $test++ == @files, "Tested @{[0+@files]} files" );

done_testing($test);
