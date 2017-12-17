#!/bin/sh

. src/function.sh

caseof 'wcコマンドの-wオプション(単語数のみを表示)をAWKで'
echo "$ echo 'This is a pen.' | wc -w"
echo 'This is a pen.' | wc -w

echo "$ echo 'This is a pen.' | awk '{n += NF} END {print n}'"
echo 'This is a pen.' | awk '{n += NF} END {print n}'

caseof '日本語の扱い
マルチバイトの文字については扱えないものもある'
echo "$ echo 'これはぺんです。' | wc -c"
echo 'これはぺんです。' | wc -c

echo "$ echo 'これはぺんです。' | awk '{print length(\$0)}'"
echo 'これはぺんです。' | awk '{print length($0)}'