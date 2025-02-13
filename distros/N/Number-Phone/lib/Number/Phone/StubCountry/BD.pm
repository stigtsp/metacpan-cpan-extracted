# automatically generated file, don't edit



# Copyright 2011 David Cantrell, derived from data from libphonenumber
# http://code.google.com/p/libphonenumber/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
package Number::Phone::StubCountry::BD;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20220601185315;

my $formatters = [
                {
                  'format' => '$1-$2',
                  'leading_digits' => '
            31[5-8]|
            [459]1
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{2})(\\d{4,6})'
                },
                {
                  'format' => '$1-$2',
                  'leading_digits' => '
            3(?:
              [67]|
              8[013-9]
            )|
            4(?:
              6[168]|
              7|
              [89][18]
            )|
            5(?:
              6[128]|
              9
            )|
            6(?:
              28|
              4[14]|
              5
            )|
            7[2-589]|
            8(?:
              0[014-9]|
              [12]
            )|
            9[358]|
            (?:
              3[2-5]|
              4[235]|
              5[2-578]|
              6[0389]|
              76|
              8[3-7]|
              9[24]
            )1|
            (?:
              44|
              66
            )[01346-9]
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{3,7})'
                },
                {
                  'format' => '$1-$2',
                  'leading_digits' => '
            [13-9]|
            22
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{4})(\\d{3,6})'
                },
                {
                  'format' => '$1-$2',
                  'leading_digits' => '2',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d)(\\d{7,8})'
                }
              ];

