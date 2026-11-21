import 'package:dart_lab_05/bookstore.dart';
import 'package:test/test.dart';

void main() {
  group('Order report formatters', () {
    test('compact formatter presents the order total', () {
      final formatter = CompactOrderFormatter();

      expect(
        formatter.format('ORD-001', 'Laura', 170000.0),
        equals('Order ORD-001 | Laura | \$170000.00'),
      );
    });

    test('detailed formatter presents the same numeric total', () {
      final formatter = DetailedOrderFormatter();

      expect(
        formatter.format('ORD-001', 'Laura', 170000.0),
        equals(
          'Order ORD-001 was placed by Laura. '
          'Total amount: \$170000.00.',
        ),
      );
    });

    test('both formatters implement the same contract', () {
      final List<OrderReportFormatter> formatters = <OrderReportFormatter>[
        CompactOrderFormatter(),
        DetailedOrderFormatter(),
      ];

      for (final formatter in formatters) {
        expect(formatter.format('ORD-9', 'Camila', 250.0), contains('250.00'));
      }
    });
  });
}
