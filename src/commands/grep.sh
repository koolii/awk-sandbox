#!/bin/sho

. src/function.sh

memo 'grepコマンドはAWKと併用して使われる場合が多いが、grepの基本機能はAWKに含まれている
AWKにないものとしては、fgrepコマンド(= grep -F)のような文字そのものでの検索機能'

caseof '正規表現で1を含むものを抜き出したい'
echo "$ seq 1 10 | awk '/1/'"
seq 1 10 | awk '/1/'

caseof 'grep -oの実装(結構大変)
match()で正規表現aが存在する開始文字と文字数を取得し、それを元に部分文字列を取得している'
echo "$ echo 'a b c d' | grep -o 'a'"
echo 'a b c d' | grep -o 'a'

echo "$ echo 'a b c d' | awk 'match(\$0, /a/) {print substr(\$0, RSTART, RLENGTH)}'"
echo 'a b c d' | awk 'match($0, /a/) {print substr($0, RSTART, RLENGTH)}'
