BEGIN {
  while (getline < "-" > 0) {
    print "NR = " NR; # getlineでファイルを読み込むときは、行番号は自分でカウントしなければならない
  }
  close("-");
}