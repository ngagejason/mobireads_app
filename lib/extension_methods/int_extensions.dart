extension IntExtensions on int? {
  int guarantee() {
    return this ?? 0;
  }
}
