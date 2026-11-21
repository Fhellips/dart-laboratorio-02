import 'dart:io';

import 'package:dart_lab_05/bookstore.dart';

OrderReportFormatter? selectOrderFormatter(List<String> arguments) {
  final String format = arguments.isEmpty ? 'compact' : arguments.first;

  if (arguments.length > 1) {
    return null;
  }

  switch (format) {
    case 'compact':
      return CompactOrderFormatter();
    case 'detailed':
      return DetailedOrderFormatter();
    default:
      return null;
  }
}

void main(List<String> arguments) {
  final OrderReportFormatter? formatter = selectOrderFormatter(arguments);

  if (formatter == null) {
    stderr.writeln(
      'Usage: dart run bin/bookstore_orders_cli.dart [compact|detailed]',
    );
    exitCode = 2;
    return;
  }

  final File inputFile = File('data/bookstore_orders.json');
  final File outputFile = File('data/normalized_bookstore_orders.json');
  final OrderJsonCodec codec = OrderJsonCodec();

  try {
    final String source = inputFile.readAsStringSync();
    final List<BookOrder> orders = codec.decodeOrders(source);

    stdout.writeln('Valid orders: ${orders.length}');

    if (orders.isEmpty) {
      stdout.writeln('No orders available.');
    } else {
      for (final order in orders) {
        stdout.writeln(
          formatter.format(order.id, order.customerName, order.total),
        );

        if (formatter is DetailedOrderFormatter) {
          for (final product in order.products) {
            stdout.writeln(
              '  ${product.name}: ${product.quantity} x '
              '\$${product.unitPrice.toStringAsFixed(2)} = '
              '\$${product.subtotal.toStringAsFixed(2)}',
            );
          }
        }
      }
    }

    final double totalSales = orders.fold<double>(
      0.0,
      (sum, order) => sum + order.total,
    );

    if (!totalSales.isFinite) {
      throw FormatException('Total sales amount must be finite.');
    }

    stdout.writeln('Total sales: \$${totalSales.toStringAsFixed(2)}');

    // Export only after all orders and the combined total are validated.
    outputFile.writeAsStringSync(codec.encodeOrders(orders));
    stdout.writeln('Normalized file written: ${outputFile.path}');
  } on FileSystemException catch (error) {
    stderr.writeln('File error: ${error.message}');
    exitCode = 1;
  } on FormatException catch (error) {
    stderr.writeln('Invalid order data: ${error.message}');
    exitCode = 1;
  }
}
