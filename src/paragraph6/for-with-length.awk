BEGIN {
  fruits[1] = "Apple";
  fruits[2] = "Orange";
  fruits[3] = "Banana";

  for (i = 1; i <= length(fruits); i++) {
    print i, fruits[i];
  }
}
