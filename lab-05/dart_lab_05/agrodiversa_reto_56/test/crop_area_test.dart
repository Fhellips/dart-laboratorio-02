import 'package:dart_lab_05/agrodiversa.dart';
import 'package:test/test.dart';

void main() {
  group('CropArea', () {
    test('trims a valid name and accepts a positive finite area', () {
      final crop = CropArea(name: ' Coffee ', plantedArea: 125.0);
      expect(crop.name, equals('Coffee'));
      expect(crop.plantedArea, equals(125.0));
    });

    test('rejects an empty name', () {
      expect(
        () => CropArea(name: '   ', plantedArea: 10.0),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects zero, negative, NaN and infinite areas', () {
      for (final area in <double>[
        0.0,
        -1.0,
        double.nan,
        double.infinity,
      ]) {
        expect(
          () => CropArea(name: 'Coffee', plantedArea: area),
          throwsA(isA<FormatException>()),
        );
      }
    });
  });
}
