BEGIN {
  price_of["Apple"] = 100;
  price_of["Orange"] = 200;
  price_of["Banana"] = 300;

  for (i in price_of) {
    print i, price_of[i];
  }
}
