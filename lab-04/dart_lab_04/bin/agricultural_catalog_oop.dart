
import 'dart:io';

// =====================================================
// CLASE 1: CROP AREA
// Representa un cultivo y su superficie sembrada.
// =====================================================

class CropArea {
  final String name;
  final double plantedArea;

  CropArea({
    required String name,
    required this.plantedArea,
  }) : name = name.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError('El nombre del cultivo no puede estar vacío.');
    }

    if (!plantedArea.isFinite || plantedArea <= 0) {
      throw ArgumentError('La superficie debe ser positiva y finita.');
    }
  }

  String describe() {
    return '$name: ${plantedArea.toStringAsFixed(2)} ha';
  }
}

// =====================================================
// CLASE 2: AGRICULTURAL RECORD
// Representa una observación agrícola.
// Contiene varios objetos CropArea.
// =====================================================

class AgriculturalRecord {
  final String municipality;
  final int year;
  final List<CropArea> _crops;

  AgriculturalRecord({
    required String municipality,
    required this.year,
    required List<CropArea> crops,
  }) : municipality = municipality.trim(),
       _crops = List<CropArea>.unmodifiable(crops) {
    if (this.municipality.isEmpty) {
      throw ArgumentError('El municipio no puede estar vacío.');
    }

    if (year < 2000 || year > 2100) {
      throw ArgumentError('El año debe estar entre 2000 y 2100.');
    }

    if (crops.isEmpty || crops.length > 5) {
      throw ArgumentError('Debe registrar entre 1 y 5 cultivos.');
    }

    final Set<String> nombres = <String>{};

    for (final crop in crops) {
      final String nombreNormalizado = crop.name.toLowerCase();

      if (!nombres.add(nombreNormalizado)) {
        throw ArgumentError('No se permiten cultivos repetidos.');
      }
    }
  }

  List<CropArea> get crops => _crops;

  double get totalArea {
    return _crops.fold(
      0.0,
      (total, crop) => total + crop.plantedArea,
    );
  }

  double get averageArea {
    return totalArea / _crops.length;
  }

  CropArea get largestCrop {
    CropArea mayor = _crops.first;

    for (final crop in _crops) {
      if (crop.plantedArea > mayor.plantedArea) {
        mayor = crop;
      }
    }

    return mayor;
  }

  double get largestShare {
    return largestCrop.plantedArea / totalArea * 100;
  }
}

// =====================================================
// CLASE 3: OBSERVATION CATALOG
// Administra varias observaciones agrícolas.
// =====================================================

class ObservationCatalog {
  final Map<String, AgriculturalRecord> _records =
      <String, AgriculturalRecord>{};

  String _buildKey(String municipality, int year) {
    final String municipioNormalizado =
        municipality.trim().toLowerCase();

    return '$municipioNormalizado ($year)';
  }

  int get count => _records.length;

  bool add(AgriculturalRecord record) {
    final String key = _buildKey(
      record.municipality,
      record.year,
    );

    if (_records.containsKey(key)) {
      return false;
    }

    _records[key] = record;
    return true;
  }

  AgriculturalRecord? find(String municipality, int year) {
    final String key = _buildKey(municipality, year);
    return _records[key];
  }

  bool remove(String municipality, int year) {
    final String key = _buildKey(municipality, year);

    if (!_records.containsKey(key)) {
      return false;
    }

    _records.remove(key);
    return true;
  }

  List<AgriculturalRecord> listRecords() {
    final List<AgriculturalRecord> records =
        _records.values.toList();

    records.sort((a, b) {
      final int comparison = a.municipality
          .toLowerCase()
          .compareTo(b.municipality.toLowerCase());

      if (comparison != 0) {
        return comparison;
      }

      return a.year.compareTo(b.year);
    });

    return List<AgriculturalRecord>.unmodifiable(records);
  }

  List<String> get uniqueCropNames {
    final Set<String> names = <String>{};

    for (final record in _records.values) {
      for (final crop in record.crops) {
        names.add(crop.name.toLowerCase());
      }
    }

    final List<String> result = names.toList()..sort();

    return List<String>.unmodifiable(result);
  }
}

// =====================================================
// FUNCIONES PARA LEER Y VALIDAR DATOS
// =====================================================

String? readRequiredText(String prompt) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final String text = input.trim();

    if (text.isNotEmpty) {
      return text;
    }

    print('El texto no puede estar vacío.');
  }
}

