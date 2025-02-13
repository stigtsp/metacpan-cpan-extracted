######################################################################
# Makefile.PL for App::CPANtoRPM
######################################################################

use strict;
use warnings;
use 5.006;
use ExtUtils::MakeMaker 6.30;

my %IsWin32 = map { $_ => 1 } qw( MSWin32 NetWare symbian );
my $IsWin32 = 1   if ($IsWin32{ $^O });
my $Pvers   = $];
my $ConvVers= $ExtUtils::MakeMaker::VERSION;

my %module_prereq = (
   'IO::File'                 => '0',
   'POSIX'                    => '0',
   'locale'                   => '0',
);

my %script_prereq = (
);

my %test_prereq = (
   'Test::Inter'              => '1.09',
   'Test::More'               => '0',
);

my %config_prereq = (
   'ExtUtils::MakeMaker'      => '6.30',
);

%module_prereq = (%module_prereq,%script_prereq);
my $EU_MM_V    = $ExtUtils::MakeMaker::VERSION;
$EU_MM_V       =~ s/_//g;
if ($EU_MM_V < 6.64) {
   %config_prereq = (%config_prereq,%test_prereq);
}

WriteMakefile(
   NAME             => "App::CPANtoRPM",
   VERSION          => "1.13",
   ABSTRACT         => "An RPM packager for perl modules",
   LICENSE          => "perl",
   ($EU_MM_V >= 6.48
    ? (MIN_PERL_VERSION => "5.006")
    : ()),
   AUTHOR           => "Sullivan Beck (sbeck\@cpan.org)",
   "dist"           => {COMPRESS=>"gzip",SUFFIX=>"gz"},
   PL_FILES         => {},
   PREREQ_PM        => \%module_prereq,
   ($EU_MM_V >= 6.52
    ? (CONFIGURE_REQUIRES => \%config_prereq)
    : ()),
   ($EU_MM_V >= 6.64
    ? (TEST_REQUIRES   => \%test_prereq)
    : ()),
   ($EU_MM_V > 6.45
    ? (META_ADD => {
          provides     => {
             'App::CPANtoRPM' => {
                file    => 'lib/App/CPANtoRPM.pm',
                version => '1.13',
             },
             'cpantorpm' => {
                file    => 'cpantorpm',
                version => '1.13',
             },

          },
       }
      )
    : ()),

   ($EU_MM_V > 6.46
    ? (META_MERGE => {
          'meta-spec'  => {
             version   => 2,
          },
          resources    => {
             bugtracker => {
                web  => 'https://github.com/SBECK-github/App-CPANtoRPM/issues',
             },
             homepage => 'https://github.com/SBECK-github/App-CPANtoRPM',
             repository => {
                type => 'git',
                web  => 'https://github.com/SBECK-github/App-CPANtoRPM',
                url  => 'git://github.com/SBECK-github/App-CPANtoRPM.git',
             },
          },
       }
      )
    : ()),

   EXE_FILES        => [
                        'bin/cpantorpm-depreq',
                        'bin/cpantorpm',

                       ],

   MAN1PODS => {
      'bin/cpantorpm.pod' => 'blib/man1/cpantorpm.1',
   },


);
