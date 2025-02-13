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
package Number::Phone::StubCountry::QA;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20220601185319;

my $formatters = [
                {
                  'format' => '$1 $2',
                  'leading_digits' => '
            2[126]|
            8
          ',
                  'pattern' => '(\\d{3})(\\d{4})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '[2-7]',
                  'pattern' => '(\\d{4})(\\d{4})'
                }
              ];

my $validators = {
                'fixed_line' => '
          4141\\d{4}|
          (?:
            23|
            4[04]
          )\\d{6}
        ',
                'geographic' => '
          4141\\d{4}|
          (?:
            23|
            4[04]
          )\\d{6}
        ',
                'mobile' => '
          (?:
            2[89]|
            [35-7]\\d
          )\\d{6}
        ',
                'pager' => '
          2(?:
            [12]\\d|
            61
          )\\d{4}
        ',
                'personal_number' => '',
                'specialrate' => '',
                'toll_free' => '
          800\\d{4}(?:
            \\d{2}
          )?
        ',
                'voip' => ''
              };

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+974|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, }, $class);
        return $self->is_valid() ? $self : undef;
    }
1;