extension IterableExtension<E> on Iterable<E> {
  T foldRight<T>(T initialValue, T Function(T previousValue, E element) combine) {
    var index = length - 1;
    var value = initialValue;

    while (index >= 0) {
      value = combine(value, elementAt(index--));
    }

    return value;
  }

  E? firstNullableWhere(bool Function(E element) test, {E? Function()? orElse}) {
    int length = this.length;
    for (int i = 0; i < length; i++) {
      E element = elementAt(i);
      if (test(element)) return element;
      if (length != this.length) {
        throw ConcurrentModificationError(this);
      }
    }
    if (orElse != null) return orElse();
    return null;
  }
}
