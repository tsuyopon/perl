#!/usr/bin/perl -w

# Smart::Comments����ץ�Ǥ�
# �ʲ��Υ��ޥ�ɤˤ��¹Ԥ��ޤ���
# $ perl -MSmart::Comments Smart_Comments.pl

use strict;
use warnings;

# place��now����Ÿ������ޤ�
### place: [<place>]
### [<now>] debug output

my $name = "taro";
# $name��ɽ�����ޤ�
### My name is: $name

my $data = {
	a => 10,
	c => {
		d => 13,
		e => 14,
	},
	b => 20,
};

# �����ϥå����ͤ�����dump����ޤ�
### $data

# loop���ƿ�Ľ����ɽ�����ޤ�
for(1..5){ ### loop [===  ] %
	  sleep 1;
}

my $min = 3;
my $max = 5;
my $result = 6;
# �ʲ��˥ޥå����ʤ��ä����ˤ������顼ɽ�����졣�ʹߤιԤϼ¹Ԥ���ʤ��ʤ�ޤ���
### require: $min < $result && $result < $max

print 'END';
