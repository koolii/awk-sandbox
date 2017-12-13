echo "比較演算子,マッチング演算子"

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