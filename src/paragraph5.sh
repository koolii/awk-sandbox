#!/bin/sh

. src/function.sh

section '5. 四則演算と数値演算関数'

caseof '数字は全て倍数精度浮動小数点数として扱われる'
echo "$ echo '1 2 3 4 5' | awk '{print \$1 + \$2 - \$3 * \$4 / \$5}'"
echo '1 2 3 4 5' | awk '{print $1 + $2 - $3 * $4 / $5}'

caseof 'bcコマンドを使った一般的な数式の評価(標準な整数のみの場合)
bcコマンドは癖があって、最初は難しいらしい'
echo "$ echo '1 + 2 - 3 * 4 / 5' | bc"
echo '1 + 2 - 3 * 4 / 5' | bc

caseof '`bc -l`で小数を扱う'
echo "$ echo '1 + 2 - 3 * 4 / 5' | bc -l"
echo '1 + 2 - 3 * 4 / 5' | bc -l

memo 'AWKはevalのような直接数式を評価するものがないので、著者は下記のような関数をbashに定義して数式を簡単に計算できるようにしている
↓
calc() {
  awk "BEGIN {print $*}"
}
$ calc "1 + 2 - 3 * 4 / 5"
0.6
'

section '5.4 乱数(rand)'

caseof 'rand()は0から1までの乱数を発生させるが何度実行しても同じ値になる'
echo "$ awk 'BEGIN {print rand()}'"
awk 'BEGIN {print rand()}'
awk 'BEGIN {print rand()}'
awk 'BEGIN {print rand()}'

caseof '乱数の種を初期化する関数srandを使った乱数の生成(ただし、一回のシェルで乱数の種が変わるのは一回のみなので注意)'
echo "$ awk 'BEGIN {srand(); print rand()}'"
awk 'BEGIN {srand(); print rand()}'
awk 'BEGIN {srand(); print rand()}'
awk 'BEGIN {srand(); print rand()}'

caseof '1から10までの乱数を取得する(+1しないと0から9までの整数値にしかならない)
また、小数を省き整数部だけを表示する関数intを使っている(四捨五入しているわけではなく、おそらくJSのMath.floor()と同じ)'
echo "$ awk 'BEGIN {srand(); print int(rand() * 10) + 1}'"
awk 'BEGIN {srand(); print int(rand() * 10) + 1}'

caseof '四捨五入する'
echo "$ awk 'BEGIN {a = 1.5; print int(a + 0.5)}'"
awk 'BEGIN {a = 1.5; print int(a + 0.5)}'

important 'printf文には四捨五入させる機能はない、ネットには結構そういう記事が多いらしい'




