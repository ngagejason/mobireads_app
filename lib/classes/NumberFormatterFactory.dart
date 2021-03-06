import 'package:intl/intl.dart';

class NumberFormatterFactory {

  static NumberFormat CreateCurrencyFormatter() {
    return NumberFormat("#,##0.00", "en_US");
  }

  static NumberFormat CreateNumberFormatter() {
    return NumberFormat("#,##0", "en_US");
  }
}