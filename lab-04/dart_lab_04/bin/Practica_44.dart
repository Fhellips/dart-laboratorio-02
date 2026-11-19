class CropArea {
  final String name;
  final double plantedArea;

  CropArea({
    required String name,
    required this.plantedArea,
  }) : name = name.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Name is required.');
    }

    if (!plantedArea.isFinite || plantedArea <= 0) {
      throw ArgumentError.value(
        plantedArea,
        'plantedArea',
        'Area must be positive and finite.',
      );
    }
  }
}

class AgriculturalRecord {
  final String municipality;
  final int year;
  final List<CropArea> crops;

  AgriculturalRecord({
    required String municipality,
    required this.year,
    required List<CropArea> crops,
  })  : municipality = municipality.trim(),
        crops = List<CropArea>.unmodifiable(crops) {
    if (this.municipality.isEmpty) {
      throw ArgumentError.value(
        municipality,
        'municipality',
        'Municipality is required.',
      );
    }

    if (year < 2000 || year > 2100) {
      throw ArgumentError.value(year, 'year', 'Invalid year.');
    }

    if (this.crops.isEmpty) {
      throw ArgumentError.value(crops, 'crops', 'At least one crop is required.');
    }

    Set<String> uniqueNames = <String>{};

    for (final crop in this.crops) {
      String normalizedName = crop.name.toLowerCase();

      if (!uniqueNames.add(normalizedName)) {
        throw ArgumentError.value(
          crop.name,
          'crop',
          'Duplicate crop name.',
        );
      }
    }

    if (!totalArea.isFinite) {
      throw ArgumentError('Total area must be finite.');
    }
  }

  double get totalArea {
    double total = 0.0;

    for (final crop in crops) {
      total += crop.plantedArea;
    }

    return total;
  }

  double get averageArea => totalArea / crops.length;

  CropArea get largestCrop {
    CropArea largest = crops.first;

    for (final crop in crops.skip(1)) {
      if (crop.plantedArea > largest.plantedArea) {
        largest = crop;
      }
    }

    return largest;
  }

  double get largestShare => largestCrop.plantedArea / totalArea * 100;
}

void main() {
  AgriculturalRecord record = AgriculturalRecord(
    municipality: 'Andes',
    year: 2025,
    crops: [
      CropArea(name: 'Coffee', plantedArea: 125.0),
      CropArea(name: 'Plantain', plantedArea: 75.0),
      CropArea(name: 'Avocado', plantedArea: 50.0),
    ],
  );

  print(record.municipality);
  print(record.year);
  print(record.crops.length);
  print(record.totalArea.toStringAsFixed(2));
  print(record.averageArea.toStringAsFixed(2));
  print(record.largestCrop.name);
  print(record.largestShare.toStringAsFixed(2));
}
