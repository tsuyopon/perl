#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use Graph::Easy;

my $graph = Graph::Easy->new();
$graph->add_edge_once ('AAA', 'BBB');
$graph->add_edge_once ('test', 'test2');
$graph->add_edge_once ('BBB', 'test2');
print $graph->as_ascii();

