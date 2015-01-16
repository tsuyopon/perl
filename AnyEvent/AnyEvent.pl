#/usr/bin/perl -w

use strict;
use AnyEvent::Util qw(fh_nonblocking);

fh_nonblocking( \*STDIN, 1 );


my $CPS_for_noodle = 0;

sub input_time_from_STDIN {
    my $cv = AnyEvent->condvar;
    my $w;

    print "�����������Ϥ��Ƥ�������\n";
    $w = AnyEvent->io(
        fh   => \*STDIN,
        poll => 'r',
        cb   => sub {
            undef $w;
            my $line = <STDIN>;
            $cv->send($line);
        }
    );
    return $cv;
}

sub count_timer {
    my $cv = AnyEvent->condvar;
    my $w;
    $w = AnyEvent->timer(
        after => $CPS_for_noodle,
        cb    => sub {
            print $CPS_for_noodle / 60, "ʬ�Ф��ޤ���!\n";
            undef $w;
            $cv->send;

        }
    );
    return $cv;
}


my $main_cv = AnyEvent->condvar;
{
    my $cv = input_time_from_STDIN();
    $cv->cb(
        sub {
            ($CPS_for_noodle) = $_[0]->recv;
            print "set ", $CPS_for_noodle / 60, " minutes\n\n";
            print "���褿��Ƥ֤��顢�Ȥꤢ�������ξ�����դ���\n";
            $main_cv->send;
        }
    );

}
$main_cv->recv;

$main_cv = AnyEvent->condvar;
{
    my $cv = count_timer($CPS_for_noodle);
    $cv->cb(
        sub {
            print "\a";
            print "�顼���Ǥ����衪\n";
            $main_cv->send;
        }
    );

}
$main_cv->recv;