my $validators = {
                'fixed_line' => '
          (?:
            4(?:
              31\\d\\d|
              423
            )|
            5222
          )\\d{3}(?:
            \\d{2}
          )?|
          8332[6-9]\\d\\d|
          (?:
            3(?:
              03[56]|
              224
            )|
            4(?:
              22[25]|
              653
            )
          )\\d{3,4}|
          (?:
            3(?:
              42[47]|
              529|
              823
            )|
            4(?:
              027|
              525|
              65(?:
                28|
                8
              )
            )|
            562|
            6257|
            7(?:
              1(?:
                5[3-5]|
                6[12]|
                7[156]|
                89
              )|
              22[589]56|
              32|
              42675|
              52(?:
                [25689](?:
                  56|
                  8
                )|
                [347]8
              )|
              71(?:
                6[1267]|
                75|
                89
              )|
              92374
            )|
            82(?:
              2[59]|
              32
            )56|
            9(?:
              03[23]56|
              23(?:
                256|
                373
              )|
              31|
              5(?:
                1|
                2[4589]56
              )
            )
          )\\d{3}|
          (?:
            3(?:
              02[348]|
              22[35]|
              324|
              422
            )|
            4(?:
              22[67]|
              32[236-9]|
              6(?:
                2[46]|
                5[57]
              )|
              953
            )|
            5526|
            6(?:
              024|
              6655
            )|
            81
          )\\d{4,5}|
          (?:
            2(?:
              7(?:
                1[0-267]|
                2[0-289]|
                3[0-29]|
                4[01]|
                5[1-3]|
                6[013]|
                7[0178]|
                91
              )|
              8(?:
                0[125]|
                1[1-6]|
                2[0157-9]|
                3[1-69]|
                41|
                6[1-35]|
                7[1-5]|
                8[1-8]|
                9[0-6]
              )|
              9(?:
                0[0-2]|
                1[0-4]|
                2[568]|
                3[3-6]|
                5[5-7]|
                6[0136-9]|
                7[0-7]|
                8[014-9]
              )
            )|
            3(?:
              0(?:
                2[025-79]|
                3[2-4]
              )|
              181|
              22[12]|
              32[2356]|
              824
            )|
            4(?:
              02[09]|
              22[348]|
              32[045]|
              523|
              6(?:
                27|
                54
              )
            )|
            666(?:
              22|
              53
            )|
            7(?:
              22[57-9]|
              42[56]|
              82[35]
            )8|
            8(?:
              0[124-9]|
              2(?:
                181|
                2[02-4679]8
              )|
              4[12]|
              [5-7]2
            )|
            9(?:
              [04]2|
              2(?:
                2|
                328
              )|
              81
            )
          )\\d{4}|
          (?:
            2(?:
              222|
              [45]\\d
            )\\d|
            3(?:
              1(?:
                2[5-7]|
                [5-7]
              )|
              425|
              822
            )|
            4(?:
              033|
              1\\d|
              [257]1|
              332|
              4(?:
                2[246]|
                5[25]
              )|
              6(?:
                2[35]|
                56|
                62
              )|
              8(?:
                23|
                54
              )|
              92[2-5]
            )|
            5(?:
              02[03489]|
              22[457]|
              32[35-79]|
              42[46]|
              6(?:
                [18]|
                53
              )|
              724|
              826
            )|
            6(?:
              023|
              2(?:
                2[2-5]|
                5[3-5]|
                8
              )|
              32[3478]|
              42[34]|
              52[47]|
              6(?:
                [18]|
                6(?:
                  2[34]|
                  5[24]
                )
              )|
              [78]2[2-5]|
              92[2-6]
            )|
            7(?:
              02|
              21\\d|
              [3-589]1|
              6[12]|
              72[24]
            )|
            8(?:
              217|
              3[12]|
              [5-7]1
            )|
            9[24]1
          )\\d{5}|
          (?:
            (?:
              3[2-8]|
              5[2-57-9]|
              6[03-589]
            )1|
            4[4689][18]
          )\\d{5}|
          [59]1\\d{5}
        ',
                'geographic' => '
          (?:
            4(?:
              31\\d\\d|
              423
            )|
            5222
          )\\d{3}(?:
            \\d{2}
          )?|
          8332[6-9]\\d\\d|
          (?:
            3(?:
              03[56]|
              224
            )|
            4(?:
              22[25]|
              653
            )
          )\\d{3,4}|
          (?:
            3(?:
              42[47]|
              529|
              823
            )|
            4(?:
              027|
              525|
              65(?:
                28|
                8
              )
            )|
            562|
            6257|
            7(?:
              1(?:
                5[3-5]|
                6[12]|
                7[156]|
                89
              )|
              22[589]56|
              32|
              42675|
              52(?:
                [25689](?:
                  56|
                  8
                )|
                [347]8
              )|
              71(?:
                6[1267]|
                75|
                89
              )|
              92374
            )|
            82(?:
              2[59]|
              32
            )56|
            9(?:
              03[23]56|
              23(?:
                256|
                373
              )|
              31|
              5(?:
                1|
                2[4589]56
              )
            )
          )\\d{3}|
          (?:
            3(?:
              02[348]|
              22[35]|
              324|
              422
            )|
            4(?:
              22[67]|
              32[236-9]|
              6(?:
                2[46]|
                5[57]
              )|
              953
            )|
            5526|
            6(?:
              024|
              6655
            )|
            81
          )\\d{4,5}|
          (?:
            2(?:
              7(?:
                1[0-267]|
                2[0-289]|
                3[0-29]|
                4[01]|
                5[1-3]|
                6[013]|
                7[0178]|
                91
              )|
              8(?:
                0[125]|
                1[1-6]|
                2[0157-9]|
                3[1-69]|
                41|
                6[1-35]|
                7[1-5]|
                8[1-8]|
                9[0-6]
              )|
              9(?:
                0[0-2]|
                1[0-4]|
                2[568]|
                3[3-6]|
                5[5-7]|
                6[0136-9]|
                7[0-7]|
                8[014-9]
              )
            )|
            3(?:
              0(?:
                2[025-79]|
                3[2-4]
              )|
              181|
              22[12]|
              32[2356]|
              824
            )|
            4(?:
              02[09]|
              22[348]|
              32[045]|
              523|
              6(?:
                27|
                54
              )
            )|
            666(?:
              22|
              53
            )|
            7(?:
              22[57-9]|
              42[56]|
              82[35]
            )8|
            8(?:
              0[124-9]|
              2(?:
                181|
                2[02-4679]8
              )|
              4[12]|
              [5-7]2
            )|
            9(?:
              [04]2|
              2(?:
                2|
                328
              )|
              81
            )
          )\\d{4}|
          (?:
            2(?:
              222|
              [45]\\d
            )\\d|
            3(?:
              1(?:
                2[5-7]|
                [5-7]
              )|
              425|
              822
            )|
            4(?:
              033|
              1\\d|
              [257]1|
              332|
              4(?:
                2[246]|
                5[25]
              )|
              6(?:
                2[35]|
                56|
                62
              )|
              8(?:
                23|
                54
              )|
              92[2-5]
            )|
            5(?:
              02[03489]|
              22[457]|
              32[35-79]|
              42[46]|
              6(?:
                [18]|
                53
              )|
              724|
              826
            )|
            6(?:
              023|
              2(?:
                2[2-5]|
                5[3-5]|
                8
              )|
              32[3478]|
              42[34]|
              52[47]|
              6(?:
                [18]|
                6(?:
                  2[34]|
                  5[24]
                )
              )|
              [78]2[2-5]|
              92[2-6]
            )|
            7(?:
              02|
              21\\d|
              [3-589]1|
              6[12]|
              72[24]
            )|
            8(?:
              217|
              3[12]|
              [5-7]1
            )|
            9[24]1
          )\\d{5}|
          (?:
            (?:
              3[2-8]|
              5[2-57-9]|
              6[03-589]
            )1|
            4[4689][18]
          )\\d{5}|
          [59]1\\d{5}
        ',
                'mobile' => '
          (?:
            1[13-9]\\d|
            644
          )\\d{7}|
          (?:
            3[78]|
            44|
            66
          )[02-9]\\d{7}
        ',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '',
                'toll_free' => '80[03]\\d{7}',
                'voip' => '
          96(?:
            0[469]|
            1[0-47]|
            3[389]|
            6[69]|
            7[78]
          )\\d{6}
        '
              };
