#!/usr/bin/perl -w

# <����>
# Yahoo! �˥塼��TOPICS��RSS��������ơ��֥��ѡ��ĤȤ���ɽ���Ǥ���褦�˲ù�����ץ����
# cron�ˤ���ʬ��1��ѡ��Ĥ���ޤ�������������ݤʤΤǥ�����쥯�ȤǹԤ��褦�ˤ��Ƥ��ޤ���

use strict;
use warnings;
use LWP::Simple;
use XML::Simple;
use Data::Dumper;

my $rss = "http://dailynews.yahoo.co.jp/fc/rss.xml";

my $doc = get($rss);

my $xml = XMLin($doc);

# for test
##print $xml;                              # ��������XML���Τ�Τ�DUMP
##print Dumper($xml);                      # ��������XML���Τ�DUMP
##print Dumper($xml->{channel}->{item});   # item�۲���DUMP
##foreach my $i ( @{$xml->{channel}->{item}} ) {    # $xml->{channel}->{item}��ǥ�ե���󥹤��Ƥ��ޤ�
##	print Dumper($i->{link});
##}

my $str = "<div><ul>"."\n";
foreach my $i ( @{$xml->{channel}->{item}} ) {    # $xml->{channel}->{item}��ǥ�ե���󥹤��Ƥ��ޤ�
	$str .= "<li><a href=\"" . $i->{link} . "\">" . $i->{title} . "</a></li>"."\n";
}
$str .= "</ul></div>"."\n";

print $str;

