import 'package:dart_lab_05/bookstore.dart';
import 'package:test/test.dart';

void main() {
  group('OrderJsonCodec', () {
    final codec = OrderJsonCodec();

    test('decodes valid orders and computes total sales', () {
      const source = '''
      [
        {
          "id": "ORD-001",
          "customerName": "Laura",
          "products": [
            {"name": "Clean Code", "quantity": 2, "unitPrice": 85000}
          ]
        }
      ]
      ''';

      final orders = codec.decodeOrders(source);
      expect(orders, hasLength(1));
      expect(orders.first.total, equals(170000.0));
    });

    test('accepts an empty JSON array', () {
      expect(codec.decodeOrders('[]'), isEmpty);
    });

    test('rejects malformed JSON and a non-array root', () {
      expect(
        () => codec.decodeOrders('[{"id":]'),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => codec.decodeOrders('{"id":"ORD-1"}'),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects wrong field types and non-integer quantities', () {
      const source = '''
      [
        {
          "id": "ORD-001",
          "customerName": "Laura",
          "products": [
            {"name": "Book", "quantity": 1.5, "unitPrice": 10}
          ]
        }
      ]
      ''';

      expect(
        () => codec.decodeOrders(source),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects duplicate order identifiers ignoring case', () {
      const source = '''
      [
        {
          "id": "ORD-001",
          "customerName": "Laura",
          "products": [{"name": "A", "quantity": 1, "unitPrice": 10}]
        },
        {
          "id": "ord-001",
          "customerName": "Andres",
          "products": [{"name": "B", "quantity": 1, "unitPrice": 20}]
        }
      ]
      ''';

      expect(
        () => codec.decodeOrders(source),
        throwsA(isA<FormatException>()),
      );
    });

    test('encodes and decodes orders without losing values', () {
      final original = <BookOrder>[
        BookOrder(
          id: 'ORD-001',
          customerName: 'Laura',
          products: <BookProduct>[
            BookProduct(name: 'Clean Code', quantity: 2, unitPrice: 85000),
          ],
        ),
      ];

      final decoded = codec.decodeOrders(codec.encodeOrders(original));

      expect(decoded, hasLength(1));
      expect(decoded.first.id, equals('ORD-001'));
      expect(decoded.first.customerName, equals('Laura'));
      expect(decoded.first.products.first.quantity, equals(2));
      expect(decoded.first.products.first.unitPrice, equals(85000.0));
      expect(decoded.first.total, equals(170000.0));
    });
  });
}
