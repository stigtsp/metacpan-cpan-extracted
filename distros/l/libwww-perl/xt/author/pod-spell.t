use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007005
use Test::Spelling 0.12;
use Pod::Wordlist;

set_spell_cmd('aspell --master=en_US list');
add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib ) );
__DATA__
Aas
Accomazzi
Adam
Akiyama
Alders
Alex
Alexandre
Alexey
Andreas
Andrew
Anirvan
Arne
Asplund
Atzberger
Authen
BGMNT
Basic
Beijen
Bell
Betts
Bill
Bochner
BooK
Bron
Bryan
Buenzli
Burke
CGI
CPAN
Campbell
Cardillo
Ceccarelli
Chamas
Chase
Chatterjee
Christopher
Chrysostomos
Colin
ConnCache
Coppit
Couzins
DAVIDRW
Dahan
Daignault
Daina
Dalgleish
Daniel
David
Debug
DebugFile
Denaxas
Desmond
Digest
Doug
Dubois
Dunkin
Durechova
Duret
Dvornik
Eckankar
Eldridge
Etheridge
FWILES
Fabian
Father
Fesler
Finch
Fowler
Frank
Fresh
Froehlich
Galeev
Galen
Gavin
Gerhard
Gertjan
Gianni
Gisle
Gondwana
Graaff
Graeme
Graham
Grangaard
Greab
Gregoire
Gregory
Grossmann
Guenther
Gurusamy
Gustafsson
Hakanson
Hanak
Hans
Harald
Hay
Hedlund
Hewus
Hoblitt
Hoesel
Horsfall
Hukins
Huntington
Hwa
INOUE
Ian
Jacob
Jakub
James
Jason
Jeremy
Joao
Joe
Joerg
Johannessen
John
Jonathan
Jr
KONISHI
Kaji
Kaminsky
Kapranoff
Karaban
Karen
Kartik
Katarina
Katsuhiro
Kebsch
Keiichiro
Kennedy
Kilgore
Kilzer
Klar
Knop
Koenig
Konojacki
Koster
Kronengold
Krüger
Kubb
König
LWP
LaBelle
Laker
Langfeldt
Langheinrich
Liam
Lindley
Lipcon
Lotterer
Lundin
Lutz
Maas
MacEachern
Macdonald
Madsen
Mailto
Maischein
Mann
Mark
Marko
Markus
Martijn
Martin
Massjouni
Mates
Matthew
Matyukhin
Max
McCauley
Melchner
MemberMixin
Michael
Michiel
Mike
Moritz
Moshe
Murrell
NNTP
NTLM
Nagano
Naveed
Newby
Newell
Nicolai
Nierstrasz
Nigel
Nik
Niko
Ntlm
Olaf
Olly
Ondrej
Onken
Oosten
Orton
Oschwald
Paaske
Panchenko
Patrik
Peter
Peters
Pettit
Pimlott
Piotr
Pon
Poul
Protocol
Quaranta
Rabbitson
Radoslaw
Radu
Rai
Raspass
Rezic
Robert
RobotUA
Rolf
Roman
Romanov
Roszatycki
Sarathy
Schilli
Schinder
Schwern
Sean
Sebastian
Sergey
Shirazi
Shoichi
Simple
Sjogren
Skyttä
Slaven
Sluka
Spafford
Spiros
Standish
Steffen
Steffen_Ullrich
Steinbrunner
Steve
SteveHay
Stone
Stosberg
Subbarao
TCP
Takanori
Takumi
Th
Theo
Theodore
Thoennes
Thompson
Thurn
Tilly
Tim
Todd
Tom
Tomasz
Tony
Toru
Tourbin
TraceHTTP
Tyni
Tørholm
UA
Ugai
Ullrich
Unger
UserAgent
VanHeyningen
Vandewege
Ville
Vyacheslav
Wheeler
Whitener
Wilk
WireShark
Wittkoski
Yamaguchi
Yee
Yitzchak
Yoshinari
Yuri
Yury
Yves
Zajac
Zakharevich
Zavarin
Zefram
Zeindler
Zielinski
Zoest
adamk
afPuUsSedvhx
akiym
amir
amire80
andreas
andrew
anirvan
asjo
at
bin
brong
bryan
capoeirab
cjm
colin
corion
cpan
data
david
davidrw
de
denaxas
dnstandish
dot
doug
dpettit
dsteinbrunner
erik
ether
faz
file
freeerider
ftp
galen
gerhard
getprint
getstore
gianni
gisle
git
github
gong
gopher
gpeters
granny
grr
haarg
hfroehlich
http
iank
jefflee
jfesler
jmates
john9art
jonathan
jraspass
jwilk
jwittkoski
ka
katarina
leedo
lib
loopback
lwp
maas
mailto
mark
martin
me
michael
michealgong
michiel
mmcleric
murphy
nalabelle
naveedm9
nawglan
nigelgregoire
nntp
nogo
ntyni
ohiocore
olaf
ondrej
onken
oschwald
patrik
peterm
phrstbrn
piotr
rg
ribasushi
roman
ruff
sasao
sburke
schwern
shaohua
shildreth
simbabque
skaji
slaven
sprout
sromanov
talby
tech
tim
todd
tom
trcjr
turugina
uid39246
van
ville
waif
wfmann
wolfsage
yury
yves
zefram
zigorou
