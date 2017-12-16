#!/bin/sh

. src/function.sh

section "3. フィールドの操作"

memo 'cutコマンドよりもはるかに強力で
具体的には、1つのレコードの中をFS(Field Separator)で分割したものを1つ1つをフィールドと言う

現在処理中のレコードでのフィールド数はNF(Number of Field)で定義されているので、
レコードの末尾からは$NF, $(NF - 1), $(NF - 2)と定義される

デフォルトではFSは連続するスペースまたはタブ文字になっている'

caseof 'csvを分割する'
memo 'ダブルクォートや改行を含むようなものは標準的なawkだと扱えない'
echo "$ echo "a,b,c" | awk -F ',' '{print $2}'"
echo "a,b,c" | awk -F ',' '{print $2}'

caseof '不思議な例1'
echo "$ echo "           a b c" | awk '{print $2}'"
echo "           a b c" | awk '{print $2}'
caseof '不思議な例2'
echo "$ echo "           a b c" | awk -F'[ \\\t]+' '{print $2}'"
echo "           a b c" | awk -F'[ \t]+' '{print $2}'
important '実はFSはスペース1つが正確な定義となっている'

section '3.2 指定フィールドを抜き出す'
caseof 'フィールドを抜き出す'
echo "echo \"a b c\" | awk '{print $2}'"
echo "a b c" | awk '{print $2}'

echo "echo \"a b c\" | awk '\$0 = \$2'"
echo "a b c" | awk '$0 = $2'

important 'awkとcutコマンドの最大の違いは、フィールドの区切りに正規表現が使えるかどうか
RSには正規表現が使えないが、FSには正規表現が使えるので複数をまとめてFSに指定することができる'

echo "$ echo \"2014/04/08 12:12:12\" | awk -F'[ :/]' '{print $2}'"
echo "2014/04/08 12:12:12" | awk -F'[ :/]' '{print $2}'

section '3.3 指定フィールドを消す'
caseof '特定のフィールドを削除するには、フィールドに空文字列を代入する'
echo "$ echo \"a b c\" | awk '{\$2 = \"\"; print}'"
echo "a b c" | awk '{$2 = ""; print}'

caseof 'この例のaとcの間にはスペースが2つはいってしまうので、注意が必要'
echo "$ echo \"a b c\" | awk '!($2 = \"\")'"
echo "a b c" | awk '!($2 = "")'

caseof '少ないなら削除するよりも、消したいフィールド以外を表示したほうが簡単でわかりやすい'
echo "$ echo \"a b c\" | awk '{print \$1, \$3}'"
echo "a b c" | awk '{print $1, $3}'

memo '↑のprint文で用いたカンマは特殊で、OFS(Output Field Separator)に置き換えられます
組み込み変数OFSはデフォルトではスペース1つ'

important 'カンマをOFSとして扱うのは、print文だけ'

section '3.4 範囲指定でフィールドを抜き出す'
memo 'forやwhileを使う必要がある
a = a OFS $i や a = a OFS $(i++)という記述があるがawkでは文字列同士を繋げる場合
このようにスペースを挟んで連続して記述する

また、$i++と記述すると、awkの演算の優先順位により、$iに対してインクリメント演算子++が実行されてしまうので
変数iに対してインクリメントするようにカッコで囲む'

caseof 'for-loop'
echo "$ echo \"a b c\" | awk '{for (i = 2; i <= NF; i++) a = a OFS \$i; print a}'"
echo "a b c" | awk '{for (i = 2; i <= NF; i++) a = a OFS $i; print a}'

caseof 'while-loop'
echo "$ echo \"a b c\" | awk '{i = 2; while (i <= NF) a = a OFS \$(i++); print a}'"
echo "a b c" | awk '{i = 2; while (i <= NF) a = a OFS $(i++); print a}'

section '3.5 フィールドの計算'
caseof '横方向の集計処理ではforを使う'
echo "$ echo \"1 2 3\" | awk '{for (i = 1; i <= NF; i++) sum += \$i; print sum}'"
echo "1 2 3" | awk '{for (i = 1; i <= NF; i++) sum += $i; print sum}'

caseof '行数が多くなければ使用出来るシェル芸'
memo 'bashの配列$PIPESTATUS[@]が全て0かどうかを判断する時に、著者がよく使っているらしい
$PIPESTATUS[@]の値はechoなどで表示すると戻り値がスペース区切りになっているので、すべてを足した結果が0であれば全てのパイプでエラーが無いことになる'
echo "$ echo \"1 2 3\" | tr ' ' '+' | bc"
echo "1 2 3" | tr ' ' '+' | bc

caseof 'BMIを計算する(weight/height)'
echo "$ echo \"50 160\" | awk '{print \$1 / (\$2 / 100) ^ 2}'"
echo "50 160" | awk '{print $1 / ($2 / 100) ^ 2}'

section '3.6 フィールドの再構築'
caseof 'csvをスペース区切りにしたいが、↓だと変わらない'
echo "$ echo \"a,b,c\" | awk -F',' -v OFS=' ' '4'"
echo "a,b,c" | awk -F',' -v OFS=' ' '4'

memo '上記のコマンドは"a,b,c"を読み込んだ際にawkがフィールド分割を行っているだけで、新しくフィールドを再構築していないため
新しくフィールドを再構築し、新しいレコードを作成するには、$1 = $1と言う変わった文法をフィールドの再構築と呼ぶ。
フィールドに新しく変数が代入された時に初めてOFSに従ってフィールドとレコードを再構築すると言うAWKの挙動を利用したもの(ちなみに全てのAWKで使える)

ただし、注意点としては、代入された結果が偽は駄目(左辺値)'

caseof '$1 = $1 によるフィールドの再構築'
echo "$ echo \"a,b,c\" | awk -F',' -v OFS=' ' '\$1 = \$1'"
echo "a,b,c" | awk -F',' -v OFS=' ' '$1 = $1'

caseof '偽の場合の何も出力されない証明(0が含まれている)'
echo "$ echo \"0,1,2\" | awk -F',' -v OFS=' ' '\$1 = \$1'\n =>"
echo "0,1,2" | awk -F',' -v OFS=' ' '$1 = $1'

caseof '偽の場合でも出力されるようにアクションで記述する(0が含まれている)'
memo 'なぜアクションだと$1 = $1が偽になっても出力されるのか分からない。↑は真偽値によって、出力するしないを分けているが、こちらは単に処理だから？'
echo "0,1,2" | awk -F',' -v OFS=' ' '{$1 = $1; print}'

# \