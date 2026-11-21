import 'package:dart_lab_05/agrodiversa.dart';

void main() {
  List<ReportFormatter> formatters = [
    MinimalFormatter(),
    CompactFormatter(),
    DetailedFormatter(),
  ];

  for (ReportFormatter formatter in formatters) {
    ReportPrinter printer = ReportPrinter(formatter);
    printer.printReport('Andes 2025', 125.0);
  }
}