int? readIntInRange(
  String prompt,
  int minimum,
  int maximum,
) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final int? number = int.tryParse(input.trim());

    if (number == null || number < minimum || number > maximum) {
      print('Ingrese un número entre $minimum y $maximum.');
      continue;
    }

    return number;
  }
}

double? readPositiveArea(String prompt) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final double? area = double.tryParse(input.trim());

    if (area == null || !area.isFinite || area <= 0) {
      print('Ingrese una superficie positiva y finita.');
      continue;
    }

    return area;
  }
}

String? readUniqueCropName(
  String prompt,
  Set<String> usedNames,
) {
  while (true) {
    final String? rawName = readRequiredText(prompt);

    if (rawName == null) {
      return null;
    }

    final String normalizedName = rawName.trim().toLowerCase();

    if (!usedNames.add(normalizedName)) {
      print('Ese cultivo ya está registrado en esta observación.');
      continue;
    }

    return rawName.trim();
  }
}

// =====================================================
// REGISTRAR UNA OBSERVACIÓN
// =====================================================

bool registerObservation(ObservationCatalog catalog) {
  final String? municipality =
      readRequiredText('Municipio: ');

  if (municipality == null) {
    return false;
  }

  final int? year = readIntInRange(
    'Año (2000-2100): ',
    2000,
    2100,
  );

  if (year == null) {
    return false;
  }

  if (catalog.find(municipality, year) != null) {
    print('Ya existe una observación para ese municipio y año.');
    return true;
  }

  final int? cropCount = readIntInRange(
    'Cantidad de cultivos (1-5): ',
    1,
    5,
  );

  if (cropCount == null) {
    return false;
  }

  final List<CropArea> currentCrops = <CropArea>[];
  final Set<String> usedNames = <String>{};

  for (int index = 1; index <= cropCount; index++) {
    final String? cropName = readUniqueCropName(
      'Nombre del cultivo $index: ',
      usedNames,
    );

    if (cropName == null) {
      return false;
    }

    final double? area = readPositiveArea(
      'Superficie del cultivo $index (ha): ',
    );

    if (area == null) {
      return false;
    }

    currentCrops.add(
      CropArea(
        name: cropName,
        plantedArea: area,
      ),
    );
  }

  final AgriculturalRecord record = AgriculturalRecord(
    municipality: municipality,
    year: year,
    crops: currentCrops,
  );

  final bool wasAdded = catalog.add(record);

  if (wasAdded) {
    print('Observación registrada correctamente.');
  } else {
    print('No se pudo registrar la observación.');
  }

  return true;
}

// =====================================================
// LISTAR OBSERVACIONES
// =====================================================

void listObservations(ObservationCatalog catalog) {
  final List<AgriculturalRecord> records =
      catalog.listRecords();

  if (records.isEmpty) {
    print('No hay observaciones registradas.');
    return;
  }

  print('\n===== OBSERVACIONES REGISTRADAS =====');

  for (final record in records) {
    print(
      '${record.municipality} (${record.year}): '
      '${record.crops.length} cultivos',
    );
  }

  print('Total de observaciones: ${catalog.count}');
}

// =====================================================
// MOSTRAR DETALLES DE UNA OBSERVACIÓN
// =====================================================

void showObservation(AgriculturalRecord record) {
  print('\n===== DETALLE DE LA OBSERVACIÓN =====');

  print('Municipio: ${record.municipality}');
  print('Año: ${record.year}');

  print('\nCultivos:');

  for (final crop in record.crops) {
    print(crop.describe());
  }

  print('\nCantidad de cultivos: ${record.crops.length}');
  print('Área total: ${record.totalArea.toStringAsFixed(2)} ha');
  print('Área promedio: ${record.averageArea.toStringAsFixed(2)} ha');

  print(
    'Cultivo con mayor superficie: '
    '${record.largestCrop.name} '
    '(${record.largestCrop.plantedArea.toStringAsFixed(2)} ha)',
  );

  print(
    'Participación del cultivo mayor: '
    '${record.largestShare.toStringAsFixed(2)}%',
  );
}

// =====================================================
// CONSULTAR UNA OBSERVACIÓN
// =====================================================

