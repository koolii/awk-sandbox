echo "代入演算子"
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