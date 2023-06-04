import 'dart:math';

extension StringExt on String {
  String safeSubstring(int start, [int? end]) {
    return substring(start, end != null ? min(length, end) : null);
  }

  String ellipsis(int length) {
    if(this.length > length) {
      return "${substring(0, length)}...";
    } else {
      return this;
    }
  }

  int count(Pattern pattern) {
    Iterable<Match> matches = pattern.allMatches(this);
    return matches.length;
  }

  int nthIndexOf(Pattern pattern, int nth) {
    if(count(pattern) < nth) {
      return -1;
    }

    int index = 0;
    for(int i = 0; i < nth; i++) {
      index = indexOf(pattern, index + 1);
    }
    return index;
  }
}
