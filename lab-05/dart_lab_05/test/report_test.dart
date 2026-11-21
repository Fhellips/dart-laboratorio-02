import 'package:dart_lab_05/agrodiversa.dart';
import 'package:test/test.dart';

void main() {
  group('Report inheritance and polymorphism', () {
    test('MunicipalReport inherits the description from Report', () {
      final report = MunicipalReport('Andes 2025');

      expect(report.title, 'Andes 2025');
      expect(report.describe(), 'Report: Andes 2025');
    });

    test('CompactReport returns its own description', () {
      final report = CompactReport();

      expect(report.describe(), 'Compact report');
    });

    test('DetailedReport returns its own description', () {
      final report = DetailedReport();

      expect(report.describe(), 'Detailed report');
    });

    test('Different reports can use the same Report type', () {
      List<Report> reports = [
        MunicipalReport('Andes 2025'),
        CompactReport(),
        DetailedReport(),
      ];

      expect(reports, hasLength(3));
      expect(reports[0].describe(), 'Report: Andes 2025');
      expect(reports[1].describe(), 'Compact report');
      expect(reports[2].describe(), 'Detailed report');
    });
  });
}
