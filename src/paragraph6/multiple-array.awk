BEGIN {
  # 配列のインデックスをカンマで区切ると、インデックスの中のカンマは8進数の'\34'に置き換えられる
  # スペースは連接として使われるので、下記の部分はプログラムとしては次のように解釈されていることになる
  # fruits[1 "\34" 1] = "Fuji Apple";
  # ただし、GNU AWKでは本当の多次元配列を扱うことができる
  fruits[1, 1] = "Fuji Apple";
  fruits[1, 2] = "Tsugaru Apple";
  fruits[2, 1] = "Blood Orange";
  fruits[2, 2] = "Mikan";

  for (i = 1; i <= 2; i++) {
    for (j = 1; j <= 2; j++) {
      # print i, j, fruits[i "\34" j];
      print i, j, fruits[i, j];
    }
  }
}
