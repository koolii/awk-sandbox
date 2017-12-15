#!/bin/sh

. src/function.sh

section '4 文字列関数'
section '4.1 文字列の抜き出し(substr)'

caseof '2文字目から後の文字列を取得する'
echo "$ echo 'abcde' | awk '{print substr(\$0, 2)}'"
echo 'abcde' | awk '{print substr($0, 2)}'

caseof '2文字目から後の文字列を取得する(version シェル芸)'
echo "$ echo 'abcde' | awk '\$0 = substr(\$0, 2)}'"
echo 'abcde' | awk '$0 = substr($0, 2)'

caseof '2文字目から3文字の文字列を取得する'
echo "$ echo 'abcde' | awk '{print substr(\$0, 2, 3)}'"
echo 'abcde' | awk '{print substr($0, 2, 3)}'

important 'AWKは1オリジンなので、注意しなければならない
AWKに関する全てのインデックスは1から開始される'

caseof '対象文字列の中にある特定の文字列から任意の文字列を取り出す'
caseof 'ある文字列までの任意の文字列を取り出す'
echo "$ echo 'abcde' | awk '{print substr(\$0, index(\$0, \"b\"))}'"
echo 'abcde' | awk '{print substr($0, index($0, "b"))}'

important '↑の例だと文字列bから最後までを抜き出すのに、substr()とindex()を使ったが、
index()は最初の引数に対象となる文字列、2番目の引数に検索したい文字列を指定すると、検索したい文字列の先頭位置を返す
検索文字列が存在しないなら0を返す(今回だとマッチしない文字列を渡すと出力は0スタートなので"abcde"が出力される)

substr()とindex()は文字列抜き出しの中でもよく用いられるテクニックらしい'

section '4.2 文字列の検索(grep,match)'
echo "$ echo 'abcde' | awk '\$0 ~ /b.*/'"
echo 'abcde' | awk '$0 ~ /b.*/'
echo "$ echo 'abcde' | awk 'match(\$0, /b.*/)'"
echo 'abcde' | awk 'match($0, /b.*/)'

caseof '↑の結果自体は同じだが、match()は特殊な関数で、値を返すだけでなく、組み込み変数RSTARTとRLENGTHをセットするから
RSTARTにはマッチした最初の位置、RLENGTHにはマッチした長さが格納される
ただ、match()よりもマッチ演算子~で解決出来ることが多い'
echo "$ echo 'abcde' | awk 'match(\$0, /b.*/) {print RSTART, RLENGTH}'"
echo 'abcde' | awk 'match($0, /b.*/) {print RSTART, RLENGTH}'

caseof 'grepコマンドの引数として-oオプションをつけると正規表現にマッチした部分だけを抜き出すスクリプトになる'
echo "$ echo 'abcde' | grep -o 'b.*'"
echo 'abcde' | grep -o 'b.*'

caseof '文字列の縦=>横変換(文字列を一文字ずつ分離して夫々に改行を挿入する)も瞬時に可能'
echo 'abcde' | grep -o '.'
