import 'book_product.dart';

class BookOrder {
  final String id;
  final String customerName;
  final List<BookProduct> products;

  BookOrder({
    required String id,
    required String customerName,
    required List<BookProduct> products,
  })  : id = id.trim(),
        customerName = customerName.trim(),
        products = List<BookProduct>.unmodifiable(products) {
    if (this.id.isEmpty) {
      throw FormatException('Order identifier must not be empty.');
    }
    if (this.customerName.isEmpty) {
      throw FormatException('Customer name must not be empty.');
    }
    if (this.products.isEmpty) {
      throw FormatException('An order must contain at least one product.');
    }
    if (!total.isFinite) {
      throw FormatException('Order total must be finite.');
    }
  }

  double get total => products.fold<double>(
        0.0,
        (sum, product) => sum + product.subtotal,
      );
}
