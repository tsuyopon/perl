#!/usr/bin/perl -w

# <説明>
# Yahoo! ニュースTOPICS用RSSを取得して、ブログパーツとして表示できるように加工するプログラム
# cronによる数分に1回パーツを作ります。出力先は面倒なのでリダイレクトで行うようにしています。

use strict;
use warnings;
use LWP::Simple;
use XML::Simple;
use Data::Dumper;

my $rss = "http://dailynews.yahoo.co.jp/fc/rss.xml";

my $doc = get($rss);

my $xml = XMLin($doc);

# for test
##print $xml;                              # 取得したXMLそのもののDUMP
##print Dumper($xml);                      # 取得したXML全体のDUMP
##print Dumper($xml->{channel}->{item});   # item配下のDUMP
##foreach my $i ( @{$xml->{channel}->{item}} ) {    # $xml->{channel}->{item}をデリファレンスしています
##	print Dumper($i->{link});
##}

my $str = "<div><ul>"."\n";
foreach my $i ( @{$xml->{channel}->{item}} ) {    # $xml->{channel}->{item}をデリファレンスしています
	$str .= "<li><a href=\"" . $i->{link} . "\">" . $i->{title} . "</a></li>"."\n";
}
$str .= "</ul></div>"."\n";

print $str;

