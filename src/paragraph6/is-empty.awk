BEGIN {
  price_of["Apple"]  = 100;
  price_of["Orange"] = 200;
  price_of["Banana"] = 300;

  if (!("Kiwi" in price_of)) {
    print "Kiwi is not found.";
  }
}
