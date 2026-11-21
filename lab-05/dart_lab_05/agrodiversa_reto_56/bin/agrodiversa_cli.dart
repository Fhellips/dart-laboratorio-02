import 'dart:io';

import 'package:dart_lab_05/agrodiversa.dart';

ReportFormatter? selectFormatter(List<String> arguments) {
  final String format = arguments.isEmpty ? 'compact' : arguments.first;

  if (arguments.length > 1) {
    return null;
  }

  switch (format) {
    case 'compact':
      return CompactFormatter();
    case 'detailed':
      return DetailedFormatter();
    default:
      return null;
  }
}

void main(List<String> arguments) {
  final ReportFormatter? formatter = selectFormatter(arguments);

  if (formatter == null) {
    stderr.writeln(
      'Usage: dart run bin/agrodiversa_cli.dart [compact|detailed]',
    );
    exitCode = 2;
    return;
  }

  final File sourceFile = File('data/observations.json');
  final File outputFile = File('data/normalized_observations.json');
  final RecordJsonCodec codec = RecordJsonCodec();

  try {
    final String source = sourceFile.readAsStringSync();
    final List<AgriculturalRecord> records = codec.decodeRecords(source);

    stdout.writeln('Valid observations: ${records.length}');

    if (records.isEmpty) {
      stdout.writeln('No observations available.');
    } else {
      for (final record in records) {
        final double total = record.totalArea;
        final double average = record.averageArea;
        final CropArea largest = record.largestCrop;
        final double largestShare = largest.plantedArea / total * 100;
        final String title = '${record.municipality} (${record.year})';

        stdout.writeln(formatter.format(title, total));

        if (formatter is DetailedFormatter) {
          stdout.writeln('  Crops: ${record.crops.length}');
          stdout.writeln('  Average area: ${average.toStringAsFixed(2)} ha');
          stdout.writeln(
            '  Largest crop: ${largest.name} '
            '(${largest.plantedArea.toStringAsFixed(2)} ha)',
          );
          stdout.writeln('  Largest crop share: ${largestShare.toStringAsFixed(2)}%');
        } else {
          stdout.writeln(
            '  ${record.crops.length} crops | '
            'average ${average.toStringAsFixed(2)} ha | '
            'largest ${largest.name} '
            '${largest.plantedArea.toStringAsFixed(2)} ha '
            '(${largestShare.toStringAsFixed(2)}%)',
          );
        }
      }

      final double grandTotal = records.fold<double>(
        0.0,
        (sum, record) => sum + record.totalArea,
      );

      if (!grandTotal.isFinite) {
        throw FormatException('Combined area is not finite.');
      }

      stdout.writeln('Grand total: ${grandTotal.toStringAsFixed(2)} ha');
    }

    // Export only after every record and the combined total have been validated.
    final String normalizedJson = codec.encodeRecords(records);
    outputFile.writeAsStringSync(normalizedJson);
    stdout.writeln('Normalized file written: ${outputFile.path}');
  } on FileSystemException catch (error) {
    stderr.writeln('File error: ${error.message}');
    exitCode = 1;
  } on FormatException catch (error) {
    stderr.writeln('Invalid agricultural data: ${error.message}');
    exitCode = 1;
  }
}
