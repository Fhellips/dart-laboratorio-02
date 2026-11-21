import 'package:dart_lab_05/agrodiversa.dart';
import 'package:test/test.dart';

void main() {
  group('CropArea', () {
    test('accepts a positive finite area and a non-empty name', () {
      CropArea crop = CropArea(name: ' Coffee ', plantedArea: 125.0);

      expect(crop.name, equals('Coffee'));
      expect(crop.plantedArea, equals(125.0));
    });

    test('rejects an empty crop name', () {
      expect(
        () => CropArea(name: '   ', plantedArea: 10.0),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
