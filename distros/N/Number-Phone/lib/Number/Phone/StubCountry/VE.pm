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
package Number::Phone::StubCountry::VE;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20220601185320;

my $formatters = [
                {
                  'format' => '$1-$2',
                  'leading_digits' => '[24-689]',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{7})'
                }
              ];

my $validators = {
                'fixed_line' => '
          (?:
            2(?:
              12|
              3[457-9]|
              [467]\\d|
              [58][1-9]|
              9[1-6]
            )|
            [4-6]00
          )\\d{7}
        ',
                'geographic' => '
          (?:
            2(?:
              12|
              3[457-9]|
              [467]\\d|
              [58][1-9]|
              9[1-6]
            )|
            [4-6]00
          )\\d{7}
        ',
                'mobile' => '
          4(?:
            1[24-8]|
            2[46]
          )\\d{7}
        ',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '(90[01]\\d{7})|(501\\d{7})',
                'toll_free' => '800\\d{7}',
                'voip' => ''
              };
my %areanames = ();
$areanames{en} = {"58269", "Falcón",
"58267", "Zulia",
"58294", "Sucre",
"58292", "Anzoátegui\/Monagas",
"58296", "Amazonas",
"58258", "Cojedes",
"58295", "Nueva\ Esparta",
"5821", "Caracas\/Miranda\/Vargas",
"58253", "Lara\/Yaracuy",
"58261", "Zulia",
"58240", "Apure\/Barinas",
"58276", "Táchira",
"58272", "Trujillo",
"58274", "Mérida",
"58275", "Táchira\/Mérida\/Zulia",
"58291", "Monagas",
"58279", "Falcón",
"58238", "Guárico",
"58243", "Aragua\/Carabobo",
"58277", "Táchira\/Mérida",
"58288", "Bolívar",
"58271", "Mérida\/Trujillo\/Zulia",
"58283", "Anzoátegui",
"58266", "Zulia",
"58262", "Zulia",
"58248", "Amazonas",
"58264", "Zulia",
"58265", "Zulia",
"58239", "Miranda",
"58287", "Delta\ Amacuro\/Monagas",
"58278", "Apure\/Barinas",
"58237", "Federal\ Dependencies",
"58293", "Sucre",
"58289", "Bolívar",
"58241", "Carabobo",
"58252", "Lara",
"58256", "Portuguesa",
"58254", "Yaracuy",
"58255", "Portuguesa",
"58247", "Apure\/Barinas\/Guárico",
"58281", "Anzoátegui",
"58273", "Barinas",
"58249", "Carabobo",
"58245", "Carabobo",
"58257", "Portuguesa",
"58268", "Falcón",
"58246", "Aragua\/Guárico",
"58242", "Carabobo",
"58244", "Aragua",
"58259", "Falcón",
"58284", "Bolívar",
"58286", "Anzoátegui\/Bolívar",
"58282", "Anzoátegui",
"58285", "Anzoátegui\/Bolívar",
"58234", "Miranda",
"58263", "Zulia",
"58251", "Lara\/Yaracuy",
"58235", "Anzoátegui\/Bolívar\/Guárico",};
$areanames{es} = {"58277", "Mérida\/Táchira",
"5821", "Distrito\ Capital\/Miranda\/Vargas",
"58275", "Mérida\/Táchira\/Zulia",
"58237", "Dependencias\ Federales",};

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+58|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self if ($self->is_valid());
      $number =~ s/^(?:0)//;
      $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self->is_valid() ? $self : undef;
    }
1;