bool viewObservation(ObservationCatalog catalog) {
  final String? municipality =
      readRequiredText('Municipio que desea consultar: ');

  if (municipality == null) {
    return false;
  }

  final int? year = readIntInRange(
    'Año: ',
    2000,
    2100,
  );

  if (year == null) {
    return false;
  }

  final AgriculturalRecord? record =
      catalog.find(municipality, year);

  if (record == null) {
    print('No se encontró esa observación.');
  } else {
    showObservation(record);
  }

  return true;
}

// =====================================================
// ELIMINAR UNA OBSERVACIÓN
// =====================================================

bool removeObservation(ObservationCatalog catalog) {
  final String? municipality =
      readRequiredText('Municipio que desea eliminar: ');

  if (municipality == null) {
    return false;
  }

  final int? year = readIntInRange(
    'Año: ',
    2000,
    2100,
  );

  if (year == null) {
    return false;
  }

  final bool wasRemoved = catalog.remove(municipality, year);

  if (wasRemoved) {
    print('Observación eliminada correctamente.');
  } else {
    print('No se encontró esa observación.');
  }

  return true;
}

// =====================================================
// PROGRAMA PRINCIPAL Y MENÚ
// =====================================================

void main() {
  final ObservationCatalog catalog = ObservationCatalog();

  while (true) {
    print('\n================================');
    print('       AGRODIVERSA OOP');
    print('================================');
    print('1. Registrar observación');
    print('2. Listar observaciones');
    print('3. Consultar observación');
    print('4. Mostrar cultivos únicos');
    print('5. Eliminar observación');
    print('0. Salir');

    final int? option = readIntInRange(
      'Seleccione una opción: ',
      0,
      5,
    );

    if (option == null || option == 0) {
      print('¡Hasta pronto!');
      return;
    }

    switch (option) {
      case 1:
        if (!registerObservation(catalog)) {
          return;
        }
        break;

      case 2:
        listObservations(catalog);
        break;

      case 3:
        if (!viewObservation(catalog)) {
          return;
        }
        break;

      case 4:
        if (catalog.uniqueCropNames.isEmpty) {
          print('Todavía no hay cultivos registrados.');
        } else {
          print('\n===== CULTIVOS ÚNICOS =====');

          for (final name in catalog.uniqueCropNames) {
            print(name);
          }
        }
        break;

      case 5:
        if (!removeObservation(catalog)) {
          return;
        }
        break;
    }
  }
}

import 'dart:io';

// =====================================================
// CLASE 1: CROP AREA
// Representa un cultivo y su superficie sembrada.
// =====================================================

class CropArea {
  final String name;
  final double plantedArea;

  CropArea({
    required String name,
    required this.plantedArea,
  }) : name = name.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError('El nombre del cultivo no puede estar vacío.');
    }

    if (!plantedArea.isFinite || plantedArea <= 0) {
      throw ArgumentError('La superficie debe ser positiva y finita.');
    }
  }

  String describe() {
    return '$name: ${plantedArea.toStringAsFixed(2)} ha';
  }
}

// =====================================================
// CLASE 2: AGRICULTURAL RECORD
// Representa una observación agrícola.
// Contiene varios objetos CropArea.
// =====================================================

class AgriculturalRecord {
  final String municipality;
  final int year;
  final List<CropArea> _crops;

  AgriculturalRecord({
    required String municipality,
    required this.year,
    required List<CropArea> crops,
  }) : municipality = municipality.trim(),
       _crops = List<CropArea>.unmodifiable(crops) {
    if (this.municipality.isEmpty) {
      throw ArgumentError('El municipio no puede estar vacío.');
    }

    if (year < 2000 || year > 2100) {
      throw ArgumentError('El año debe estar entre 2000 y 2100.');
    }

    if (crops.isEmpty || crops.length > 5) {
      throw ArgumentError('Debe registrar entre 1 y 5 cultivos.');
    }

    final Set<String> nombres = <String>{};

    for (final crop in crops) {
      final String nombreNormalizado = crop.name.toLowerCase();

      if (!nombres.add(nombreNormalizado)) {
        throw ArgumentError('No se permiten cultivos repetidos.');
      }
    }
  }

  List<CropArea> get crops => _crops;

  double get totalArea {
    return _crops.fold(
      0.0,
      (total, crop) => total + crop.plantedArea,
    );
  }

  double get averageArea {
    return totalArea / _crops.length;
  }

  CropArea get largestCrop {
    CropArea mayor = _crops.first;

    for (final crop in _crops) {
      if (crop.plantedArea > mayor.plantedArea) {
        mayor = crop;
      }
    }

    return mayor;
  }

