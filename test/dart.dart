String string1 = 'abcd';
String string2 = 'dcba';

bool isAnogram(String one, String two) {
  String oneReversed = one.toLowerCase().split('').reversed.join();
  String twoComparable = two.toLowerCase();
  if (oneReversed == twoComparable)
    return true;
  else
    return false;
}

