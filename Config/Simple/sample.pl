#!/usr/bin/perl
#
# See http://d.hatena.ne.jp/oranie/20110615/1308107264
#

use strict;
use warnings;

use Config::Simple;

my $config = new Config::Simple('./config.pm');
my $cfg = $config->vars();

#個別に代入
my $database = $cfg->{'config.database'};
my $user     = $cfg->{'config.user'};
my $pass     = $cfg->{'config.pass'};

print "$database\n";
print "$user\n";
print "$pass\n";

#ハッシュにしてみる
my %hash =  $config->vars();
foreach my $key ( keys %hash ) {
    print "key:$key : value:$hash{$key}", "\n";
}
