#!/usr/bin/perl

use strict;
use warnings;
use utf8;

use App::Music::ChordPro::Testing;
use App::Music::ChordPro::Songbook;

plan tests => 6;

# Prevent a dummy {body} for chord grids.
$config->{diagrams}->{show} = 0;
my $s = App::Music::ChordPro::Songbook->new;

# Image (minimal).
my $data = <<EOD;
{title: Swing Low Sweet Chariot}
{image red.jpg}
EOD

eval { $s->parse_file(\$data) } or diag("$@");

ok( scalar( @{ $s->{songs} } ) == 1, "One song" );
isa_ok( $s->{songs}->[0], 'App::Music::ChordPro::Song', "It's a song" );
#use Data::Dumper; warn(Dumper($s));
my $song = {
	    'settings' => {},
	    'meta' => {
		       'songindex' => 1,
		       'title' => [
				   'Swing Low Sweet Chariot'
				  ],
		      },
	    'title' => 'Swing Low Sweet Chariot',
	    'body' => [
		       {
			'context' => '',
			'uri' => 'red.jpg',
			'type' => 'image',
			'opts' => {}
		       }
		      ],
	    'source' => { file => "__STRING__", line => 1 },
	    'structure' => 'linear',
	    'system' => 'common',
	   };

is_deeply( { %{ $s->{songs}->[0] } }, $song, "Song contents" );

# Image (all options).
$s = App::Music::ChordPro::Songbook->new;
$data = <<EOD;
{title: Swing Low Sweet Chariot}
{image red.jpg width=200 height=150 border=2 center scale=4 title="A red image"}
EOD

eval { $s->parse_file(\$data) } or diag("$@");

ok( scalar( @{ $s->{songs} } ) == 1, "One song" );
isa_ok( $s->{songs}->[0], 'App::Music::ChordPro::Song', "It's a song" );
#use Data::Dumper; warn(Dumper($s));
$song = {
	    'title' => 'Swing Low Sweet Chariot',
	    'source' => { file => "__STRING__", line => 1 },
	    'structure' => 'linear',
	    'system' => 'common',
	    'meta' => {
		       'songindex' => 1,
		       'title' => [
				   'Swing Low Sweet Chariot'
				  ]
		      },
	    'settings' => {},
	    'body' => [
		       {
			'type' => 'image',
			'opts' => {
				   'title' => 'A red image',
				   'height' => '150',
				   'border' => '2',
				   'scale' => '4',
				   'center' => 1,
				   'width' => '200'
				  },
			'uri' => 'red.jpg',
			'context' => ''
		       }
		      ],
	      'chordsinfo' => {},
	   };

is_deeply( { %{ $s->{songs}->[0] } }, $song, "Song contents" );
