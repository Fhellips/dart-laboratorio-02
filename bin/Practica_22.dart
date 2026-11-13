// ignore: unused_import
import 'dart:io';

void main() {
  var area = 0.0;

  if (area >= 0) {
    print('El área es positiva');
  } else {
    print('El área no puede ser negativa');
  }

  stdout.write('Ingrese el municipio: ');

  var municipio = (stdin.readLineSync() ?? '').trim();

  if (municipio.isEmpty) {
    print('El municipio no puede estar vacío');
  } else {
    print('El municipio ingresado es: $municipio');
  }

  var mayorParticipacion = 80.0;

  if (mayorParticipacion >= 75) {
    print('Participación muy alta.');
  } else if (mayorParticipacion >= 50) {
    print('Participación alta.');
  } else if (mayorParticipacion >= 25) {
    print('Participación moderada.');
  } else {
    print('Participación baja.');
  }

  double areaCultivo = 0.0;
  double areaTotal = 0.0;

  if (areaTotal > 0) {
    double participacion = areaCultivo / areaTotal * 100;
    String porcentajeFormateado = participacion.toStringAsFixed(2);

    print('Participación: $porcentajeFormateado%');
  } else {
    print('El área total debe ser positiva.');
  }

  area = 25.0;

  if (area > 0) {
    print('El área es positiva.');

    if (area >= 10) {
      print('El cultivo tiene un área considerable.');
    } else {
      print('El cultivo tiene un área pequeña.');
    }
  } else {
    print('El área no es válida.');
  }

  municipio = 'Andes';
  int anio = 2026;

  if (municipio.isNotEmpty && area > 0 && anio > 0) {
    print('El registro es válido.');
  } else {
    print('El registro no es válido.');
  }
}
