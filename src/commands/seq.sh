#!/bin/sh

. src/function.sh

memo 'seqコマンドは等差数列を出力するコマンド
シェル芸や何らかのテストを行う際、サンプルとしての数字を列挙するのによく使われる'

caseof 'AWKでseqコマンドを実装
-vオプションで変数start,endに値を挿入してループ回数を設定する
数字を2乗していく必要がある場合などではseqコマンドでは表現ができないのでAWKを選択することになる'
echo "$ seq 1 3"
seq 1 3

echo "$ awk -v start=1 -v end=10 'BEGIN {i=start; while (i<=end) {print i++}}'"
awk -v start=1 -v end=3 'BEGIN {i=start; while (i<=end) {print i++}}'