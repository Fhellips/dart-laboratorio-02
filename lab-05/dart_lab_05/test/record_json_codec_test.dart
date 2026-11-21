import 'package:dart_lab_05/agrodiversa.dart';
import 'package:test/test.dart';

void main() {
  group('RecordJsonCodec', () {
    final codec = RecordJsonCodec();

    test('decodes a valid observation', () {
      const source = '''
      [
        {
          "municipality": "Andes",
          "year": 2025,
          "crops": [
            {"name": "Coffee", "plantedArea": 125}
          ]
        }
      ]
      ''';

      List<AgriculturalRecord> records = codec.decodeRecords(source);

      expect(records, hasLength(1));
      expect(records.first.totalArea, equals(125.0));
    });

    test('rejects a JSON object instead of an array', () {
      expect(
        () => codec.decodeRecords('{"municipality":"Andes"}'),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects a crop area with the wrong JSON type', () {
      const source = '''
      [
        {
          "municipality": "Andes",
          "year": 2025,
          "crops": [
            {"name": "Coffee", "plantedArea": "unknown"}
          ]
        }
      ]
      ''';

      expect(
        () => codec.decodeRecords(source),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
