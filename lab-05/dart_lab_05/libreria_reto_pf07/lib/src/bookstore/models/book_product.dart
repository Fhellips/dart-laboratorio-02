class BookProduct {
  final String name;
  final int quantity;
  final double unitPrice;

  BookProduct({
    required String name,
    required this.quantity,
    required this.unitPrice,
  }) : name = name.trim() {
    if (this.name.isEmpty) {
      throw FormatException('Product name must not be empty.');
    }
    if (quantity <= 0) {
      throw FormatException('Product quantity must be a positive integer.');
    }
    if (!unitPrice.isFinite || unitPrice <= 0) {
      throw FormatException('Unit price must be positive and finite.');
    }
    if (!subtotal.isFinite) {
      throw FormatException('Product subtotal must be finite.');
    }
  }

  double get subtotal => quantity * unitPrice;
}
