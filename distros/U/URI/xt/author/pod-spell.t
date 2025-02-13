use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007005
use Test::Spelling 0.12;
use Pod::Wordlist;

set_spell_cmd('aspell list');
add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib ) );
__DATA__
Aas
Adam
Alders
Alex
Base
Berners
Bonaccorso
Brendan
Byrd
Chase
David
Dorian
Dubois
Escape
Etheridge
FAT
Fiegehenn
Fredric
Förtsch
Gisle
Herzog
Heuristic
Honma
IDNA
IRI
ISBNs
Ishigaki
Jan
John
Julien
Kaitlyn
Kaji
Kapranoff
Karen
Karr
Kenichi
Kent
Koster
Lawrence
Mac
Mark
Martijn
Masahiro
Masinter
Matt
Michael
Miller
Miyagawa
OIDs
OS2
Olaf
OpenLDAP
Parkhurst
Perl
Perlbotics
Peter
Piotr
Punycode
QNX
QueryParam
Rabbitson
Rezic
Roszatycki
Salvatore
Schmidt
Schwern
Shoichi
Skyttä
Slaven
Split
Stosberg
TCP
TLS
Tatsuhiko
Taylor
Torsten
UDP
UNC
URI
URL
Unix
Ville
Whitener
Win32
WithBase
_foreign
_generic
_idna
_ldap
_login
_punycode
_query
_segment
_server
_userpass
adam
brainbuz
brian
capoeirab
carnil
data
davewood
dorian
ether
etype
evalue
file
foy
ftp
gerard
gisle
gopher
hiratara
http
https
isbn
ishigaki
jand
john
kapranoff
kentfredric
ldap
ldapi
ldaps
lib
lowercasing
mailto
mark
matthewlawrence
miyagawa
mms
news
nntp
nntps
oid
olaf
perlbotix
piotr
pop
relativize
ribasushi
rlogin
rsync
rtsp
rtspu
schwern
sftp
simbabque
sip
sips
skaji
slaven
snews
ssh
symkat
telnet
tn3270
torsten
uppercasing
urn
ville
