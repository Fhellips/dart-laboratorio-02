abstract interface class OrderReportFormatter {
  String format(String orderId, String customerName, double total);
}

class CompactOrderFormatter implements OrderReportFormatter {
  @override
  String format(String orderId, String customerName, double total) {
    return 'Order $orderId | $customerName | \$${total.toStringAsFixed(2)}';
  }
}

class DetailedOrderFormatter implements OrderReportFormatter {
  @override
  String format(String orderId, String customerName, double total) {
    return 'Order $orderId was placed by $customerName. '
        'Total amount: \$${total.toStringAsFixed(2)}.';
  }
}
