// ignore: unused_import
import 'dart:io';

void main() {
  for (int numeroCultivo = 1; numeroCultivo <= 3; numeroCultivo++) {
    print('Ingrese el nombre del cultivo $numeroCultivo');
  }

  int contador = 0;

  for (int numeroCultivo = 1; numeroCultivo <= 3; numeroCultivo++) {
    contador++;
  }

  print('Cultivos registrados: $contador');

  double superficieTotal1 = 0.0;

  superficieTotal1 += 10.0;
  superficieTotal1 += 20.0;
  superficieTotal1 += 15.0;

  print('Superficie total: $superficieTotal1 hectáreas');

  var superficieTotal = 0.0;

  for (int numeroCultivo = 1; numeroCultivo <= 3; numeroCultivo++) {
    stdout.write('Ingrese la superficie del cultivo $numeroCultivo: ');

    String entrada = stdin.readLineSync() ?? '';

    double superficie = double.tryParse(entrada) ?? 0.0;

    superficieTotal += superficie;
  }

  print('Superficie total: $superficieTotal hectáreas');

  superficieTotal = 60.0;
  int cantidadCultivos = 4;

  if (cantidadCultivos > 0) {
    double promedio = superficieTotal / cantidadCultivos;

    print('Superficie promedio: $promedio hectáreas');
  } else {
    print('No hay cultivos registrados.');
  }

  var mayorSuperficie = 0.0;

  double superficie = 15.0;

  if (superficie > mayorSuperficie) {
    mayorSuperficie = superficie;
  }

  print('Mayor superficie: $mayorSuperficie');

  for (int numero = 1; numero <= 5; numero++) {
    if (numero == 3) {
      break;
    }

    print(numero);
  }

  for (int numero = 1; numero <= 5; numero++) {
    if (numero == 3) {
      continue;
    }

    print(numero);
  }
}
