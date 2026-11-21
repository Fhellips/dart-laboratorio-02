import 'dart:io';

import 'package:dart_lab_05/agrodiversa.dart';

void main() {
  File inputFile = File('data/observations.json');
  RecordJsonCodec codec = RecordJsonCodec();

  try {
    String source = inputFile.readAsStringSync();
    List<AgriculturalRecord> records = codec.decodeRecords(source);

    print('Observations: ${records.length}');

    for (final record in records) {
      print('${record.municipality}: ${record.totalArea}');
    }

    String normalizedJson = codec.encodeRecords(records);

    File outputFile = File('data/normalized_observations.json');
    outputFile.writeAsStringSync(normalizedJson);

    print('Normalized file written: ${outputFile.path}');
  } on FileSystemException catch (error) {
    print('File error: ${error.message}');
  } on FormatException catch (error) {
    print('Invalid data: ${error.message}');
  }
}
