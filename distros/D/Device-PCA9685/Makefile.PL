# This Makefile.PL for Device-PCA9685 was generated by
# Dist::Zilla::Plugin::MakeMaker::Awesome 0.38.
# Don't edit it but the dist.ini and plugins used to construct it.

use strict;
use warnings;

use 5.010;
use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "I2C interface to PCA9685 16 channel 12 bit PWM Generator",
  "AUTHOR" => "Shantanu Bhadoria <shantanu at cpan dott org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Device-PCA9685",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Device::PCA9685",
  "PREREQ_PM" => {
    "Device::SMBus" => 0,
    "Moose" => 0,
    "POSIX" => 0,
    "Time::HiRes" => 0,
    "constant" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0,
    "blib" => "1.01"
  },
  "VERSION" => "0.004",
  "test" => {
    "TESTS" => "t/*.t"
  }
);

my %FallbackPrereqs = (
  "Device::SMBus" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Moose" => 0,
  "POSIX" => 0,
  "Test::More" => 0,
  "Time::HiRes" => 0,
  "blib" => "1.01",
  "constant" => 0,
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
