import 'package:dart_lab_05/agrodiversa.dart';

void showDescription(Report report) {
  print(report.describe());
}

void main() {
  Report municipal = MunicipalReport('Andes 2025');

  showDescription(municipal);
  showDescription(CompactReport());
  showDescription(DetailedReport());
}
