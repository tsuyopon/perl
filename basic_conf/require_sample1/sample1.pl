# 設定ファイルを読み込むスクリプト

# 初期値
$name = "匿名";

#ファイルの存在チェック
if(-r "config.pm"){
    require("./config.pm");
}

print "こんにちは、$nameさん。\n";

