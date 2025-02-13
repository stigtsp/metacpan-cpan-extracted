package Acme::CPANModules::COLOR;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-05-10'; # DATE
our $DIST = 'Acme-CPANModules-COLOR'; # DIST
our $VERSION = '0.004'; # VERSION

our $LIST = {
    summary => "Modules that follow the COLOR & NO_COLOR convention",
    description => <<'_',

The NO_COLOR convention (see https://no-color.org) lets user disable color
output of console programs by defining an environment variable called NO_COLOR.
The existence of said environment variable, regardless of its value (including
empty string, undef, or 0), signals that programs should not use colored output.

Another similar convention is the use of the COLOR environment variable. False
value (empty string or the value 0) means that programs should disable colored
output, while true value (values other than the mentioned false values) means
that programs should enable colored output. This convention allows
force-enabling colored output instead of just force-disabling it, although
programs supporting it need to add a line of code or two to check the value of
the environment variable.

If you know of other modules that should be listed here, please contact me.

_
    entries => [
        {module=>'AppBase::Grep'},
        {module=>'App::abgrep', script=>'abgrep'},
        {module=>'App::diffdb'},
        {module=>'App::DiffTarballs'},
        {module=>'App::diffwc'},
        {module=>'App::hr'},
        {module=>'App::riap'},
        {module=>'App::wordlist'},
        {module=>'Color::ANSI::Util'},
        {module=>'Data::Dump::Color'},
        {module=>'Data::Format::Pretty::JSON'},
        {module=>'Data::Format::Pretty::Perl'},
        {module=>'Data::Format::Pretty::YAML'},
        {module=>'Debug::Print'},
        {module=>'Log::Any::Adapter::Screen'},
        {module=>'Log::ger::Output::Screen'},
        {module=>'Perinci::CmdLine::Classic'},
        {module=>'Perinci::CmdLine::Lite'},
        {module=>'Perinci::Result::Format'},
        {module=>'Perinci::Result::Format::Lite'},
        {module=>'Progress::Any::Output::TermProgressBar'},
        {module=>'Term::ANSIColor::Conditional'},
        {module=>'Term::ANSIColor::Patch::Conditional'},
        {module=>'Term::App::Roles'},
        {module=>'Text::ANSITable'},
        {module=>'Text::DiffU'},
    ],
    links => [
        {url=>'pm:Acme::CPANModules::NO_COLOR'},
        {url=>'pm:Acme::CPANModules::ColorEnv'},
    ],
};

1;
# ABSTRACT: Modules that follow the COLOR & NO_COLOR convention

__END__

=pod

=encoding UTF-8

=head1 NAME

Acme::CPANModules::COLOR - Modules that follow the COLOR & NO_COLOR convention

=head1 VERSION

This document describes version 0.004 of Acme::CPANModules::COLOR (from Perl distribution Acme-CPANModules-COLOR), released on 2021-05-10.

=head1 DESCRIPTION

The NO_COLOR convention (see https://no-color.org) lets user disable color
output of console programs by defining an environment variable called NO_COLOR.
The existence of said environment variable, regardless of its value (including
empty string, undef, or 0), signals that programs should not use colored output.

Another similar convention is the use of the COLOR environment variable. False
value (empty string or the value 0) means that programs should disable colored
output, while true value (values other than the mentioned false values) means
that programs should enable colored output. This convention allows
force-enabling colored output instead of just force-disabling it, although
programs supporting it need to add a line of code or two to check the value of
the environment variable.

If you know of other modules that should be listed here, please contact me.

=head1 ACME::CPANMODULES ENTRIES

=over

=item * L<AppBase::Grep>

=item * L<App::abgrep>

=item * L<App::diffdb>

=item * L<App::DiffTarballs>

=item * L<App::diffwc>

=item * L<App::hr>

=item * L<App::riap>

=item * L<App::wordlist>

=item * L<Color::ANSI::Util>

=item * L<Data::Dump::Color>

=item * L<Data::Format::Pretty::JSON>

=item * L<Data::Format::Pretty::Perl>

=item * L<Data::Format::Pretty::YAML>

=item * L<Debug::Print>

=item * L<Log::Any::Adapter::Screen>

=item * L<Log::ger::Output::Screen>

=item * L<Perinci::CmdLine::Classic>

=item * L<Perinci::CmdLine::Lite>

=item * L<Perinci::Result::Format>

=item * L<Perinci::Result::Format::Lite>

=item * L<Progress::Any::Output::TermProgressBar>

=item * L<Term::ANSIColor::Conditional>

=item * L<Term::ANSIColor::Patch::Conditional>

=item * L<Term::App::Roles>

=item * L<Text::ANSITable>

=item * L<Text::DiffU>

=back

=head1 FAQ

=head2 What is an Acme::CPANModules::* module?

An Acme::CPANModules::* module, like this module, contains just a list of module
names that share a common characteristics. It is a way to categorize modules and
document CPAN. See L<Acme::CPANModules> for more details.

=head2 What are ways to use this Acme::CPANModules module?

Aside from reading this Acme::CPANModules module's POD documentation, you can
install all the listed modules (entries) using L<cpanmodules> CLI (from
L<App::cpanmodules> distribution):

    % cpanmodules ls-entries COLOR | cpanm -n

or L<Acme::CM::Get>:

    % perl -MAcme::CM::Get=COLOR -E'say $_->{module} for @{ $LIST->{entries} }' | cpanm -n

or directly:

    % perl -MAcme::CPANModules::COLOR -E'say $_->{module} for @{ $Acme::CPANModules::COLOR::LIST->{entries} }' | cpanm -n

This Acme::CPANModules module also helps L<lcpan> produce a more meaningful
result for C<lcpan related-mods> command when it comes to finding related
modules for the modules listed in this Acme::CPANModules module.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Acme-CPANModules-COLOR>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Acme-CPANModules-COLOR>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Acme-CPANModules-COLOR>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Acme::CPANModules> - about the Acme::CPANModules namespace

L<cpanmodules> - CLI tool to let you browse/view the lists

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021, 2020, 2018 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
