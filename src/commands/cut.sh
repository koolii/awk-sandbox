#!/bin/sh

. src/function.sh

memo 'AWKとはフィールド区切りに大きな違いがある
cutコマンドのフィールド区切りはタブがデフォルトで正規表現は使えない
AWKのデフォルトは連続するスペースまたはタブで正規表現も使える
'

caseof '第三フィールドを抜き出すcut/awkコマンド'
echo "$ echo 'a b c d' | cut -d ' ' -f 3"
echo 'a b c d' | cut -d ' ' -f 3

echo "$ echo 'a b c d' | awk '{print \$3}'"
echo 'a b c d' | awk '{print $3}'

memo 'cutコマンドは範囲を指定してフィールドを抜き出すことができる
第二フィールドから第四フィールドまでを抜き出す
AWKは特定の範囲のフィールドを抜き出すのは非常に面倒になってしまう
しかも、末尾には出力の末尾にスペースが入るという問題がある
'

echo "$ echo 'a b c d' | cut -d ' ' -f '2-4'"
echo 'a b c d' | cut -d ' ' -f '2-4'
echo "$ echo 'a b c d' | awk '{for (i=2; i<=4; i++) { printf(\"\%s \", \$i); }} END { print \"\" }'"
echo 'a b c d' | awk '{for (i=2; i<=4; i++) { printf("%s ", $i); }} END { print "" }'