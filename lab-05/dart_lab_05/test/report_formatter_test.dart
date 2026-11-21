import 'package:dart_lab_05/agrodiversa.dart';
import 'package:test/test.dart';

void main() {
  group('ReportFormatter', () {
    test('MinimalFormatter returns only the title', () {
      final formatter = MinimalFormatter();

      expect(formatter.format('Andes 2025', 125.0), 'Andes 2025');
    });

    test('CompactFormatter returns a compact report', () {
      final formatter = CompactFormatter();

      expect(formatter.format('Andes 2025', 125.0), 'Andes 2025: 125.00 ha');
    });

    test('DetailedFormatter returns a detailed report', () {
      final formatter = DetailedFormatter();

      expect(
        formatter.format('Andes 2025', 125.0),
        'Observation Andes 2025 reports 125.00 hectares.',
      );
    });

    test('ReportPrinter uses the assigned formatter', () {
      final printer = ReportPrinter(MinimalFormatter());

      expect(
        () => printer.printReport('Andes 2025', 125.0),
        prints('Andes 2025\n'),
      );
    });
  });
}
