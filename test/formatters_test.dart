import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/utils/formatters.dart';
import 'package:expense_tracker/models/currency.dart';

void main() {
  group('AppFormatters Tests', () {
    test('formats positive amounts with Indian comma separation', () {
      expect(AppFormatters.formatAmount(300000), '3,00,000');
      expect(AppFormatters.formatAmount(1000), '1,000');
      expect(AppFormatters.formatAmount(500), '500');
      expect(AppFormatters.formatAmount(1250000), '12,50,000');
      expect(AppFormatters.formatAmount(10000000), '1,00,00,000');
    });

    test('formats negative amounts with Indian comma separation', () {
      expect(AppFormatters.formatAmount(-300000), '-3,00,000');
      expect(AppFormatters.formatAmount(-50000), '-50,000');
    });

    test('formats currency string properly', () {
      expect(AppFormatters.formatCurrency(300000, '₹'), '₹3,00,000');
      expect(AppFormatters.formatCurrency(300000, '₹', space: true), '₹ 3,00,000');
      expect(AppFormatters.formatCurrency(-300000, '₹', space: true), '-₹ 3,00,000');
      expect(AppFormatters.formatCurrency(300000, '\$'), '\$3,00,000');
    });
  });

  group('Currency Tests', () {
    test('finds currencies properly by code and symbol', () {
      final inr = Currency.findByCode('INR');
      expect(inr.code, 'INR');
      expect(inr.symbol, '₹');

      final usd = Currency.findByCode('USD');
      expect(usd.code, 'USD');
      expect(usd.symbol, '\$');

      final aed = Currency.findByCode('AED');
      expect(aed.code, 'AED');
      expect(aed.symbol, 'د.إ');

      final bySymbol = Currency.findBySymbol('€');
      expect(bySymbol.code, 'EUR');
    });

    test('contains 160+ world currencies', () {
      expect(Currency.allCurrencies.length, greaterThan(150));
    });
  });
}
