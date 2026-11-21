import 'package:dart_lab_05/agrodiversa.dart';
import 'package:test/test.dart';

void main() {
  group('AgriculturalRecord', () {
    test('calculates total, average and largest crop', () {
      final record = AgriculturalRecord(
        municipality: 'Andes',
        year: 2025,
        crops: <CropArea>[
          CropArea(name: 'Coffee', plantedArea: 125.0),
          CropArea(name: 'Plantain', plantedArea: 75.0),
          CropArea(name: 'Avocado', plantedArea: 50.0),
        ],
      );

      expect(record.totalArea, closeTo(250.0, 0.000001));
      expect(record.averageArea, closeTo(250.0 / 3, 0.000001));
      expect(record.largestCrop.name, equals('Coffee'));
    });

    test('rejects duplicate crop names ignoring case', () {
      expect(
        () => AgriculturalRecord(
          municipality: 'Andes',
          year: 2025,
          crops: <CropArea>[
            CropArea(name: 'Coffee', plantedArea: 10.0),
            CropArea(name: 'coffee', plantedArea: 20.0),
          ],
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects invalid year and empty crop list', () {
      expect(
        () => AgriculturalRecord(
          municipality: 'Andes',
          year: 1999,
          crops: <CropArea>[CropArea(name: 'Coffee', plantedArea: 1.0)],
        ),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => AgriculturalRecord(
          municipality: 'Andes',
          year: 2025,
          crops: <CropArea>[],
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('does not retain an externally mutable crop list', () {
      final mutableCrops = <CropArea>[
        CropArea(name: 'Coffee', plantedArea: 10.0),
      ];
      final record = AgriculturalRecord(
        municipality: 'Andes',
        year: 2025,
        crops: mutableCrops,
      );

      mutableCrops.add(CropArea(name: 'Beans', plantedArea: 5.0));
      expect(record.crops, hasLength(1));
    });

    test('keeps the first crop when largest areas are tied', () {
      final record = AgriculturalRecord(
        municipality: 'Andes',
        year: 2025,
        crops: <CropArea>[
          CropArea(name: 'Coffee', plantedArea: 20.0),
          CropArea(name: 'Beans', plantedArea: 20.0),
        ],
      );

      expect(record.largestCrop.name, equals('Coffee'));
    });

    test('rejects a non-finite combined area', () {
      expect(
        () => AgriculturalRecord(
          municipality: 'Andes',
          year: 2025,
          crops: <CropArea>[
            CropArea(name: 'Coffee', plantedArea: 1.0e308),
            CropArea(name: 'Beans', plantedArea: 1.0e308),
          ],
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
