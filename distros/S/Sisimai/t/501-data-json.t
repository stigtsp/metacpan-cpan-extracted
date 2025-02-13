use strict;
use Test::More;
use lib qw(./lib ./blib/lib);

my $PackageName = 'Sisimai::Data::JSON';
my $MethodNames = {
    'class' => ['dump'],
    'object' => [],
};

use_ok $PackageName;
can_ok $PackageName, @{ $MethodNames->{'class'} };

MAKE_TEST: {
    use Sisimai::Data;
    use Sisimai::Mail;
    use Sisimai::Message;
    use JSON;

    is $PackageName->dump('json'), undef;

    my $file = './set-of-emails/maildir/bsd/lhost-sendmail-02.eml';
    my $mail = Sisimai::Mail->new($file);
    my $mesg = undef;
    my $data = undef;
    my $list = undef;
    my $json = undef;
    my $perl = undef;

    while( my $r = $mail->data->read ){ 
        $mesg = Sisimai::Message->new('data' => $r); 
        $data = Sisimai::Data->make('data' => $mesg, 'origin' => $mail->data->path); 
        isa_ok $data, 'ARRAY';

        for my $e ( @$data ) {
            $json = $e->dump('json');       ok length $json, '->dump()';
            $perl = JSON::from_json($json); isa_ok $perl, 'HASH';

            is $e->token, $perl->{'token'}, 'token = '.$e->token;
            is $e->lhost, $perl->{'lhost'}, 'lhost = '.$e->lhost;
            is $e->rhost, $perl->{'rhost'}, 'rhost = '.$e->rhost;
            is $e->alias, $perl->{'alias'}, 'alias = '.$e->alias;

            is $e->listid, $perl->{'listid'}, 'listid = '.$e->listid;
            is $e->reason, $perl->{'reason'}, 'reason = '.$e->reason;

            is $e->subject, $perl->{'subject'};
            is $e->timestamp->epoch, $perl->{'timestamp'}, 'timestamp->epoch = '.$e->timestamp->epoch;
            is $e->replycode, $perl->{'replycode'};

            is $e->addresser->address, $perl->{'addresser'}, 'addresser->address = '.$e->addresser->address;
            is $e->addresser->host, $perl->{'senderdomain'}, 'senderdomain = '.$e->senderdomain;
            is $e->recipient->address, $perl->{'recipient'}, 'recipient->address = '.$e->recipient->address;
            is $e->recipient->host, $perl->{'destination'}, 'destination = '.$e->destination;

            is $e->messageid, $perl->{'messageid'}, 'messageid = '.$e->messageid;
            is $e->smtpagent, $perl->{'smtpagent'}, 'smtpagent = '.$e->smtpagent;
            is $e->softbounce, $perl->{'softbounce'}, 'softbouce = '.$e->softbounce;
            is $e->smtpcommand, $perl->{'smtpcommand'}, 'smtpcommand = '.$e->smtpcommand;

            is $e->diagnosticcode, $perl->{'diagnosticcode'}, 'diagnosticcode = '.$e->diagnosticcode;
            is $e->diagnostictype, $perl->{'diagnostictype'}, 'diagnostictype = '.$e->diagnostictype;
            is $e->deliverystatus, $perl->{'deliverystatus'}, 'deliverystatus = '.$e->deliverystatus;
            is $e->timezoneoffset, $perl->{'timezoneoffset'}, 'timezoneoffset = '.$e->timezoneoffset;

            is $e->feedbacktype, $perl->{'feedbacktype'}, 'feedbacktype = '.$e->feedbacktype;
            is $e->action, $perl->{'action'}, 'action = '.$e->action;
            is $e->origin, $perl->{'origin'}, 'origin = '.$e->origin;
        }
    }
}
done_testing;

