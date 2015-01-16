#!/usr/bin/perl -w

# Smart::Commentsサンプルです
# 以下のコマンドにより実行します。
# $ perl -MSmart::Comments Smart_Comments.pl

use strict;
use warnings;

# placeやnow等は展開されます
### place: [<place>]
### [<now>] debug output

my $name = "taro";
# $nameを表示します
### My name is: $name

my $data = {
	a => 10,
	c => {
		d => 13,
		e => 14,
	},
	b => 20,
};

# 配列やハッシュ値は全てdumpされます
### $data

# loopして進捗割合を表示します
for(1..5){ ### loop [===  ] %
	  sleep 1;
}

my $min = 3;
my $max = 5;
my $result = 6;
# 以下にマッチしなかった場合にだけエラー表示され。以降の行は実行されなくなります。
### require: $min < $result && $result < $max

print 'END';
