void parseYear(String text) {
  try {
    print(int.parse(text));
  } on FormatException {
    print('Invalid year format.');
  } finally {
    print('Parsing attempt finished.');
  }
}

void main() {
  parseYear('2025');
  parseYear('invalid');
}