my %areanames = ();
$areanames{en} = {"8806825", "Sreepur",
"8804328", "Bakergonj",
"880441", "Patuakhali",
"8804323", "Agailjhara",
"880571", "Jhinaidah\/Panchbibi",
"88075295", "Sirajganj",
"880351", "Rangamati",
"880668", "Gopalgonj",
"8806257", "Madhabdi",
"88074268", "Mahadevpur",
"880852", "Akhaura\/Bancharampur\/Kashba\/Sarail\/Quashba\/Nabinagar\/Ashuganj",
"880466", "Mongla",
"880902", "Phulpur\/Bhaluka\/Gouripur\/Gafargaon\/Goforgaon\/Iswarganj\/Ishwargonj\/Muktagacha",
"8803024", "Mirsharai\/Mirsari",
"880841", "Chandpur",
"88028", "Dhaka",
"8803326", "Fulgazi",
"88075288", "Sirajgonj",
"8803023", "Hathazari",
"88051", "Bogra\/Gabtali\/Nandigram\/Sherpur",
"8803028", "Barabkunda\/Sitakunda",
"880403", "Dighalia",
"8805225", "Mithapukur",
"8803035", "Potia\/Potiya",
"8804324", "Hizla",
"8807527", "Sirajgonj",
"8807724", "Gurudashpur",
"880521", "Rangpur",
"88075255", "Sirajganj",
"88024", "Dhaka",
"88072298", "Tanore",
"8805426", "Saghata\ \(Bonarpara\)",
"8804422", "Baufal\/Mirjagonj",
"8804623", "Bhandaria",
"880468", "Bagerhat\/Mongla\ Port",
"880823", "Sylhet",
"8806822", "Kaliakoir",
"8808218", "Sylhet",
"880481", "Narail",
"8803223", "Companiganj\ \(B\.Hat\)",
"8806328", "Sadarpur\ \(J\.Monjil\)",
"880641", "Rajbari",
"8806323", "Bhanga",
"8806255", "Raipura",
"8804320", "Banaripara",
"8803221", "Begamgonj",
"8805029", "Sherpur",
"8808226", "Fenchugonj",
"8803224", "Hatiya\ \(Oshkhali\)",
"8806324", "Boalmari",
"88072258", "Godagari",
"880922", "Bashail\/Bhuapur\/Ghatail\/Gopalpur\/Kalihati\/Elenga\/Kalihati\/Modhupur\/Mirzapur",
"880751", "Sirajganj",
"88072285", "Rajshahi",
"8805227", "Pirgonj",
"8803020", "Banskhali",
"8804624", "Kaokhali\/Kawkhali",
"88075225", "Sirajganj",
"8804226", "Keshobpur",
"8803032", "Boalkhali",
"8805222", "Badarganj",
"880572", "Panchbibi",
"8804525", "Moheshpur",
"8804655", "Mollarhat",
"880833", "Habiganj",
"8803822", "Raipura",
"880451", "Jhinaidah\/Horinakunda",
"8808220", "Kanaighat",
"8803026", "Rauzan",
"88075268", "Sirajgonj",
"880842", "Hajiganj\/Kochua\/Shahrasti\/Matlab",
"88093", "Nalitabari\/Nakla\/Sherpur",
"8803323", "Dagonbhuya",
"880341", "Eidgaon\/Cox\'s\ bazar",
"8806223", "Dohar",
"880628", "Narsingdi\/Palash\ \(Ghorasal\)\/Shibpur",
"8806527", "Singair",
"8806724", "Bandar",
"880851", "Brahmanbaria\/Nabinagar",
"8803425", "Ramu",
"880352", "Kaptai",
"880433", "Banaripara",
"8807825", "Shibgonj",
"880316", "Chittagong",
"8806723", "Sonargaon",
"8803324", "Parshuram\/Parsuram",
"880781", "Rahanpur\/Shibganj\/Chapai\ Nobabganj",
"8806224", "Keranigonj",
"88044862", "Barguna",
"8806922", "Gazaria",
"88082298", "Jaintapur",
"880491", "Bhola",
"8805327", "Fulbari",
"8804925", "Lalmohan",
"8804326", "Muladi",
"880561", "Thakurgoan",
"8804652", "Bagerhat",
"8805424", "Palashbari",
"88025", "Dhaka",
"8804228", "Sharsa",
"8804657", "Rampal",
"8804223", "Bagerphara",
"880381", "Laximpur\/Ramganj",
"880651", "Maninganj\/Singair\/Daulatpur\/Shibalaya",
"8803422", "Chokoria\/Chakaria",
"880482", "Lohagara",
"8805329", "Bangla\ hili",
"8806024", "GoshairHat",
"8803427", "Ukhiya",
"8808223", "Bianibazar",
"8808224", "Biswanath",
"8806925", "Sreenagar",
"8806023", "Damudda",
"880921", "Tangail",
"88092328", "Shakhipur",
"8804020", "Rupsha",
"880691", "Munsigonj\/Tongibari",
"880317", "Chittagong",
"8804922", "Borhanuddin",
"8804224", "Chaugacha",
"8805325", "Shetabgonj",
"880741", "Nagoan\/Santahar",
"88029", "Dhaka",
"88079", "Meherpur",
"8804626", "Nazirpur",
"880318", "Chittagong",
"88091", "Mymensingh",
"880531", "Dianjpur\/Parbitipur\/Hakimpur\ \(Hili\)",
"8809233", "Tangail",
"8807425", "Manda",
"8804225", "Jhikargacha",
"88081", "Homna\/Comilla",
"8804455", "Pathorghata",
"880421", "Sharsa\ \(Benapol\)",
"88098", "Jamalpur\/Islampur\/Dewanganj",
"8803823", "Ramgati\ \(Alexender\)",
"8806924", "Sirajdikhan",
"880862", "Baralekha\/Komalgonj\/Kulaura\/Rajnagar\/Sreemongal",
"88041", "Khulna",
"8806222", "Dhamrai",
"8803322", "Chhagalnaiya",
"8808225", "Sylhet",
"88044863", "Barguna",
"8806722", "Araihazar\/Arihazar",
"880601", "Shariatpur\ Naria",
"8806923", "Lohajang",
"880871", "Sunamganj",
"8806524", "Zitka",
"8804027", "Paikgacha",
"880552", "Saidpur\/Syedpur",
"88059", "Lalmonirhat",
"880495", "Nalcity",
"88070", "Bheramara",
"8803824", "Ramgonj",
"880731", "Pabna\ \ Bera",
"88092325", "Tangail",
"880565", "Boda",
"8805323", "Birgonj\/Gobindagonj\/Birganj",
"880541", "Gaibandha\/Gabindaganj",
"8804227", "Manirampur",
"88075265", "Sirajganj",
"8804658", "Mongla\,\ Bagerhat",
"8804653", "Fakirhat",
"8803036", "Satkania\/Satkhania",
"8804222", "Abhaynagar\ \(Noapara\)",
"8804523", "Kaligonj",
"8804924", "Daulatkhan",
"880832", "Chunarughat\/Madabpur\/Nabiganj",
"880331", "Feni\/Sonagazi\/Chagalnaiya\/Daganbhuyan",
"8808227", "Golapgonj",
"8803325", "Sonagazi",
"8806225", "Nowabgonj",
"8804029", "Terokhada",
"8808222", "Balagonj",
"880581", "Kurigram",
"8807823", "Rohanpur",
"8803424", "Moheshkhali",
"880942", "Bajitpur\/Bhairabbazar\/Itna\/Kotiadhi",
"8806725", "Rupganj\/Rupgonj",
"88027", "Dhaka",
"880498", "Jhalakati",
"880761", "Chuadanga",
"8804654", "Kachua",
"88082295", "Sylhet",
"8804426", "Baufal\/Mirjagonj",
"880568", "Panchagar\/Tetulia",
"8804327", "Babugonj",
"8804625", "Mothbaria",
"88047", "Satkhira",
"8805326", "Chrirbandar",
"8804322", "Goarnadi",
"880461", "Pirojpur",
"8805023", "Dhunat",
"8807524", "Sirajgonj",
"8805028", "Shariakandi",
"88044235", "Dashmina\,\ Patuakhali",
"880488", "Magura\/Mohammadpur",
"880631", "Faridpur",
"88072295", "Rajshahi",
"8806423", "Goalanda",
"880321", "Noakhali\/Chatkhil",
"8806926", "Tongibari",
"8803225", "Shenbag\/Senbag",
"8806253", "Monahardi\/Monohordi",
"880861", "Maulavibazar\/Rajnagar",
"8806254", "Palash",
"880872", "Chatak\/Dharmapasha\/Jaganathpur\/Jagonnathpur",
"88072288", "Baneswar",
"880371", "Khagrachari",
"88075228", "Sirajgonj",
"8803022", "Fatikchari",
"88036", "Bandarban",
"8806424", "Pangsha",
"8803027", "Snadwip",
"8807523", "Sirajgonj",
"8805024", "Dhupchachia",
"88072255", "Rajshahi",
"880551", "Nilphamari\/Domar",
"880732", "Bera\/Chatmohar\/Faridpur\/Ishwardi\/Shathiya\/Sathia\/Bhangura\/Sujanagar",
"8807227", "Paba",
"8804627", "Swarupkhati",
"88075298", "Sirajgonj",
"880903", "Mymensingh",
"8803029", "Anwara",
"8805224", "Haragacha",
"8803034", "Lohagara",
"8804325", "Mehendigonj",
"880771", "Natore",
"8806823", "Kaliganj",
"880431", "Barisal",
"8804423", "Baufal\/Mirjagonj",
"88074267", "Nagoan",
"880485", "Sreepur",
"88095", "Netrokona",
"880661", "Madaripur",
"8803222", "Chatkhil",
"8808217", "Sylhet\ MEA",
"8805020", "Sibgonj\ \(Mokamtala\)",
"880831", "Habiganj",
"8806327", "Nagarkanda",
"880802", "Chauddagram\/Chandina\/Chandiana\/Daudkandi\/Debidwar\/Homna\/Muradnagar\/Brahmanpara\/Barura\/Burichang",
"880941", "Kishoreganj\/Tarail",
"88075258", "Sirajgonj",
"880582", "Nageswari",
"8804329", "Uzirpur",
"8803025", "Rangunia",
"88071", "Kushtia",
"88075285", "Sirajganj",
"880721", "Rajshahi",
"8806824", "Kapashia",
"8804656", "Morelganj",
"8804424", "Baufal\/Mirjagonj",
"880762", "Alamdanga",
"8803033", "Chandanaish",};

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+880|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self if ($self->is_valid());
      $number =~ s/^(?:0)//;
      $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self->is_valid() ? $self : undef;
    }
1;