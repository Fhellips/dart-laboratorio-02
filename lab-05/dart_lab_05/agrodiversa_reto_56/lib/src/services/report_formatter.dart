abstract interface class ReportFormatter {
  String format(String title, double area);
}

class CompactFormatter implements ReportFormatter {
  @override
  String format(String title, double area) {
    return '$title: ${area.toStringAsFixed(2)} ha';
  }
}

class DetailedFormatter implements ReportFormatter {
  @override
  String format(String title, double area) {
    return 'Observation $title reports ${area.toStringAsFixed(2)} hectares.';
  }
}