  double get largestShare {
    return largestCrop.plantedArea / totalArea * 100;
  }
}

// =====================================================
// CLASE 3: OBSERVATION CATALOG
// Administra varias observaciones agrícolas.
// =====================================================

class ObservationCatalog {
  final Map<String, AgriculturalRecord> _records =
      <String, AgriculturalRecord>{};

  String _buildKey(String municipality, int year) {
    final String municipioNormalizado =
        municipality.trim().toLowerCase();

    return '$municipioNormalizado ($year)';
  }

  int get count => _records.length;

  bool add(AgriculturalRecord record) {
    final String key = _buildKey(
      record.municipality,
      record.year,
    );

    if (_records.containsKey(key)) {
      return false;
    }

    _records[key] = record;
    return true;
  }

  AgriculturalRecord? find(String municipality, int year) {
    final String key = _buildKey(municipality, year);
    return _records[key];
  }

  bool remove(String municipality, int year) {
    final String key = _buildKey(municipality, year);

    if (!_records.containsKey(key)) {
      return false;
    }

    _records.remove(key);
    return true;
  }

  List<AgriculturalRecord> listRecords() {
    final List<AgriculturalRecord> records =
        _records.values.toList();

    records.sort((a, b) {
      final int comparison = a.municipality
          .toLowerCase()
          .compareTo(b.municipality.toLowerCase());

      if (comparison != 0) {
        return comparison;
      }

      return a.year.compareTo(b.year);
    });

    return List<AgriculturalRecord>.unmodifiable(records);
  }

  List<String> get uniqueCropNames {
    final Set<String> names = <String>{};

    for (final record in _records.values) {
      for (final crop in record.crops) {
        names.add(crop.name.toLowerCase());
      }
    }

    final List<String> result = names.toList()..sort();

    return List<String>.unmodifiable(result);
  }
}

// =====================================================
// FUNCIONES PARA LEER Y VALIDAR DATOS
// =====================================================

String? readRequiredText(String prompt) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final String text = input.trim();

    if (text.isNotEmpty) {
      return text;
    }

    print('El texto no puede estar vacío.');
  }
}

int? readIntInRange(
  String prompt,
  int minimum,
  int maximum,
) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final int? number = int.tryParse(input.trim());

    if (number == null || number < minimum || number > maximum) {
      print('Ingrese un número entre $minimum y $maximum.');
      continue;
    }

    return number;
  }
}

double? readPositiveArea(String prompt) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final double? area = double.tryParse(input.trim());

    if (area == null || !area.isFinite || area <= 0) {
      print('Ingrese una superficie positiva y finita.');
      continue;
    }

    return area;
  }
}

String? readUniqueCropName(
  String prompt,
  Set<String> usedNames,
) {
  while (true) {
    final String? rawName = readRequiredText(prompt);

    if (rawName == null) {
      return null;
    }

    final String normalizedName = rawName.trim().toLowerCase();

    if (!usedNames.add(normalizedName)) {
      print('Ese cultivo ya está registrado en esta observación.');
      continue;
    }

    return rawName.trim();
  }
}

// =====================================================
// REGISTRAR UNA OBSERVACIÓN
// =====================================================

bool registerObservation(ObservationCatalog catalog) {
  final String? municipality =
      readRequiredText('Municipio: ');

  if (municipality == null) {
    return false;
  }

  final int? year = readIntInRange(
    'Año (2000-2100): ',
    2000,
    2100,
  );

  if (year == null) {
    return false;
  }

  if (catalog.find(municipality, year) != null) {
    print('Ya existe una observación para ese municipio y año.');
    return true;
  }

  final int? cropCount = readIntInRange(
    'Cantidad de cultivos (1-5): ',
    1,
    5,
  );

  if (cropCount == null) {
    return false;
  }

  final List<CropArea> currentCrops = <CropArea>[];
  final Set<String> usedNames = <String>{};

  for (int index = 1; index <= cropCount; index++) {
    final String? cropName = readUniqueCropName(
      'Nombre del cultivo $index: ',
      usedNames,
    );

    if (cropName == null) {
      return false;
    }

    final double? area = readPositiveArea(
      'Superficie del cultivo $index (ha): ',
    );

    if (area == null) {
      return false;
    }

    currentCrops.add(
      CropArea(
        name: cropName,
        plantedArea: area,
      ),
    );
  }

  final AgriculturalRecord record = AgriculturalRecord(
    municipality: municipality,
    year: year,
    crops: currentCrops,
  );

  final bool wasAdded = catalog.add(record);

  if (wasAdded) {
    print('Observación registrada correctamente.');
  } else {
    print('No se pudo registrar la observación.');
  }

  return true;
}

