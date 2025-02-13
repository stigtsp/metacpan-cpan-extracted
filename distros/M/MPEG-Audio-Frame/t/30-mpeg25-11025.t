#!/usr/bin/perl -w

use strict;

my $n;
use Test::More tests => ($n = 19) * 6 + 4;
use lib "t/lib";
use Test::FloatNear;

BEGIN { use_ok("MPEG::Audio::Frame") };

my $s = 0;
for (1 .. $n){
	isa_ok(my $frame = MPEG::Audio::Frame->read(*DATA), "MPEG::Audio::Frame", "frame $_");
	ok($frame->mpeg25, "MPEG 2.5");
	ok($frame->layer3, "layer III");
	ok(!$frame->broken, "frame is not broken");
	is($frame->sample, 11025, "sample rate");
	is($frame->length, length("$frame"), "actual frame is as large as calced");
	$s += $frame->seconds;
}

is_near($s, 0.992653061224489, "total duration is correct");

is(MPEG::Audio::Frame->read(*DATA), undef, "nothing left on __DATA__");
ok(eof(DATA), "eof(DATA)");

__DATA__
�� � ���˂h    Oc�7���M�M7���	�`?�2\�'� (7����&�����td�t?���A�Mˆ$�(�?������A��q��������}<8��"��{_�  ���f��E?KgeWw-��!�T�u��~�a�p�����]�ft�[-v9���[����������$�U������yp�*�>9&ʣ3�� ��~�^AD����*�������`�o��2���JZ��Tm~�uB3������?�����(f��.0��o��@��x�$��6A��Z�1ЇQ�zs�߹�Z���"�#�~�^AJ�����QT�m�+�����Ҥ�׳��O� �#�����������/��*����rƠ}���@���Z��;�̒\ �r�T"����O��0���� �,[~�^@������vvugggc�����y������J������(�-5�]��`����L�H9A�~<��FW��Af��g�*+��� �0�b������v��F��"�5�z�^0��{���C�D�3?����M������`���*����PE��I �)���Y��k�N�V���D�}�X�G����Å�����n���:�q�O������� �A{~�^H�������>g�L�5��m�P`��s��=?,�ﱳ!��ъ��w,�G����d��������J9�Q��sN4ӍJ?������������"�N3z�^0��=�d���u\ �VXH�q�0�m1�ɲ*N�)�3��ś7��p��r�2�����Wu���Sl���ڛ�����4������:��m
�]��AF��� �Y[z�1ڼ�����D%H��b�g.��Ͳ�F����l�������5.��Wپ���$������;Hu�����g�������� ���(����"�b���^2������i���XɆ�J�T������r
_����gZ�kI���������������A�&j����@ ����ǲu}Cic��?ܬ����� �k~�^2��i��ɻ��/���|5���O�������\�������7������9$�	�ZG�vxyxvh �r�K!��4R�	�5U5�$x��<V��"�u�z�^yڼ̳s�ۿ��T����Wg������������@[������?�IӌM�}��@����b��$�nkBUH"�#ME�����o�_�z;?�Y�A��� Ăkz�Iڼ������:������⻿�����X��07S�	�����G'k�/����K.~�V�G�lɞ��[-I;/�����у���A��������{,������"ċî�VL�����_�������/�̓��Xww�f ԭ�5M���P|x�u�L�5*�=yc��s����q���x�K�������{�����ao�� Ę;��Fd������H-��Uz����j�F��A��K��O����W,I�B�;Y�����/_�'��5'o��j��ﳷ9H[�����c������ &&���"ĢKz�z���-v�z��b�6(�4��,�$�~H���I[����n�#e��Yo��AS���N��RS���l���[=mS�2��{�o���Y9����u����� Ĭs~�`��4�-_�PT�5͊U���_�������/�p�P����bC�k��.x8"��KK���~<8e�PP���O��
!j*�R���瞆���"ĵ�z��Ih ��+,����/����"b�pP����U^VX�P�`������ 
a،3��A�B�Ҥ���LAME3.89 (beta)UUUUUUUUU�� Į%c���@UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU
