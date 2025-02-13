package Locale::Places;

use strict;
use warnings;

use Carp;
use CHI;
use File::Spec;
use Locale::Places::DB::GB;
use Module::Info;

=head1 NAME

Locale::Places - Translate places between different languages using http://download.geonames.org/

=head1 VERSION

Version 0.07

=cut

our $VERSION = '0.07';

=head1 SYNOPSIS

Translates towns and cities between different languages, for example
London is Londres in French.

=head1 METHODS

=head2 new

Create a Locale::Places object.

Takes one optional parameter, directory,
which tells the object where to find the file GB.sql
If that parameter isn't given,
the module will attempt to find the databases,
but that can't be guaranteed.
Any other options are passed to the underlying database driver.

=cut

sub new {
	my($proto, %param) = @_;
	my $class = ref($proto) || $proto;

	if(!defined($class)) {
		# Using Locale::Places->new, not Locale::Places::new
		# carp(__PACKAGE__, ' use ->new() not ::new() to instantiate');
		# return;
		$class = __PACKAGE__;
	}

	my $directory = delete $param{'directory'} || Module::Info->new_from_loaded(__PACKAGE__)->file();
	$directory =~ s/\.pm$//;

	Locale::Places::DB::init({
		directory => File::Spec->catfile($directory, 'databases'),
		no_entry => 1,
		cache => $param{cache} || CHI->new(driver => 'Memory', datastore => {}),
		%param
	});

	return bless { }, $class;
}

=head2 translate

Translate a city into a different language.
Takes one mandatory argument: 'place'.
It also takes two other arguments:
'from' and 'to',
at least one of which must be given.
If neither $to nor $from is given,
the code makes a best guess based on the environment.
If no translation can be found, returns place in the original language.

   use Locale::Places;

   # Prints "Douvres"
   print Locale::Places->new()->translate({ place => 'Dover', from => 'en', to => 'fr' });

   # Prints "Douvres" if we're working on a French system
   print Locale::Places->new()->translate('Dover');

=cut

