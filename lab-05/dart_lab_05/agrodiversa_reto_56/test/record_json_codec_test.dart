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

      final records = codec.decodeRecords(source);
      expect(records, hasLength(1));
      expect(records.first.totalArea, equals(125.0));
    });

    test('accepts an empty JSON array', () {
      expect(codec.decodeRecords('[]'), isEmpty);
    });

    test('rejects a JSON object instead of an array', () {
      expect(
        () => codec.decodeRecords('{"municipality":"Andes"}'),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects malformed JSON', () {
      expect(
        () => codec.decodeRecords('[{"municipality":]'),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects crop area with the wrong JSON type', () {
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

    test('rejects duplicate municipality and year ignoring case', () {
      const source = '''
      [
        {
          "municipality": "Andes",
          "year": 2025,
          "crops": [{"name": "Coffee", "plantedArea": 10}]
        },
        {
          "municipality": "ANDES",
          "year": 2025,
          "crops": [{"name": "Beans", "plantedArea": 20}]
        }
      ]
      ''';

      expect(
        () => codec.decodeRecords(source),
        throwsA(isA<FormatException>()),
      );
    });

    test('encodes and decodes records without losing their values', () {
      final original = <AgriculturalRecord>[
        AgriculturalRecord(
          municipality: 'Andes',
          year: 2025,
          crops: <CropArea>[
            CropArea(name: 'Coffee', plantedArea: 125.0),
            CropArea(name: 'Plantain', plantedArea: 75.0),
          ],
        ),
      ];

      final encoded = codec.encodeRecords(original);
      final decoded = codec.decodeRecords(encoded);

      expect(decoded, hasLength(1));
      expect(decoded.first.municipality, equals('Andes'));
      expect(decoded.first.year, equals(2025));
      expect(decoded.first.crops, hasLength(2));
      expect(decoded.first.crops.first.plantedArea, equals(125.0));
    });
  });
}