// =====================================================
// LISTAR OBSERVACIONES
// =====================================================

void listObservations(ObservationCatalog catalog) {
  final List<AgriculturalRecord> records =
      catalog.listRecords();

  if (records.isEmpty) {
    print('No hay observaciones registradas.');
    return;
  }

  print('\n===== OBSERVACIONES REGISTRADAS =====');

  for (final record in records) {
    print(
      '${record.municipality} (${record.year}): '
      '${record.crops.length} cultivos',
    );
  }

  print('Total de observaciones: ${catalog.count}');
}

// =====================================================
// MOSTRAR DETALLES DE UNA OBSERVACIÓN
// =====================================================

void showObservation(AgriculturalRecord record) {
  print('\n===== DETALLE DE LA OBSERVACIÓN =====');

  print('Municipio: ${record.municipality}');
  print('Año: ${record.year}');

  print('\nCultivos:');

  for (final crop in record.crops) {
    print(crop.describe());
  }

  print('\nCantidad de cultivos: ${record.crops.length}');
  print('Área total: ${record.totalArea.toStringAsFixed(2)} ha');
  print('Área promedio: ${record.averageArea.toStringAsFixed(2)} ha');

  print(
    'Cultivo con mayor superficie: '
    '${record.largestCrop.name} '
    '(${record.largestCrop.plantedArea.toStringAsFixed(2)} ha)',
  );

  print(
    'Participación del cultivo mayor: '
    '${record.largestShare.toStringAsFixed(2)}%',
  );
}

// =====================================================
// CONSULTAR UNA OBSERVACIÓN
// =====================================================

bool viewObservation(ObservationCatalog catalog) {
  final String? municipality =
      readRequiredText('Municipio que desea consultar: ');

  if (municipality == null) {
    return false;
  }

  final int? year = readIntInRange(
    'Año: ',
    2000,
    2100,
  );

  if (year == null) {
    return false;
  }

  final AgriculturalRecord? record =
      catalog.find(municipality, year);

  if (record == null) {
    print('No se encontró esa observación.');
  } else {
    showObservation(record);
  }

  return true;
}

// =====================================================
// ELIMINAR UNA OBSERVACIÓN
// =====================================================

bool removeObservation(ObservationCatalog catalog) {
  final String? municipality =
      readRequiredText('Municipio que desea eliminar: ');

  if (municipality == null) {
    return false;
  }

  final int? year = readIntInRange(
    'Año: ',
    2000,
    2100,
  );

  if (year == null) {
    return false;
  }

  final bool wasRemoved = catalog.remove(municipality, year);

  if (wasRemoved) {
    print('Observación eliminada correctamente.');
  } else {
    print('No se encontró esa observación.');
  }

  return true;
}

// =====================================================
// PROGRAMA PRINCIPAL Y MENÚ
// =====================================================

void main() {
  final ObservationCatalog catalog = ObservationCatalog();

  while (true) {
    print('\n================================');
    print('       AGRODIVERSA OOP');
    print('================================');
    print('1. Registrar observación');
    print('2. Listar observaciones');
    print('3. Consultar observación');
    print('4. Mostrar cultivos únicos');
    print('5. Eliminar observación');
    print('0. Salir');

    final int? option = readIntInRange(
      'Seleccione una opción: ',
      0,
      5,
    );

    if (option == null || option == 0) {
      print('¡Hasta pronto!');
      return;
    }

    switch (option) {
      case 1:
        if (!registerObservation(catalog)) {
          return;
        }
        break;

      case 2:
        listObservations(catalog);
        break;

      case 3:
        if (!viewObservation(catalog)) {
          return;
        }
        break;

      case 4:
        if (catalog.uniqueCropNames.isEmpty) {
          print('Todavía no hay cultivos registrados.');
        } else {
          print('\n===== CULTIVOS ÚNICOS =====');

          for (final name in catalog.uniqueCropNames) {
            print(name);
          }
        }
        break;

      case 5:
        if (!removeObservation(catalog)) {
          return;
        }
        break;
    }
  }
}
