use 5.028002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Lagrange',
    VERSION_FROM      => 'lib/Lagrange.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => { Stats::Fermi => 0.1.3 }, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Lagrange.pm', # retrieve abstract from module
    AUTHOR            => 'koboldwiz <koboldwiz@yahoo.com>',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);