sub translate {
	my $self = shift;

	my %params;
	if(ref($_[0]) eq 'HASH') {
		%params = %{$_[0]};
	} elsif(scalar(@_) % 2 == 0) {
		%params = @_;
	} else {
		$params{'place'} = shift;
		$params{'from'} = 'en';
	}

	my $place = $params{'place'};
	if(!defined($place)) {
		Carp::carp(__PACKAGE__, ': usage: translate(place => $place, from => $language1, to => $language2)');
		return;
	}

	my $to = $params{'to'};
	my $from = $params{'from'};
	if((!defined($from)) && !defined($to)) {
		$to ||= $self->_get_language();
		if(!defined($to)) {
			Carp::carp(__PACKAGE__, ': usage: translate(place => $place, from => $language1, to => $language2)');
			return;
		}
	}

	$from ||= $self->_get_language();
	if(!defined($from)) {
		Carp::carp(__PACKAGE__, ": can't work out which language to translate from");
		return;
	}
	$to ||= $self->_get_language();
	if(!defined($to)) {
		Carp::carp(__PACKAGE__, ": can't work out which language to translate to");
		return;
	}
	return $place if($to eq $from);

	# TODO: Add a country argument and choose a database based on that
	$self->{'gb'} ||= Locale::Places::DB::GB->new(no_entry => 1);

	# my @places = @{$self->{'gb'}->selectall_hashref({ type => $from, data => $place, ispreferredname => 1 })};
	my @places = $self->{'gb'}->code2({ type => $from, data => $place, ispreferredname => 1 });
	if(scalar(@places) == 0) {
		# @places = @{$self->{'gb'}->selectall_hashref({ type => $from, data => $place })};
		@places = $self->{'gb'}->code2({ type => $from, data => $place });
	}

	if(scalar(@places) == 1) {
		if(my $data = $self->{'gb'}->data({ type => $to, code2 => $places[0] })) {
		# if(my $data = $self->{'gb'}->data({ type => $to, code2 => $places[0]->{'code2'} })) {
			return $data;
		}
	} elsif(scalar(@places) > 1) {
		# Handle the case when there are more than one preferred value
		# but either not all translate or they all translate to the same
		# value, in which case the duplicate can be ignored

		# If none of them matches then assume there are no translations
		# available and return that

		my $candidate;
		my $found_something;
		foreach my $place(@places) {
			if(my $data = $self->{'gb'}->data({ type => $to, code2 => $place })) {
				$found_something = 1;
				if(defined($candidate)) {
					if($data ne $candidate) {
						$candidate = undef;
					}
				} else {
					$candidate = $data;
				}
			}
		}
		return $candidate if(defined($candidate));
		return $place if(!defined($found_something));

		@places = $self->{'gb'}->code2({ type => $from, data => $place, ispreferredname => 1, isshortname => undef });
		if(scalar(@places) == 1) {
			if(my $data = $self->{'gb'}->data({ type => $to, code2 => $places[0] })) {
				return $data;
			}
			@places = $self->{'gb'}->code2({ type => $from, data => $place, ispreferredname => 1, isshortname => 1 });
			if(scalar(@places) == 1) {
				if(my $data = $self->{'gb'}->data({ type => $to, code2 => $places[0] })) {
					return $data;
				}
				# Can't find anything
				return $place;
			}
		} elsif(scalar(@places) == 0) {
			@places = $self->{'gb'}->code2({ type => $from, data => $place, isshortname => undef });
			if(scalar(@places) == 1) {
				if(my $data = $self->{'gb'}->data({ type => $to, code2 => $places[0] })) {
					return $data;
				}
			}
			@places = $self->{'gb'}->code2({ type => $from, data => $place });
			if(scalar(@places) == 1) {
				if(my $data = $self->{'gb'}->data({ type => $to, code2 => $places[0] })) {
					return $data;
				}
			}
		}
		Carp::croak(__PACKAGE__, ': database has ', scalar(@places), " entries for $place in language $to: ", join(', ', @places));
		# foreach my $p(@places) {
			# if(my $line = $self->{'gb'}->fetchrow_hashref({ type => $to, code2 => $p->{'code2'} })) {
				# return $line->{'data'};
			# }
		# }
	}
	return;	# undef
}

# https://www.gnu.org/software/gettext/manual/html_node/Locale-Environment-Variables.html
# https://www.gnu.org/software/gettext/manual/html_node/The-LANGUAGE-variable.html
sub _get_language {
	if($ENV{'LANGUAGE'}) {
		if($ENV{'LANGUAGE'} =~ /^([a-z]{2})/i) {
			return lc($1);
		}
	}
	foreach my $variable('LC_ALL', 'LC_MESSAGES', 'LANG') {
		my $val = $ENV{$variable};
		next unless(defined($val));

		if($val =~ /^([a-z]{2})/i) {
			return lc($1);
		}
	}
	if(defined($ENV{'LANG'}) && (($ENV{'LANG'} =~ /^C\./) || ($ENV{'LANG'} eq 'C'))) {
		return 'en';
	}
	return;	# undef
}

=head1 AUTHOR

Nigel Horne, C<< <njh at bandsman.co.uk> >>

=head1 BUGS

Only supports towns and cities in GB at the moment.

=head1 SEE ALSO

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Locale::Places

You can also look for information at:

=over 4

=item * MetaCPAN

L<https://metacpan.org/release/Locale-Places>

=item * GitHub

L<https://github.com/nigelhorne/Locale-Places>

=item * CPANTS

L<http://cpants.cpanauthors.org/dist/Locale-Places>

=item * CPAN Testers' Matrix

L<http://matrix.cpantesters.org/?dist=Locale-Places>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Locale-Places>

=item * CPAN Testers Dependencies

L<http://deps.cpantesters.org/?module=Locale::Places>

=item * Geonames Discussion Group

L<https://groups.google.com/g/geonames>

=back

=head1 LICENCE AND COPYRIGHT

Copyright 2020-2022 Nigel Horne.

This program is released under the following licence: GPL2

This product uses data from geonames, L<http://download.geonames.org>.

=cut

1;
