#!/usr/bin/perl -w
####################################################
# ���٥�ȶ�ư���ץ���ߥ�AnyEvent
#   �����ޡ������å��㡼��HTTP���٥�Ȥ�������ˡ
####################################################

use strict;
use AnyEvent;
use AnyEvent::HTTP;

# �����ޡ������å��㡼
my $cv = AnyEvent->condvar;         # ����ǥ�������ѿ������
my $w; $w = AnyEvent->timer(
    after => 5,                     # 5�÷вᤷ���饤�٥��ȯ��
    cb => sub {                     # ���٥��ȯ�����ˤ��δؿ����ƤФ��(cb: callback��ά��)
        warn "5 seconds";
        undef $w;
        $cv->send;                  # �����ޡ�����ư�����餪�Τ餻���$cv->recv�פ����դ���
    }
);
$cv->recv;                          # ������Хå�(�����Ǥ�5�ä���ޤ�)��ˤϿʤޤʤ�(���٥�ȥ롼��)

# HTTP���٥��
$cv = AnyEvent->condvar;
my $guard; $guard = http_get 'http://www.yahoo.co.jp/' => sub {
    my ($body, $headers) = @_;
    undef $guard;
    print $body;
    $cv->send;
};
$cv->recv;
