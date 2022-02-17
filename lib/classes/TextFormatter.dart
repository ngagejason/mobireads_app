
class TextFormatter {

  static LimitStringLength(String s, int length) {
    if(s.length <= length)
      return s;

    return s.substring(0, length - 3) + '...';
  }
}