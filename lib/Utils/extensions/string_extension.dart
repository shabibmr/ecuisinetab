import '../../Login/constants.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');

  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  String get inCurrency {
    double n = double.tryParse(this) ?? 0;
    return currencyFormat.format(this);
    // '$currency${n.toStringAsFixed(2)}';
  }
}
