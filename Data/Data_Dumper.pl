#!/usr/bin/perl -w
use Data::Dumper;

package Foo;
sub new {bless {'a' => 1, 'b' => sub { return "foo" }}, $_[0]};

package Fuz;                       # a weird REF-REF-SCALAR object
sub new {bless \($_ = \ 'fu\'z'), $_[0]};

package main;
$foo = Foo->new;
$fuz = Fuz->new;
$boo = [ 1, [], "abcd", \*foo,
         {1 => 'a', 023 => 'b', 0x45 => 'c'}, 
         \\"p\q\'r", $foo, $fuz];

########
# simple usage
# 簡単な使用方法
########

$bar = eval(Dumper($boo));
print($@) if $@;
print Dumper($boo), Dumper($bar);  # pretty print (no array indices)
                                   # 小洒落た表示(配列の添字のの省略)

$Data::Dumper::Terse = 1;          # don't output names where feasible
                                   # 可能であれば名前表示の抑制
$Data::Dumper::Indent = 0;         # turn off all pretty print
                                   # 整形表示の解消
print Dumper($boo), "\n";

$Data::Dumper::Indent = 1;         # mild pretty print
                                   # 幾分きれいな出力
print Dumper($boo);

$Data::Dumper::Indent = 3;         # pretty print with array indices
                                   # 配列の添字付きで整形出力
print Dumper($boo);

$Data::Dumper::Useqq = 1;          # print strings in double quotes
                                   # ダブルクオートで文字列を表示
print Dumper($boo);

$Data::Dumper::Pair = " : ";       # specify hash key/value separator
                                   # ハッシュのキー/値分離記号の指定
print Dumper($boo);

########
# recursive structures
# 再帰的な構造
########

@c = ('c');
$c = \@c;
$b = {};
$a = [1, $b, $c];
$b->{a} = $a;
$b->{b} = $a->[1];
$b->{c} = $a->[2];
print Data::Dumper->Dump([$a,$b,$c], [qw(a b c)]);

$Data::Dumper::Purity = 1;         # fill in the holes for eval
                                   # eval 用の隙間埋め
print Data::Dumper->Dump([$a, $b], [qw(*a b)]); # print as @a
                                                # @a で表示
print Data::Dumper->Dump([$b, $a], [qw(*b a)]); # print as %b
                                                # %b で表示

$Data::Dumper::Deepcopy = 1;       # avoid cross-refs
                                   # クロスリファレンスの回避
print Data::Dumper->Dump([$b, $a], [qw(*b a)]);

$Data::Dumper::Purity = 0;         # avoid cross-refs
                                   # クロスリファレンスの回避
print Data::Dumper->Dump([$b, $a], [qw(*b a)]);

########
# deep structures
# 深い構造
########

$a = "pearl";
$b = [ $a ];
$c = { 'b' => $b };
$d = [ $c ];
$e = { 'd' => $d };
$f = { 'e' => $e };
print Data::Dumper->Dump([$f], [qw(f)]);

$Data::Dumper::Maxdepth = 3;       # no deeper than 3 refs down
                                   # 3つより深く行かない
print Data::Dumper->Dump([$f], [qw(f)]);

########
# object-oriented usage
# オブジェクト指向的な使い方
########

$d = Data::Dumper->new([$a,$b], [qw(a b)]);
$d->Seen({'*c' => $c});            # stash a ref without printing it
                                   # 表示なしでリファレンスを取り置き
$d->Indent(3);
print $d->Dump;
$d->Reset->Purity(0);              # empty the seen cache
                                   # 既出キャッシュのクリア
print join "----\n", $d->Dump;

########
# persistence
# 持続
########

package Foo;
sub new { bless { state => 'awake' }, shift }
sub Freeze {
    my $s = shift;
print STDERR "preparing to sleep\n";
$s->{state} = 'asleep';
return bless $s, 'Foo::ZZZ';
}

package Foo::ZZZ;
sub Thaw {
    my $s = shift;
print STDERR "waking up\n";
$s->{state} = 'awake';
return bless $s, 'Foo';
}

package Foo;
use Data::Dumper;
$a = Foo->new;
$b = Data::Dumper->new([$a], ['c']);
$b->Freezer('Freeze');
$b->Toaster('Thaw');
$c = $b->Dump;
print $c;
$d = eval $c;
print Data::Dumper->Dump([$d], ['d']);

########
# symbol substitution (useful for recreating CODE refs)
# シンボル置換 (CODEリファレンスの再構築に便利)
########

sub foo { print "foo speaking\n" }
*other = \&foo;
$bar = [ \&other ];
$d = Data::Dumper->new([\&other,$bar],['*other','bar']);
$d->Seen({ '*foo' => \&foo });
print $d->Dump;

########
# sorting and filtering hash keys
# ハッシュキーのソートとフィルタ
########

$Data::Dumper::Sortkeys = \&my_filter;
my $foo = { map { (ord, "$_$_$_") } 'I'..'Q' };
my $bar = { %$foo };
my $baz = { reverse %$foo };
print Dumper [ $foo, $bar, $baz ];

sub my_filter {
    my ($hash) = @_;
    # return an array ref containing the hash keys to dump
    # in the order that you want them to be dumped
    # ダンプしたい順番でダンプするハッシュのキーを含んだ
    # 配列へのリファレンスを返す
    return [
      # Sort the keys of %$foo in reverse numeric order
      # 数値降順で %$foo のキーをソート
        $hash eq $foo ? (sort {$b <=> $a} keys %$hash) :
      # Only dump the odd number keys of %$bar
      # %$bar の奇数番目のキーのみをダンプ
        $hash eq $bar ? (grep {$_ % 2} keys %$hash) :
      # Sort keys in default order for all other hashes
      # それ以外はデフォルトの順番
        (sort keys %$hash)
    ];
}
