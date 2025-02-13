# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.024.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Extensible toolkit for generating mock data",
  "AUTHOR" => "Michael Conrad <mike\@nrdvana.net>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Mock-Data",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Mock::Data",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter::Extensible" => 0,
    "Hash::Util" => 0,
    "List::Util" => 0,
    "MRO::Compat" => 0,
    "Module::Runtime" => 0,
    "POSIX" => 0,
    "Scalar::Util" => 0,
    "Storable" => 0,
    "Unicode::UCD" => 0,
    "charnames" => 0,
    "mro" => 0,
    "overload" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Data::Dumper" => 0,
    "Test2::V0" => 0,
    "Time::HiRes" => 0
  },
  "VERSION" => "0.03",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Dumper" => 0,
  "Exporter::Extensible" => 0,
  "Hash::Util" => 0,
  "List::Util" => 0,
  "MRO::Compat" => 0,
  "Module::Runtime" => 0,
  "POSIX" => 0,
  "Scalar::Util" => 0,
  "Storable" => 0,
  "Test2::V0" => 0,
  "Time::HiRes" => 0,
  "Unicode::UCD" => 0,
  "charnames" => 0,
  "mro" => 0,
  "overload" => 0,
  "strict" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
