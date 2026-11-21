import 'package:dart_lab_05/bookstore.dart';
import 'package:test/test.dart';

void main() {
  group('BookProduct', () {
    test('calculates product subtotal', () {
      final product = BookProduct(
        name: ' Clean Code ',
        quantity: 2,
        unitPrice: 85000.0,
      );

      expect(product.name, equals('Clean Code'));
      expect(product.subtotal, equals(170000.0));
    });

    test('rejects empty name and invalid quantity', () {
      expect(
        () => BookProduct(name: ' ', quantity: 1, unitPrice: 10.0),
        throwsA(isA<FormatException>()),
      );
      for (final quantity in <int>[0, -1]) {
        expect(
          () => BookProduct(
            name: 'Book',
            quantity: quantity,
            unitPrice: 10.0,
          ),
          throwsA(isA<FormatException>()),
        );
      }
    });

    test('rejects invalid prices and non-finite subtotal', () {
      for (final price in <double>[
        0.0,
        -1.0,
        double.nan,
        double.infinity,
      ]) {
        expect(
          () => BookProduct(name: 'Book', quantity: 1, unitPrice: price),
          throwsA(isA<FormatException>()),
        );
      }

      expect(
        () => BookProduct(
          name: 'Expensive',
          quantity: 2,
          unitPrice: 1.0e308,
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('BookOrder', () {
    test('calculates order total from product subtotals', () {
      final order = BookOrder(
        id: 'ORD-001',
        customerName: 'Laura',
        products: <BookProduct>[
          BookProduct(name: 'Book A', quantity: 2, unitPrice: 10.0),
          BookProduct(name: 'Book B', quantity: 1, unitPrice: 5.0),
        ],
      );

      expect(order.total, equals(25.0));
    });

    test('rejects empty identifiers, customer names and product lists', () {
      expect(
        () => BookOrder(
          id: ' ',
          customerName: 'Laura',
          products: <BookProduct>[
            BookProduct(name: 'Book', quantity: 1, unitPrice: 10.0),
          ],
        ),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => BookOrder(
          id: 'ORD-2',
          customerName: ' ',
          products: <BookProduct>[
            BookProduct(name: 'Book', quantity: 1, unitPrice: 10.0),
          ],
        ),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => BookOrder(
          id: 'ORD-3',
          customerName: 'Laura',
          products: <BookProduct>[],
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('does not retain an externally mutable products list', () {
      final mutableProducts = <BookProduct>[
        BookProduct(name: 'Book A', quantity: 1, unitPrice: 10.0),
      ];
      final order = BookOrder(
        id: 'ORD-4',
        customerName: 'Laura',
        products: mutableProducts,
      );

      mutableProducts.add(
        BookProduct(name: 'Book B', quantity: 1, unitPrice: 20.0),
      );

      expect(order.products, hasLength(1));
      expect(order.total, equals(10.0));
    });

    test('rejects a non-finite order total', () {
      expect(
        () => BookOrder(
          id: 'ORD-5',
          customerName: 'Laura',
          products: <BookProduct>[
            BookProduct(name: 'A', quantity: 1, unitPrice: 1.0e308),
            BookProduct(name: 'B', quantity: 1, unitPrice: 1.0e308),
          ],
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
