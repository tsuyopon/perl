#!/usr/bin/perl -w
####################################################
# イベント駆動型プログラミングAnyEvent
#   タイマーウォッチャーとHTTPイベントの利用方法
####################################################

use strict;
use AnyEvent;
use AnyEvent::HTTP;

# タイマーウォッチャー
my $cv = AnyEvent->condvar;         # コンディション変数を定義
my $w; $w = AnyEvent->timer(
    after => 5,                     # 5秒経過したらイベント発生
    cb => sub {                     # イベント発生時にこの関数が呼ばれる(cb: callbackの略称)
        warn "5 seconds";
        undef $w;
        $cv->send;                  # タイマーが起動したらお知らせを「$cv->recv」に送付する
    }
);
$cv->recv;                          # コールバック(ここでは5秒するまで)先には進まない(イベントループ)

# HTTPイベント
$cv = AnyEvent->condvar;
my $guard; $guard = http_get 'http://www.yahoo.co.jp/' => sub {
    my ($body, $headers) = @_;
    undef $guard;
    print $body;
    $cv->send;
};
$cv->recv;
