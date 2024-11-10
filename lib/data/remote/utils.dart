List<T> convertList<T>(dynamic value) {
  if (value is List) {
    return value.map<T>((item) {
      if (item is T) {
        return item;
      } else if (T == double && item is num) {
        return item.toDouble() as T;
      }
      throw TypeError();
    }).toList();
  }
  return <T>[];
}
