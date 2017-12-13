echo "比較演算子,マッチング演算子"

echo "* \$0 比較演算子を使う"
echo "use comparison operator" | awk '$0 == "use comparison operator"'

echo "\nYou can understand awk's boolean is number blow"
echo "* print result comparison"
echo "** pattern true"
echo "foo" | awk '{print ($0 == "foo")}'

echo "** pattern false"
echo "foo" | awk '{print ($0 != "foo")}'
