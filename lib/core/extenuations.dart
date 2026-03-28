extension StringExtensions on String {
  String firstNWords({required int n}) {
    final words = split(' ');
    return words.length >= n ? words.take(n).join(' ') : this;
  }
}
