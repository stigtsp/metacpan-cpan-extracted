#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::En, 'Can use locale file Locale::CLDR::Locales::En';
use ok Locale::CLDR::Locales::En::Any::Ky, 'Can use locale file Locale::CLDR::Locales::En::Any::Ky';
use ok Locale::CLDR::Locales::En::Any::Sz, 'Can use locale file Locale::CLDR::Locales::En::Any::Sz';
use ok Locale::CLDR::Locales::En::Any::Ie, 'Can use locale file Locale::CLDR::Locales::En::Any::Ie';
use ok Locale::CLDR::Locales::En::Any::Vc, 'Can use locale file Locale::CLDR::Locales::En::Any::Vc';
use ok Locale::CLDR::Locales::En::Any::Sb, 'Can use locale file Locale::CLDR::Locales::En::Any::Sb';
use ok Locale::CLDR::Locales::En::Any::Ug, 'Can use locale file Locale::CLDR::Locales::En::Any::Ug';
use ok Locale::CLDR::Locales::En::Any::Je, 'Can use locale file Locale::CLDR::Locales::En::Any::Je';
use ok Locale::CLDR::Locales::En::Any::Us::Posix, 'Can use locale file Locale::CLDR::Locales::En::Any::Us::Posix';
use ok Locale::CLDR::Locales::En::Any::Cc, 'Can use locale file Locale::CLDR::Locales::En::Any::Cc';
use ok Locale::CLDR::Locales::En::Any::Tc, 'Can use locale file Locale::CLDR::Locales::En::Any::Tc';
use ok Locale::CLDR::Locales::En::Any::Gb, 'Can use locale file Locale::CLDR::Locales::En::Any::Gb';
use ok Locale::CLDR::Locales::En::Any::Ke, 'Can use locale file Locale::CLDR::Locales::En::Any::Ke';
use ok Locale::CLDR::Locales::En::Any::Ag, 'Can use locale file Locale::CLDR::Locales::En::Any::Ag';
use ok Locale::CLDR::Locales::En::Any::Vg, 'Can use locale file Locale::CLDR::Locales::En::Any::Vg';
use ok Locale::CLDR::Locales::En::Any::My, 'Can use locale file Locale::CLDR::Locales::En::Any::My';
use ok Locale::CLDR::Locales::En::Any::Bz, 'Can use locale file Locale::CLDR::Locales::En::Any::Bz';
use ok Locale::CLDR::Locales::En::Any::Za, 'Can use locale file Locale::CLDR::Locales::En::Any::Za';
use ok Locale::CLDR::Locales::En::Any::Bb, 'Can use locale file Locale::CLDR::Locales::En::Any::Bb';
use ok Locale::CLDR::Locales::En::Any::Tz, 'Can use locale file Locale::CLDR::Locales::En::Any::Tz';
use ok Locale::CLDR::Locales::En::Any::Sg, 'Can use locale file Locale::CLDR::Locales::En::Any::Sg';
use ok Locale::CLDR::Locales::En::Any::Dg, 'Can use locale file Locale::CLDR::Locales::En::Any::Dg';
use ok Locale::CLDR::Locales::En::Any::Na, 'Can use locale file Locale::CLDR::Locales::En::Any::Na';
use ok Locale::CLDR::Locales::En::Any::Sc, 'Can use locale file Locale::CLDR::Locales::En::Any::Sc';
use ok Locale::CLDR::Locales::En::Any::Pg, 'Can use locale file Locale::CLDR::Locales::En::Any::Pg';
use ok Locale::CLDR::Locales::En::Any::Gg, 'Can use locale file Locale::CLDR::Locales::En::Any::Gg';
use ok Locale::CLDR::Locales::En::Any::Io, 'Can use locale file Locale::CLDR::Locales::En::Any::Io';
use ok Locale::CLDR::Locales::En::Any::Nr, 'Can use locale file Locale::CLDR::Locales::En::Any::Nr';
use ok Locale::CLDR::Locales::En::Any::Cm, 'Can use locale file Locale::CLDR::Locales::En::Any::Cm';
use ok Locale::CLDR::Locales::En::Any::Vi, 'Can use locale file Locale::CLDR::Locales::En::Any::Vi';
use ok Locale::CLDR::Locales::En::Any::Ai, 'Can use locale file Locale::CLDR::Locales::En::Any::Ai';
use ok Locale::CLDR::Locales::En::Any::Sh, 'Can use locale file Locale::CLDR::Locales::En::Any::Sh';
use ok Locale::CLDR::Locales::En::Any::Bm, 'Can use locale file Locale::CLDR::Locales::En::Any::Bm';
use ok Locale::CLDR::Locales::En::Any::Um, 'Can use locale file Locale::CLDR::Locales::En::Any::Um';
use ok Locale::CLDR::Locales::En::Any::Au, 'Can use locale file Locale::CLDR::Locales::En::Any::Au';
use ok Locale::CLDR::Locales::En::Any::Vu, 'Can use locale file Locale::CLDR::Locales::En::Any::Vu';
use ok Locale::CLDR::Locales::En::Any::Gh, 'Can use locale file Locale::CLDR::Locales::En::Any::Gh';
use ok Locale::CLDR::Locales::En::Any::Bi, 'Can use locale file Locale::CLDR::Locales::En::Any::Bi';
use ok Locale::CLDR::Locales::En::Any::Ph, 'Can use locale file Locale::CLDR::Locales::En::Any::Ph';
use ok Locale::CLDR::Locales::En::Any::Hk, 'Can use locale file Locale::CLDR::Locales::En::Any::Hk';
use ok Locale::CLDR::Locales::En::Any::Sl, 'Can use locale file Locale::CLDR::Locales::En::Any::Sl';
use ok Locale::CLDR::Locales::En::Any::Lr, 'Can use locale file Locale::CLDR::Locales::En::Any::Lr';
use ok Locale::CLDR::Locales::En::Any::Ms, 'Can use locale file Locale::CLDR::Locales::En::Any::Ms';
use ok Locale::CLDR::Locales::En::Any::At, 'Can use locale file Locale::CLDR::Locales::En::Any::At';
use ok Locale::CLDR::Locales::En::Any::Ch, 'Can use locale file Locale::CLDR::Locales::En::Any::Ch';
use ok Locale::CLDR::Locales::En::Any::Fi, 'Can use locale file Locale::CLDR::Locales::En::Any::Fi';
use ok Locale::CLDR::Locales::En::Any::Gi, 'Can use locale file Locale::CLDR::Locales::En::Any::Gi';
use ok Locale::CLDR::Locales::En::Any::Dm, 'Can use locale file Locale::CLDR::Locales::En::Any::Dm';
use ok Locale::CLDR::Locales::En::Any::Ls, 'Can use locale file Locale::CLDR::Locales::En::Any::Ls';
use ok Locale::CLDR::Locales::En::Any::Kn, 'Can use locale file Locale::CLDR::Locales::En::Any::Kn';
use ok Locale::CLDR::Locales::En::Any::In, 'Can use locale file Locale::CLDR::Locales::En::Any::In';
use ok Locale::CLDR::Locales::En::Any::Fm, 'Can use locale file Locale::CLDR::Locales::En::Any::Fm';
use ok Locale::CLDR::Locales::En::Any::Gu, 'Can use locale file Locale::CLDR::Locales::En::Any::Gu';
use ok Locale::CLDR::Locales::En::Any::Zw, 'Can use locale file Locale::CLDR::Locales::En::Any::Zw';
use ok Locale::CLDR::Locales::En::Any::Mw, 'Can use locale file Locale::CLDR::Locales::En::Any::Mw';
use ok Locale::CLDR::Locales::En::Any::Si, 'Can use locale file Locale::CLDR::Locales::En::Any::Si';
use ok Locale::CLDR::Locales::En::Any::Tt, 'Can use locale file Locale::CLDR::Locales::En::Any::Tt';
use ok Locale::CLDR::Locales::En::Any::Gm, 'Can use locale file Locale::CLDR::Locales::En::Any::Gm';
use ok Locale::CLDR::Locales::En::Any::Mo, 'Can use locale file Locale::CLDR::Locales::En::Any::Mo';
use ok Locale::CLDR::Locales::En::Any::Mp, 'Can use locale file Locale::CLDR::Locales::En::Any::Mp';
use ok Locale::CLDR::Locales::En::Any::Pr, 'Can use locale file Locale::CLDR::Locales::En::Any::Pr';
use ok Locale::CLDR::Locales::En::Any::Bs, 'Can use locale file Locale::CLDR::Locales::En::Any::Bs';
use ok Locale::CLDR::Locales::En::Any::Jm, 'Can use locale file Locale::CLDR::Locales::En::Any::Jm';
use ok Locale::CLDR::Locales::En::Any::Us, 'Can use locale file Locale::CLDR::Locales::En::Any::Us';
use ok Locale::CLDR::Locales::En::Any::Tk, 'Can use locale file Locale::CLDR::Locales::En::Any::Tk';
use ok Locale::CLDR::Locales::En::Any::Fj, 'Can use locale file Locale::CLDR::Locales::En::Any::Fj';
use ok Locale::CLDR::Locales::En::Any::Ck, 'Can use locale file Locale::CLDR::Locales::En::Any::Ck';
use ok Locale::CLDR::Locales::En::Any::Mh, 'Can use locale file Locale::CLDR::Locales::En::Any::Mh';
use ok Locale::CLDR::Locales::En::Any::150, 'Can use locale file Locale::CLDR::Locales::En::Any::150';
use ok Locale::CLDR::Locales::En::Any::Nl, 'Can use locale file Locale::CLDR::Locales::En::Any::Nl';
use ok Locale::CLDR::Locales::En::Any::To, 'Can use locale file Locale::CLDR::Locales::En::Any::To';
use ok Locale::CLDR::Locales::En::Any::Im, 'Can use locale file Locale::CLDR::Locales::En::Any::Im';
use ok Locale::CLDR::Locales::En::Any::As, 'Can use locale file Locale::CLDR::Locales::En::Any::As';
use ok Locale::CLDR::Locales::En::Any::Mt, 'Can use locale file Locale::CLDR::Locales::En::Any::Mt';
use ok Locale::CLDR::Locales::En::Any::Bw, 'Can use locale file Locale::CLDR::Locales::En::Any::Bw';
use ok Locale::CLDR::Locales::En::Any::Ki, 'Can use locale file Locale::CLDR::Locales::En::Any::Ki';
use ok Locale::CLDR::Locales::En::Any::Er, 'Can use locale file Locale::CLDR::Locales::En::Any::Er';
use ok Locale::CLDR::Locales::En::Any::Ws, 'Can use locale file Locale::CLDR::Locales::En::Any::Ws';
use ok Locale::CLDR::Locales::En::Any::Pn, 'Can use locale file Locale::CLDR::Locales::En::Any::Pn';
use ok Locale::CLDR::Locales::En::Any::Ss, 'Can use locale file Locale::CLDR::Locales::En::Any::Ss';
use ok Locale::CLDR::Locales::En::Any::Il, 'Can use locale file Locale::CLDR::Locales::En::Any::Il';
use ok Locale::CLDR::Locales::En::Any::Mu, 'Can use locale file Locale::CLDR::Locales::En::Any::Mu';
use ok Locale::CLDR::Locales::En::Any::Pw, 'Can use locale file Locale::CLDR::Locales::En::Any::Pw';
use ok Locale::CLDR::Locales::En::Any::Tv, 'Can use locale file Locale::CLDR::Locales::En::Any::Tv';
use ok Locale::CLDR::Locales::En::Any::Dk, 'Can use locale file Locale::CLDR::Locales::En::Any::Dk';
use ok Locale::CLDR::Locales::En::Any::Zm, 'Can use locale file Locale::CLDR::Locales::En::Any::Zm';
use ok Locale::CLDR::Locales::En::Any::Nu, 'Can use locale file Locale::CLDR::Locales::En::Any::Nu';
use ok Locale::CLDR::Locales::En::Any::Fk, 'Can use locale file Locale::CLDR::Locales::En::Any::Fk';
use ok Locale::CLDR::Locales::En::Any::001, 'Can use locale file Locale::CLDR::Locales::En::Any::001';
use ok Locale::CLDR::Locales::En::Any::Rw, 'Can use locale file Locale::CLDR::Locales::En::Any::Rw';
use ok Locale::CLDR::Locales::En::Any::Pk, 'Can use locale file Locale::CLDR::Locales::En::Any::Pk';
use ok Locale::CLDR::Locales::En::Any::Ca, 'Can use locale file Locale::CLDR::Locales::En::Any::Ca';
use ok Locale::CLDR::Locales::En::Any::Sd, 'Can use locale file Locale::CLDR::Locales::En::Any::Sd';
use ok Locale::CLDR::Locales::En::Any::Nf, 'Can use locale file Locale::CLDR::Locales::En::Any::Nf';
use ok Locale::CLDR::Locales::En::Any::Cy, 'Can use locale file Locale::CLDR::Locales::En::Any::Cy';
use ok Locale::CLDR::Locales::En::Any::Sx, 'Can use locale file Locale::CLDR::Locales::En::Any::Sx';
use ok Locale::CLDR::Locales::En::Any::Nz, 'Can use locale file Locale::CLDR::Locales::En::Any::Nz';
use ok Locale::CLDR::Locales::En::Any::Gd, 'Can use locale file Locale::CLDR::Locales::En::Any::Gd';
use ok Locale::CLDR::Locales::En::Any::Be, 'Can use locale file Locale::CLDR::Locales::En::Any::Be';
use ok Locale::CLDR::Locales::En::Any::Mg, 'Can use locale file Locale::CLDR::Locales::En::Any::Mg';
use ok Locale::CLDR::Locales::En::Any::Gy, 'Can use locale file Locale::CLDR::Locales::En::Any::Gy';
use ok Locale::CLDR::Locales::En::Any::Lc, 'Can use locale file Locale::CLDR::Locales::En::Any::Lc';
use ok Locale::CLDR::Locales::En::Any::De, 'Can use locale file Locale::CLDR::Locales::En::Any::De';
use ok Locale::CLDR::Locales::En::Any::Se, 'Can use locale file Locale::CLDR::Locales::En::Any::Se';
use ok Locale::CLDR::Locales::En::Any::Ng, 'Can use locale file Locale::CLDR::Locales::En::Any::Ng';
use ok Locale::CLDR::Locales::En::Any::Cx, 'Can use locale file Locale::CLDR::Locales::En::Any::Cx';
use ok Locale::CLDR::Locales::En::Any, 'Can use locale file Locale::CLDR::Locales::En::Any';

done_testing();
