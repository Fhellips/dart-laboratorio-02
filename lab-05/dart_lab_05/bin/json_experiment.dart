import 'dart:convert';

void main() {
  const source = '{"name":"Coffee","plantedArea":125.0}';

  Object? decoded = jsonDecode(source);

  if (decoded is! Map<String, dynamic>) {
    print('Expected a JSON object.');
    return;
  }

  print(decoded['name']);
  print(decoded['plantedArea']);
}
