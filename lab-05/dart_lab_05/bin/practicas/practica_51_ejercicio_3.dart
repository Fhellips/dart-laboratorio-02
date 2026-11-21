abstract class Report {
  String describe();
}

class CompactReport extends Report {
  @override
  String describe() => 'Compact report';
}

class DetailedReport extends Report {
  @override
  String describe() => 'Detailed report';
}

void showDescription(Report report) {
  print(report.describe());
}

void main() {
  showDescription(CompactReport());
  showDescription(DetailedReport());
}
