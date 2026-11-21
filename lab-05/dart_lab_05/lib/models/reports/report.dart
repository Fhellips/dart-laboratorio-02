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

class CompactReport extends Report {
  @override
  String get title => 'Compact report';

  @override
  String describe() {
    return 'Compact report';
  }
}

class DetailedReport extends Report {
  @override
  String get title => 'Detailed report';

  @override
  String describe() {
    return 'Detailed report';
  }
}
