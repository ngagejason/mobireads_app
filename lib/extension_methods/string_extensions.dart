extension StringExtensions on String? {
  String guarantee() {
    return this ?? '';
  }
}
