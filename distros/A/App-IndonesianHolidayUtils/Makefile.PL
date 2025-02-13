# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.014.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "List Indonesian holidays",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-IndonesianHolidayUtils",
  "EXE_FILES" => [
    "script/count-idn-workdays",
    "script/is-idn-holiday",
    "script/is-idn-workday",
    "script/list-idn-holidays",
    "script/list-idn-workdays"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "App::IndonesianHolidayUtils",
  "PREREQ_PM" => {
    "Calendar::Indonesia::Holiday" => "0.338",
    "Data::Sah::Coerce::perl::To_date::From_float::epoch" => 0,
    "Data::Sah::Coerce::perl::To_date::From_obj::datetime" => 0,
    "Data::Sah::Coerce::perl::To_date::From_obj::time_moment" => 0,
    "Data::Sah::Coerce::perl::To_date::From_str::iso8601" => 0,
    "Data::Sah::Compiler::perl::TH::array" => "0.907",
    "Data::Sah::Compiler::perl::TH::bool" => "0.907",
    "Data::Sah::Compiler::perl::TH::date" => "0.907",
    "Data::Sah::Compiler::perl::TH::int" => "0.907",
    "Data::Sah::Compiler::perl::TH::str" => "0.907",
    "List::MoreUtils" => 0,
    "Moo" => 0,
    "Perinci::CmdLine::Any" => "0.152",
    "Perinci::CmdLine::Lite" => "1.905",
    "Perinci::Sub::Property::result::table" => 0,
    "experimental" => 0,
    "namespace::clean" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.064",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Calendar::Indonesia::Holiday" => "0.338",
  "Data::Sah::Coerce::perl::To_date::From_float::epoch" => 0,
  "Data::Sah::Coerce::perl::To_date::From_obj::datetime" => 0,
  "Data::Sah::Coerce::perl::To_date::From_obj::time_moment" => 0,
  "Data::Sah::Coerce::perl::To_date::From_str::iso8601" => 0,
  "Data::Sah::Compiler::perl::TH::array" => "0.907",
  "Data::Sah::Compiler::perl::TH::bool" => "0.907",
  "Data::Sah::Compiler::perl::TH::date" => "0.907",
  "Data::Sah::Compiler::perl::TH::int" => "0.907",
  "Data::Sah::Compiler::perl::TH::str" => "0.907",
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "List::MoreUtils" => 0,
  "Moo" => 0,
  "Perinci::CmdLine::Any" => "0.152",
  "Perinci::CmdLine::Lite" => "1.905",
  "Perinci::Sub::Property::result::table" => 0,
  "Test::More" => 0,
  "experimental" => 0,
  "namespace::clean" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
