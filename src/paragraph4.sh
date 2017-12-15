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

section '4.3 文字列の置換(sub/gsub)'

caseof '最初にマッチした文字列だけを置換'
echo "$ echo 'abcde' | awk '{sub(/./, \"A\"); print \$0}'"
echo 'abcde' | awk '{sub(/./, "A"); print $0}'
caseof 'マッチした全ての文字列を置換'
echo "$ echo 'abcde' | awk '{gsub(/./, \"A\"); print \$0}'"
echo 'abcde' | awk '{gsub(/./, "A"); print $0}'

memo 'sub()/gsub()が取る引数は
第一引数：置換対象になる正規表現
第二引数：置換後の文字列
第三引数：置換対象文字列（省略すると$0が使われる）'

caseof 'よくある間違いとして、sub()/gsub()は共に戻り値が「置換に成功した個数」ということ
今回だとマッチした5が帰り、それを$0に代入しているので5が出力された'
echo "$ echo 'abcde' | awk '\$0 = gsub(/./, \"A\")'"
echo 'abcde' | awk '$0 = gsub(/./, "A")'

caseof '正しいがマッチするものがなかった場合は0が返るため何も出力されない'
echo "$ echo 'abcde' | awk 'gsub(/z/, \"Z\")'\n =>"
echo 'abcde' | awk 'gsub(/z/, "Z")'

caseof '正しい省略バージョン
代入式をなしにする。そうすると、$0はそのまま最初の文字列（といっても置換されている)が出力される
今回は""を追加して、数値が0の場合にも対処している'
echo "$ echo 'abcde' | awk 'gsub(/./, "A") \"\"'"
echo 'abcde' | awk 'gsub(/./, "A") ""'

section '4.4 文字列の連接'

caseof 'AWKで文字列をつなげる場合は、つなげる文字列の間にスペースを配置する(明確に異なる場合はスペースも要らない)'
echo "$ echo 'abcde' | awk '{print \$0 \"fghij\"}'"
echo 'abcde' | awk '{print $0 "fghij"}'

caseof 'sprintf()を使った文字列連接'
echo "$ echo 'abcde' | awk '{print sprintf(\"%s%s\", \$0, \"fghij\")}'"
echo 'abcde' | awk '{print sprintf("%s%s", $0, "fghij")}'

caseof 'printf()を使った文字列連接'
echo "$ echo 'abcde' | awk '{print printf(\"%s%s\\\n\", \$0, \"fghij\")}'"
echo 'abcde' | awk '{print sprintf("%s%s\n", $0, "fghij")}'

section '4.5 大文字小文字変換'

caseof 'upper'
echo "$ echo 'abcde' | awk '{print toupper(\$0)}'"
echo 'abcde' | awk '{print toupper($0)}'

caseof 'lower'
echo "$ echo 'ABCDE' | awk '{print tolower(\$0)}'"
echo 'ABCDE' | awk '{print tolower($0)}'

caseof '大文字小文字を無視した条件分岐'
echo "$ echo 'Awk' | awk 'tolower(\$0) == \"awk\"'"
echo 'Awk' | awk 'tolower($0) == "awk"'