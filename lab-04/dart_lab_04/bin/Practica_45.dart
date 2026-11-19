class ObservationCatalog {
  final Map<String, AgriculturalRecord> _records =
      <String, AgriculturalRecord>{};

  String _buildKey(String municipality, int year) {
    String normalized = municipality.trim().toLowerCase();
    return '$normalized ($year)';
  }

  int get count => _records.length;

  bool add(AgriculturalRecord record) {
    String key = _buildKey(record.municipality, record.year);

    if (_records.containsKey(key)) {
      return false;
    }

    _records[key] = record;
    return true;
  }

  AgriculturalRecord? find(String municipality, int year) {
    String key = _buildKey(municipality, year);
    return _records[key];
  }
}

void main() {
  ObservationCatalog catalog = ObservationCatalog();

  AgriculturalRecord first = AgriculturalRecord(
    municipality: 'Andes',
    year: 2025,
    crops: [
      CropArea(name: 'Coffee', plantedArea: 125.0),
    ],
  );

  print(catalog.add(first));
  print(catalog.count);

  AgriculturalRecord? result = catalog.find(' ANDES ', 2025);

  if (result == null) {
    print('Observation not found.');
  } else {
    print(result.totalArea.toStringAsFixed(2));
  }
}

AgriculturalRecord duplicate = AgriculturalRecord(
  municipality: 'andes',
  year: 2025,
  crops: [
    CropArea(name: 'Beans', plantedArea: 40.0),
  ],
);

bool wasAdded = catalog.add(duplicate);
print(wasAdded);
print(catalog.count);

bool remove(String municipality, int year) {
  String key = _buildKey(municipality, year);
  return _records.remove(key) != null;
}

List<AgriculturalRecord> listRecords() {
  List<AgriculturalRecord> result = _records.values.toList();

  result.sort((first, second) {
    String firstKey = _buildKey(first.municipality, first.year);
    String secondKey = _buildKey(second.municipality, second.year);
    return firstKey.compareTo(secondKey);
  });

  return List<AgriculturalRecord>.unmodifiable(result);
}

List<String> get uniqueCropNames {
  Set<String> names = <String>{};

  for (final record in _records.values) {
    for (final crop in record.crops) {
      names.add(crop.name.toLowerCase());
    }
  }

  List<String> sortedNames = names.toList();
  sortedNames.sort();

  return List<String>.unmodifiable(sortedNames);
}

AgriculturalRecord first = AgriculturalRecord(
  municipality: 'Andes',
  year: 2025,
  crops: [
    CropArea(name: 'Coffee', plantedArea: 125.0),
    CropArea(name: 'Plantain', plantedArea: 75.0),
  ],
);

AgriculturalRecord second = AgriculturalRecord(
  municipality: 'Andes',
  year: 2024,
  crops: [
    CropArea(name: 'Coffee', plantedArea: 110.0),
    CropArea(name: 'Beans', plantedArea: 40.0),
  ],
);

AgriculturalRecord third = AgriculturalRecord(
  municipality: 'La Mesa',
  year: 2025,
  crops: [
    CropArea(name: 'Cocoa', plantedArea: 20.0),
    CropArea(name: 'Plantain', plantedArea: 30.0),
  ],
);