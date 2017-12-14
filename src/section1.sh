echo "If it prints string next line."

echo "* 数字の0のパターン"
echo "number zero" | awk '0'

echo "* 0以外の数字"
echo "number without zero" | awk '4'

echo "* 文字列の0"
echo "zero as a string" | awk '0 ""'

echo "* 文字列のbar"
echo "bar is a string" | awk '"bar"'

echo "1.3 比較演算子,マッチング演算子"

echo "* \$0 比較演算子を使う"
echo "use comparison operator" | awk '$0 == "use comparison operator"'

echo "\nYou can understand awk's boolean is number blow"
echo "* print result comparison"
echo "** pattern true"
echo "foo" | awk '{print ($0 == "foo")}'

echo "** pattern false"
echo "foo" | awk '{print ($0 != "foo")}'

echo "\nAWKの中で単独で/で囲まれた正義表現が用いられた場合は\$0 ~が省略されたものとみなされる"
echo "* pattern 1 full operators"
echo "foo" | awk '$0 ~ /foo/'

echo "* pattern 2 omiting \$0 operator"
echo "foo" | awk '/foo/'


echo "1.4 代入演算子"
echo "代入の可否と戻り値は関係なく、代入後の変数の値自体が可否となる"

echo "* replace b B"
echo "a b c" | awk '{$2 = "B"; print $0}'

# 代入して、その結果をパターンにするが必ず真になる
echo "* always insertion is true"
echo "a b c" | awk '$2 = "B"'

echo "* add empty string character 'b'"
echo "a b c" | awk '{$2 = ""; print $0}'

echo "* add empty string character 'b' version no printing"
echo "a b c" | awk '$2 = ""'

echo "** check insertion boolean 1"
echo "a b c" | awk '{print $2 = "B"}'

echo "** check insertion boolean 2"
echo "a b c" | awk '{print $2 = ""}'

# 空文字を代入すると$2は空文字になり、真偽値がfalseになるため表示されないのだから反値をとれば表示される
echo "** check insertion boolean 3 if you want to print pattern insertion of empty string"
echo "a b c" | awk '!($2 = "")'

echo "* [frequently using] only prints \$1 in terminal"
echo "a b c" | awk '$0 = $1'

echo "\n1.5 変数について"
echo "NR = Number of Record"
echo "NF = Number of Field"

echo "* you wanna print rows NF is 3"
echo "a b c" | awk 'NF == 3'

echo "[入力値が例外] NFの便利な使い方"
echo "スペースやタブだけの行、カラの行のようにフィールドがない場合には値が数字の0になるためパターンは偽となり、結果としてスペースやタブだけの行や空行を削除できる"
echo "\n a \n b \n c \n \n" | awk 'NF'


echo "\n1.6 関数"
echo "awkの関数は一価関数と呼ばれ、戻り値は１つ"

echo "* length関数 文字数を返す(引数がないと\$0を用い、しかもその場合は他の関数では必須の丸括弧()も不要という変な関数)"
echo "今回はレコードに何らかの文字があれば表示されるためスペースだけの行でも表示される"
echo "\n a \n b \n \n " | awk 'length'

echo "[よく間違える] sub()/gsub()"

echo "sub関数 置換に成功すれば数字の1を、失敗すれば数字の0を返す"
echo "gsub関数 置換に成功した個数を数字で返す"

echo "* example of gsub"
echo "a b c" | awk '{print gsub(/a/, "")}'

echo "マッチした場所を表示する時は下記のようになる(ただし、マッチするものが複数の場合は最後にマッチングした場所が表示される)"
echo "ab ba ab" | awk '$0 = gsub(/ab/, "")'
echo "ab ba ab ab" | awk '$0 = gsub(/ab/, "")'

echo "注意点はsub()/gsub()共に特に置換するものがなかった場合は0が返ってくるため普通に記述していると何も表示されないことがあるので文字列連接を使う"

echo "no matches in case of gsub()"
echo "ab ba ab" | awk '$0 = gsub(/ac/, "")'

echo "no matches in case of gsub() with string"
echo "下記を見ればわかるがダブルクォートで空文字連接をしてあげることで文字列0になり、偽にはならなくなる"
echo "ab ba ab" | awk '$0 = gsub(/ac/, "") ""'

echo "split関数 分割個数が戻り値となる"
echo "ab ba ab" | awk 'split($0, arr) { print arr[1], arr[2], arr[3]}'