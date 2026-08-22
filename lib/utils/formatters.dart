import 'package:intl/intl.dart';

class AppFormatters {
  /// Formats a number in Indian comma-separated format (e.g. 3,00,000 or -3,00,000)
  static String formatAmount(double amount, {bool showDecimals = false, bool alwaysShowDecimals = false}) {
    final isNegative = amount < 0;
    final absAmount = amount.abs();

    final intPart = absAmount.truncate();
    final double fractionPart = absAmount - intPart;

    // Convert integer part to Indian format (e.g. 300000 -> 3,00,000)
    String intString = intPart.toString();
    String formattedInt = '';

    if (intString.length <= 3) {
      formattedInt = intString;
    } else {
      // Last 3 digits
      String last3 = intString.substring(intString.length - 3);
      String remaining = intString.substring(0, intString.length - 3);

      // Remaining digits grouped in pairs of 2 from right to left
      List<String> chunks = [];
      while (remaining.isNotEmpty) {
        if (remaining.length <= 2) {
          chunks.insert(0, remaining);
          break;
        } else {
          chunks.insert(0, remaining.substring(remaining.length - 2));
          remaining = remaining.substring(0, remaining.length - 2);
        }
      }
      formattedInt = '${chunks.join(',')},$last3';
    }

    String result = isNegative ? '-$formattedInt' : formattedInt;

    if (alwaysShowDecimals || (showDecimals && fractionPart > 0.001)) {
      String decString = fractionPart.toStringAsFixed(2); // "0.XX"
      result += decString.substring(1); // ".XX"
    }

    return result;
  }

  /// Formats currency with symbol (e.g. ₹3,00,000 or -₹3,00,000)
  static String formatCurrency(
    double amount,
    String symbol, {
    bool space = false,
    bool showDecimals = false,
    bool alwaysShowDecimals = false,
  }) {
    final isNegative = amount < 0;
    final formattedNumber = formatAmount(
      amount.abs(),
      showDecimals: showDecimals,
      alwaysShowDecimals: alwaysShowDecimals,
    );

    final spacer = space ? ' ' : '';
    if (isNegative) {
      return '-$symbol$spacer$formattedNumber';
    }
    return '$symbol$spacer$formattedNumber';
  }

  /// Formats date
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
