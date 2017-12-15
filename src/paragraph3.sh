#!/bin/sh

. src/function.sh

echo 'フィールドの操作'
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




# \