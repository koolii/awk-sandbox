#!/bin/sh

. src/function.sh

caseof 'uniqコマンドを使う前には必ずソートする必要がある
そのため、sort | uniqはもはや常套句だが、sortコマンドは全ての行を読み込む必要があるので
効率が悪いコマンド、なのでAWKでソートセずに重複を削除するコマンドを作る'

echo "$ echo 'a\\\nb\\\na' | awk '!a[\$0]++ {print \$0}'"
echo 'a\nb\na' | awk '!a[$0]++ {print $0}'

memo 'インクリメント演算子、デクリメント演算子の動作が複雑なので詳細説明
最初の行の値が0になっていて、これは仕様'

echo "$ echo 'a\\\nb\\\na' | awk '{print a[\$0]++}'"
echo 'a\nb\na' | awk '{print a[$0]++}'

memo 'インクリメント演算子またはで売り面と演算子が変数の後についた場合は
戻り値はそのままで、次に参照される際にインクリメントまたはデクリメントされます'

echo 'a\nb\na' | awk '{print a[$0]++, a[$0]}'