BEGIN {
  fruit_lit = "Apple Orange Banana";
  # split()は
  # 第一引数：分割対象の文字列
  # 第二引数：文字列を分割した配列を代入
  # 第三引数：実際の配列の数
  num_fruits = split(fruit_list, fruits);

  for (i = 1; i <= num_fruits; i++) {
    print i, fruits[i];
  }
}
