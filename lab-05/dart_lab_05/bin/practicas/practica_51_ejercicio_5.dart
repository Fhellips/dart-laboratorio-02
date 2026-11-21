abstract interface class ReportFormatter {
  String format(String title, double area);
}

class CompactFormatter implements ReportFormatter {
  @override
  String format(String title, double area) {
    return '$title: $area ha';
  }
}

class ReportPrinter {
  final ReportFormatter formatter;

  ReportPrinter(this.formatter);

  void printReport(String title, double area) {
    print(formatter.format(title, area));
  }
}

void main() {
  ReportPrinter printer = ReportPrinter(CompactFormatter());
  printer.printReport('Andes 2025', 125.0);
}
