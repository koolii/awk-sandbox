#!/bin/sh

. src/function.sh

caseof "* 数字の0のパターン"
exWithInput "number zero" "awk '0'"

caseof "* 0以外の数字"
exWithInput "number without zero" "awk '4'"

caseof "* 文字列の0"
exWithInput "zero as a string" "awk '0 ""'"

caseof "* 文字列のbar"
exWithInput "bar is a string" "awk '"bar"'"

section "1.3 比較演算子,マッチング演算子"

caseof "* \$0 比較演算子を使う"
echo "use comparison operator" | awk '$0 == "use comparison operator"'

echo "\nYou can understand awk's boolean is number blow"
caseof "* print result comparison"
caseof "** pattern true"
echo "foo" | awk '{print ($0 == "foo")}'

caseof "** pattern false"
echo "foo" | awk '{print ($0 != "foo")}'

echo "\nAWKの中で単独で/で囲まれた正義表現が用いられた場合は\$0 ~が省略されたものとみなされる"
caseof "* pattern 1 full operators"
echo "foo" | awk '$0 ~ /foo/'

caseof "* pattern 2 omiting \$0 operator"
echo "foo" | awk '/foo/'


section "1.4 代入演算子"
memo "代入の可否と戻り値は関係なく、代入後の変数の値自体が可否となる"

caseof "* replace b B"
ex "awk '{$2 = "B"; print $0}'"

# 代入して、その結果をパターンにするが必ず真になる
caseof "* always insertion is true"
ex "awk '$2 = "B"'"

caseof "* add empty string character 'b'"
ex "awk '{$2 = ""; print $0}'"

caseof "* add empty string character 'b' version no printing"
ex "awk '$2 = ""'"

caseof "** check insertion boolean 1"
ex "awk '{print $2 = "B"}'"

caseof "** check insertion boolean 2"
ex "awk '{print $2 = ""}'"

# 空文字を代入すると$2は空文字になり、真偽値がfalseになるため表示されないのだから反値をとれば表示される
caseof "** check insertion boolean 3 if you want to print pattern insertion of empty string"
ex "awk '!($2 = "")'"

caseof "* [frequently using] only prints \$1 in terminal"
ex "awk '$0 = $1'"

section "1.5 変数について"
memo "NR = Number of Record"
memo "NF = Number of Field"

caseof "* you wanna print rows NF is 3"
ex "awk 'NF == 3'"

important "[入力値が例外] NFの便利な使い方"
memo "スペースやタブだけの行、カラの行のようにフィールドがない場合には値が数字の0になるためパターンは偽となり、結果としてスペースやタブだけの行や空行を削除できる"
echo "\n a \n b \n c \n \n" | awk 'NF'


section "1.6 関数"
memo "awkの関数は一価関数と呼ばれ、戻り値は１つ"

caseof "* length関数 文字数を返す(引数がないと\$0を用い、しかもその場合は他の関数では必須の丸括弧()も不要という変な関数)"
caseof "今回はレコードに何らかの文字があれば表示されるためスペースだけの行でも表示される"
echo "\n a \n b \n \n " | awk 'length'

important "[よく間違える] sub()/gsub()"
important "sub関数 置換に成功すれば数字の1を、失敗すれば数字の0を返す"
important "gsub関数 置換に成功した個数を数字で返す"

caseof "* example of gsub"
ex "awk '{print gsub(/a/, "")}'"

caseof "マッチした場所を表示する時は下記のようになる(ただし、マッチするものが複数の場合は最後にマッチングした場所が表示される)"
echo "ab ba ab" | awk '$0 = gsub(/ab/, "")'
echo "ab ba ab ab" | awk '$0 = gsub(/ab/, "")'

important "注意点はsub()/gsub()共に特に置換するものがなかった場合は0が返ってくるため普通に記述していると何も表示されないことがあるので文字列連接を使う"

caseof "no matches in case of gsub()"
echo "ab ba ab" | awk '$0 = gsub(/ac/, "")'

caseof "no matches in case of gsub() with string"
memo "下記を見ればわかるがダブルクォートで空文字連接をしてあげることで文字列0になり、偽にはならなくなる"
echo "ab ba ab" | awk '$0 = gsub(/ac/, "") ""'

caseof "split関数 分割個数が戻り値となる"
echo "ab ba ab" | awk 'split($0, arr) { print arr[1], arr[2], arr[3]}'