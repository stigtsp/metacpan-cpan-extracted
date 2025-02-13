#!/usr/bin/perl -w

use Test::More tests => 26;

BEGIN {
	if ($] >= 5.006){
		require Fcntl; Fcntl->import(qw/SEEK_END/);
	} else {
		require POSIX; POSIX->import(qw/SEEK_END/);
	}
}

BEGIN { use_ok("MPEG::Audio::Frame") }

{
	isa_ok(my $frame = MPEG::Audio::Frame->read(*DATA), "MPEG::Audio::Frame");
	ok($frame->bitrate, "bitrate");
	ok($frame->sample, "sample rate");
	is(length("$frame"), $frame->length, "actual length");
}
{
	isa_ok(my $frame = MPEG::Audio::Frame->read(*DATA), "MPEG::Audio::Frame");
	ok($frame->bitrate, "bitrate");
	ok($frame->sample, "sample rate");
	is(length("$frame"), $frame->length, "actual length");
}

is(MPEG::Audio::Frame->read(*DATA), undef, "no more data on FH");

my $n = 15;
for (0 .. $n){
	seek DATA, -$_, SEEK_END;
	is(MPEG::Audio::Frame->read(*DATA), undef, "nothing $_ bytes before EOF");
}

__DATA__

this is lots of junk, and a few frames in the middle. We're supposed to get
only the frames, and nothing else.


���� ���� ���� ���� ���� ���� �)3M牫��T��%�{�ol�MQ��"y��op�7��X7���q�{�xa-��A�?&f�YQ�6���@ o��($:�P�o6�JC����<��cY�M^�������]?�����WT;~e�b!�a�%ߡ�ё��:�J�:���}��v"���D�0� .�A�������b�PQxao��G�PZmH)"*�4@q��X���`  
��O�V` ��
tƜ $U�>��Z/(Þ� ��M����G0�C�$�A�B�8�hA2$)31a�,/��˕Đv�r`H� "(�B!�`б 4d�# ���p<��,�.�b0n�����EJ��!������!��0`Y)��Ь�D�@�}���B( lx:p1R�1�� $��	Qy|���t�\�b~"�6&�

dgskjhag
������?H&N ?�H?�He�"=?
j��K�??c��:#f;+\?�o>?��5g��bq�O�
P(�%1s���????�?��&.A�"69�O��?�'l??���������������?�����??��?y+?a*r.W"?S����"��P�hO?f�?����������P?r.nE��|?n\.x
Si���*��o�G�@0��<N��?o|? �Y?8���	L\��?1da8?�?�?,?�"�9 ??�?,��"c0A
??@�?�?���?x�?�??6A��r??��������?�?�7 ?P??_7?p?0?0?
?D?=1s��A%Yh???R?�?O??�A0�=A?�E$�???�afbI%EM$??ffk�RUUz�?��U?j��[?<L�)??}JU�?}k�o<���?�?ZC#��3[G�����2?�.lӠ�5�5Ts��eC��4�VUo�?khY?4u0�L<
(�F?h"?��̰T�B??8�ӵ?���T?4�S?S3???��C�?�??5Egh??�??�&�?.
��|p�?�u-�:??[^���R�ߨ?Mm?�?e$?��MTP���
�y
:?~]��9�&oR�L�P?FP6��]���A>etMC#��=3?L�sBphq??\�`�YF
	?�0�???��sh>���!h?�BY�t?�4b��?��`Y�?(nQ?&<����

dgk���uwj more �ʬĩϫga�I(�Q�-��k��D1�E2��	H�t�_D�h:�i��DШ]iD�I���i ��x[ƨ̊Q�YlԐ,����}_��QuN����E(��_��     %��Fpa��R����y�7/��Tp�务�YI�(F6vaᒧ�d��b�.YtS<�%S
����y7K!��lx��0T�����}h���gfy��)�4٩ ���� ���� ���� ���� ���� ����
