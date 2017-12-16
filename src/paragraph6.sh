#!/bin/sh

. src/function.sh

section '6. 配列&連想配列の仕組み・動作'

caseof '6.1 配列+length()
length()は少し特殊で、引数がない場合には$0の文字列を返し、引数が変数の場合には変数の長さを返す
引数が配列の場合には、配列の個数を返す'
cat src/paragraph6/for-with-length.awk
echo "$ awk -f src/paragraph6/for-with-length.awk"
awk -f src/paragraph6/for-with-length.awk

caseof '6.2 連想配列+for-in(順番が無い)
そもそもAWKでは配列も連想配列として扱われているので、同じようにfor-inで出力することができる(が、順番通りにはならない)'
cat src/paragraph6/hash.awk
echo "$ awk -f src/paragraph6/hash.awk"
awk -f src/paragraph6/hash.awk

memo 'もしも、length()にエラーがあり、配列の個数を取得できない場合は、for-inで変数をインクリメントし続けて、配列の個数を得るしかない'

caseof '6.3 全てが連想配列なので、順番になっているリストを作るには、keyを数値にして、それをインクリメントするが
それも面倒なので、split()を使う'
cat src/paragraph6/split.awk
echo "$ awk -f src/paragraph6/split.awk"
awk -f src/paragraph6/split.awk

caseof '6.3 多次元配列を扱う'
cat src/paragraph6/multiple-array.awk
echo "$ awk -f src/paragraph6/multiple-array.awk"
awk -f src/paragraph6/multiple-array.awk

caseof '6.4 配列に含まれているかどうかチェックする'
cat src/paragraph6/is-empty.awk
echo "$ awk -f src/paragraph6/is-empty.awk"
awk -f src/paragraph6/is-empty.awk

section '6.5 シェル芸で配列'

caseof '重複行を1つにする(bashならechoに-eオプションを追加する)'
memo '連想配列aのインデックスに$0(行自体)を入れて加算している
それを否定しているので、連想配列a[$0]が加算されない最初のものだけを表示する
=> 重複行が一つになる'
echo "$ echo \"aaa\\\nbbb\\\naaa\" | awk '!a[\$0]++'"
echo "aaa\nbbb\naaa" | awk '!a[$0]++'

caseof '通常の重複行削除(ただAWKは逐次処理できるのでより高速ではある)'
echo "$ echo \"aaa\\\nbbb\\\naaa\" | sort | uniq"
echo "aaa\nbbb\naaa" | sort | uniq

caseof '重複行のみ出力'
echo "$ echo \"aaa\\\nbbb\\\naaa\" | awk 'a[\$0]++ == 1'"
echo "aaa\nbbb\naaa" | awk 'a[$0]++ == 1'

caseof '重複行のみ出力(通常)'
echo "$ echo \"aaa\\\nbbb\\\naaa\" | sort | uniq -d"
echo "aaa\nbbb\naaa" | sort | uniq -d


