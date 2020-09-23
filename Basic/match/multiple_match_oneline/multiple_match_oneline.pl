#!/usr/bin/perl

# 1行の中にマッチさせたい文字列が複数存在する可能性がある場合

while (my $line = <STDIN>){
	print $line;
	while($line =~ /pparam=(\/home\/.*?)[ |\n]/g) {
		print $1."\n";
	} 
}

