echo "If it prints string next line."

echo "* 数字の0のパターン"
echo "number zero" | awk '0'

echo "* 0以外の数字"
echo "number without zero" | awk '4'

echo "* 文字列の0"
echo "zero as a string" | awk '0 ""'

echo "* 文字列のbar"
echo "bar is a string" | awk '"bar"'

