#!/bin/sh

. src/function.sh

section "2章 awkの行操作"

section "2.2 直接行を指定する"
caseof '{print $0}を省略して、一行目だけを表示させる'
ex_direct "seq 1 10 | awk 'NR == 1'"

section "2.3 先頭10行を抜き出す"
caseof '先頭10行を抜き出す = headコマンド'
ex_direct "seq 1 100 | awk 'NR <= 10'"

memo 'headコマンドと↑のawkコマンドは全然違っていて、headコマンドは指定業まで表示し終えると、
パイプの前のコマンドに対してSIGPIPEを出すがawkはパイプの前のプロセスは最後まで実行される
もしも、巨大なファイルをawkコマンドで使うと処理が終了するまで待機しつづけなければならない'

echo '$ seq 1 10000000 | head > /dev/null'
seq 1 10000000 | head > /dev/null
result=${PIPESTATUS[@]}
echo  '$ echo ${PIPESTATUS[@]}}'
echo $result "<-headコマンドの戻り値が0じゃない\n"

caseof "awkでエラーが出るかどうか"
echo "$ seq 1 100000 | awk 'NR <= 10' > /dev/null"
seq 1 100000 | awk 'NR <= 10' > /dev/null
result=${PIPESTATUS[@]}
echo  '$ echo ${PIPESTATUS[@]}}'
echo $result "\n"

section "2.4 末尾10行"
memo "awkでtailコマンドも作成できるが、そもそもawkは先頭の一行目からしか揉むことができない為非常に非効率"
caseof '↓のシェルは行数分配列を作成するので大量にメモリを使用する'
echo "$ seq 1 100 | awk '{a[NR] = $0} END {for (i = NR - 10; i <= NR; i++) print a[i]}'"
seq 1 100 | awk '{a[NR] = $0} END {for (i = NR - 10; i <= NR; i++) print a[i]}'

caseof '↑の修正としてリングバッファを使用する(配列の要素数を10までに制限する)'
echo "$ seq 1 100 | awk '{a[NR % 10] = $0} END {for (i = NR + 1; i <= NR + 10; i++) print a[i % 10]}'"
seq 1 100 | awk '{a[NR % 10] = $0} END {for (i = NR + 1; i <= NR + 10; i++) print a[i % 10]}'

caseof 'シェル芸'
echo "$ seq 1 100 | tac | awk 'NR <= 10' | tac"
seq 1 100 | tac | awk 'NR <= 10' | tac

section "2.5 範囲を指定する"
caseof '組み込み変数NRが10以上かつ20以下'
echo "$ seq 1 100 | awk 'NR >= 10 && NR <= 20'"
seq 1 100 | awk 'NR >= 10 && NR <= 20'

section '2.6 範囲指定演算子'
caseof '組み込み変数NRが10以上かつ20以下(sedのようにカンマで)'
memo '範囲指定演算子は、カンマの前後がスイッチのように働く
今回だと「NRが10になったらパターンを真にして、NRが20になったらパターンを偽にする」という意味になる'
echo "$ seq 1 100 | awk 'NR == 10, NR == 20'"
seq 1 100 | awk 'NR == 10, NR == 20'

caseof '範囲指定演算子をわかりやすくする例'
echo "$ seq 1 10 | awk 'NR % 2 == 0, NR % 3 == 0'"
seq 1 10 | awk 'NR % 2 == 0, NR % 3 == 0'

section '2.7 マッチする行を抜き出す'
memo "grepコマンドで抽出するよりもawkで処理したほうが効率が良いことがある"
caseof '2か3が含まれる行取得する'
echo "$ seq 1 10 | awk '/[23]/'"
seq 1 10 | awk '/[23]/'

section '2.8 マッチしない行を抜き出す'
caseof '!で反値となる'
echo "$ seq 1 10 | awk '!/[23]/'"
seq 1 10 | awk '!/[23]/'

caseof '!で反値となる(version 2)'
echo "$ seq 1 10 | awk '\$0 !~ /[23]/'"
seq 1 10 | awk '$0 !~ /[23]/'


section '2.10 1行目からマッチした行まで'
memo '範囲演算子で組み込み変数NRが1の場合にパターンが真になり、正規表現空行(^$)で偽になる'
caseof 'topの先頭部分を使用する'
echo "$ top -b -n 1 | awk 'NR == 1, /^$/'"
# top -b -n 1 | awk 'NR == 1, /^$/'

section '2.11 マッチした行から最後まで'
caseof 'マッチした行から最後まで'
echo "$ top -b -n 1 | awk '/^$/, 0'"
# top -b -n 1 | awk '/^$/, 0'

section '2.12 NRが定義されないgetline'
important 'awkにはファイルを読み込む手段として、アクションで読み込む他に、getlineで読み込むという方法がある
getlineは引数を取りつつ、その引数に値を渡しつつ真偽値を返すと言う謎仕様がある

なので、getlineで読み込んだ場合はNRが定義されないことがあると覚える'

caseof 'getlineを使う'
echo "$ seq 1 10 | awk -f src/nr.awk"
seq 1 10 | awk -f src/nr.awk

# \

