abstract interface class ReportFormatter {
  String format(String title, double area);
}

class CompactFormatter implements ReportFormatter {
  @override
  String format(String title, double area) {
    String value = area.toStringAsFixed(2);
    return '$title: $value ha';
  }
}

class VerboseFormatter implements ReportFormatter {
  @override
  String format(String title, double area) {
    String value = area.toStringAsFixed(2);
    return 'Observation $title reports $value hectares.';
  }
}

void main() {
  ReportFormatter formatter = CompactFormatter();
  print(formatter.format('Andes 2025', 125.0));

  formatter = VerboseFormatter();
  print(formatter.format('Andes 2025', 125.0));
}
