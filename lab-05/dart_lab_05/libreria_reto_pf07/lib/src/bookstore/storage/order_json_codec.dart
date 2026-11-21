import 'dart:convert';

import '../models/book_order.dart';
import '../models/book_product.dart';

class OrderJsonCodec {
  List<BookOrder> decodeOrders(String source) {
    final Object? decoded = jsonDecode(source);

    if (decoded is! List<dynamic>) {
      throw FormatException('Expected a JSON array of orders.');
    }

    final List<BookOrder> orders = <BookOrder>[];
    final Set<String> identifiers = <String>{};

    for (final rawOrder in decoded) {
      if (rawOrder is! Map<String, dynamic>) {
        throw FormatException('Every order must be a JSON object.');
      }

      final Object? id = rawOrder['id'];
      final Object? customerName = rawOrder['customerName'];
      final Object? rawProducts = rawOrder['products'];

      if (id is! String ||
          customerName is! String ||
          rawProducts is! List<dynamic>) {
        throw FormatException('Invalid order fields.');
      }

      final List<BookProduct> products = <BookProduct>[];

      for (final rawProduct in rawProducts) {
        if (rawProduct is! Map<String, dynamic>) {
          throw FormatException('Every product must be a JSON object.');
        }

        final Object? name = rawProduct['name'];
        final Object? quantity = rawProduct['quantity'];
        final Object? unitPrice = rawProduct['unitPrice'];

        if (name is! String || quantity is! int || unitPrice is! num) {
          throw FormatException('Invalid product fields or data types.');
        }

        products.add(
          BookProduct(
            name: name,
            quantity: quantity,
            unitPrice: unitPrice.toDouble(),
          ),
        );
      }

      final BookOrder order = BookOrder(
        id: id,
        customerName: customerName,
        products: products,
      );

      if (!identifiers.add(order.id.toLowerCase())) {
        throw FormatException('Duplicate order identifier: ${order.id}');
      }

      orders.add(order);
    }

    return orders;
  }

  String encodeOrders(List<BookOrder> orders) {
    final List<Map<String, Object?>> data = orders.map((order) {
      return <String, Object?>{
        'id': order.id,
        'customerName': order.customerName,
        'products': order.products.map((product) {
          return <String, Object?>{
            'name': product.name,
            'quantity': product.quantity,
            'unitPrice': product.unitPrice,
          };
        }).toList(),
      };
    }).toList();

    return const JsonEncoder.withIndent('  ').convert(data);
  }
}
