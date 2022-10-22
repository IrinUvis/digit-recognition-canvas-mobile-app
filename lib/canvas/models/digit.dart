enum Digit {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine;

  @override
  String toString() {
    switch(this) {
      case Digit.zero:
        return '0';
      case Digit.one:
        return '1';
      case Digit.two:
        return '2';
      case Digit.three:
        return '3';
      case Digit.four:
        return '4';
      case Digit.five:
        return '5';
      case Digit.six:
        return '6';
      case Digit.seven:
        return '7';
      case Digit.eight:
        return '8';
      case Digit.nine:
        return '9';
    }
  }
}
