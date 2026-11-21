abstract class Report {
  String get title;

  String describe() {
    return 'Report: $title';
  }
}

class MunicipalReport extends Report {
  @override
  final String title;

  MunicipalReport(this.title);
}

void main() {
  Report report = MunicipalReport('Andes 2025');
  print(report.describe());
}
