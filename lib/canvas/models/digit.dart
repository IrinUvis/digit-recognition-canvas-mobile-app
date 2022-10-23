/// Enum class containing all digits.
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
  nine,
  unknown;

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
      case Digit.unknown:
        return 'unknown';
    }
  }
}

extension DigitConversion on int {
  Digit toDigit() {
    switch(this) {
      case 0: return Digit.zero;
      case 1: return Digit.one;
      case 2: return Digit.two;
      case 3: return Digit.three;
      case 4: return Digit.four;
      case 5: return Digit.five;
      case 6: return Digit.six;
      case 7: return Digit.seven;
      case 8: return Digit.eight;
      case 9: return Digit.nine;
      default: return Digit.unknown;
    }
  }
}
