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
    bool hasDouble = false;
    int doubleGroup = 0;
    bool onlyIncreases = true;

    for (int ii = 0; ii < chars.length-1; ii++) {

      if (chars[ii] > chars[ii+1]) {
        onlyIncreases = false;
        break;
      }

      if (chars[ii] == chars[ii+1] && chars[ii] != doubleGroup) {
        if (ii < 4) {
          if (chars[ii] == chars[ii + 2]) {
            doubleGroup = chars[ii];
          } else {
            hasDouble = true;
          }
        } else {
          hasDouble = true;
        }
      }
    }

    return hasDouble && onlyIncreases;
  }
}