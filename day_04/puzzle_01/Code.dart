class Password {

  List<int> chars;

  Password (int value) {
    String valueChars = value.toString();
    if (valueChars.length != 6) {
      throw Exception('Invalid Password - length must be 6');
    }
    chars = [];
    valueChars.runes.forEach((rune) => chars.add(int.parse(String.fromCharCode(rune))));
  }

  int toInt() {
    return int.parse(chars.join());
  }

  String toString() {
    return chars.join();
  }

  bool isValid() {
    bool hasRepeat = false;
    bool onlyIncreases = true;

    for (int ii = 0; ii < chars.length-1; ii++) {
      if (chars[ii] > chars[ii+1]) {
        onlyIncreases = false;
        break;
      }
      if (chars[ii] == chars[ii+1]) hasRepeat = true;
    }

    return hasRepeat && onlyIncreases;
  }
}