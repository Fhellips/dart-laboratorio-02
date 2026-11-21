import 'package:dart_lab_05/agrodiversa.dart';
import 'package:test/test.dart';

void main() {
  group('AgriculturalRecord', () {
    test('calculates total, average, and largest crop', () {
      AgriculturalRecord record = AgriculturalRecord(
        municipality: 'Andes',
        year: 2025,
        crops: [
          CropArea(name: 'Coffee', plantedArea: 125.0),
          CropArea(name: 'Plantain', plantedArea: 75.0),
          CropArea(name: 'Avocado', plantedArea: 50.0),
        ],
      );

      expect(record.totalArea, closeTo(250.0, 0.000001));
      expect(record.averageArea, closeTo(250.0 / 3, 0.000001));
      expect(record.largestCrop.name, equals('Coffee'));
    });

    test('rejects duplicate names ignoring case', () {
      expect(
        () => AgriculturalRecord(
          municipality: 'Andes',
          year: 2025,
          crops: [
            CropArea(name: 'Coffee', plantedArea: 10.0),
            CropArea(name: 'coffee', plantedArea: 20.0),
          ],
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
