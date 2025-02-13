package QQ::weixin::work::batch;

=encoding utf8

=head1 Name

QQ::weixin::work::batch

=head1 DESCRIPTION

=cut

use strict;
use base qw(QQ::weixin::work);
use Encode;
use LWP::UserAgent;
use JSON;
use utf8;

our $VERSION = '0.06';
our @EXPORT = qw/ invite /;

=head1 FUNCTION

=head2 invite(access_token, hash);

邀请成员

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/90975>

=head3 请求说明：

企业可通过接口批量邀请成员使用企业微信，邀请后将通过短信或邮件下发通知。

=head4 请求包结构体为：

    {
      "user" : ["UserID1", "UserID2", "UserID3"],
      "party" : [PartyID1, PartyID2],
      "tag" : [TagID1, TagID2]
    }

=head4 参数说明：

    参数	必须	说明
    access_token	是	调用接口凭证
    user	否	成员ID列表, 最多支持1000个。
    party	否	部门ID列表，最多支持100个。
    tag	否	标签ID列表，最多支持100个。

=head3 权限说明

须拥有指定成员、部门或标签的查看权限。
第三方仅通讯录应用可调用。

=head3 RETURN 返回结果

    {
    	"errcode": 0,
    	"errmsg": "ok",
		"invaliduser" : ["UserID1", "UserID2"],
		"invalidparty" : [PartyID1, PartyID2],
		"invalidtag": [TagID1, TagID2]
    }

=head4 RETURN 参数说明

    参数	    说明
    errcode	返回码
    errmsg	对返回码的文本描述内容
    invaliduser	非法成员列表
    invalidparty	非法部门列表
    invalidtag	非法标签列表

=head3 更多说明

user, party, tag三者不能同时为空；
如果部分接收人无权限或不存在，邀请仍然执行，但会返回无效的部分（即invaliduser或invalidparty或invalidtag）;
同一用户只须邀请一次，被邀请的用户如果未安装企业微信，在3天内每天会收到一次通知，最多持续3天。
因为邀请频率是异步检查的，所以调用接口返回成功，并不代表接收者一定能收到邀请消息（可能受上述频率限制无法接收）。

=cut

sub invite {
    if ( @_ && $_[0] && ref $_[1] eq 'HASH' ) {
        my $access_token = $_[0];
        my $json = $_[1];
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        $ua->env_proxy;

        my $response = $ua->post("https://qyapi.weixin.qq.com/cgi-bin/batch/invite?access_token=$access_token",Content => to_json($json,{allow_nonref=>1}),Content_type =>'application/json');
        if ($response->is_success) {
            return from_json($response->decoded_content,{utf8 => 1, allow_nonref => 1});
        }

    }
    return 0;
}

1;
__END__
