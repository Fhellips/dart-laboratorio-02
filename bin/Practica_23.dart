// ignore: unused_import
import 'dart:io';

void main() {
  var opcion = 2;

  switch (opcion) {
    case 1:
      print('Registrar observación.');
    case 2:
      print('Consultar resumen.');
    case 0:
      print('Salir.');
    default:
      print('Opción desconocida.');
  }

  print('Menú de opciones:');
  print('1. Registrar observación.');
  print('2. Consultar resumen.');
  print('0. Salir.');

  stdout.write('Seleccione una opcion: ');

  var opciones = (stdin.readLineSync() ?? '').trim();
  print('Opción seleccionada: $opciones');

  switch (opciones) {
    case '1':
      print('Registrar observación.');
    case '2':
      print('Consultar resumen.');

    case '0':
      print('Salir.');

    default:
      print('Opción desconocida.');
  }

  // ignore: unused_element
  String obtenerNombreOpcion(String opcion) {
    switch (opcion) {
      case '1':
        return 'Registrar';
      case '2':
        return 'Resumen';
      case '0':
        return 'Salir';
      default:
        return 'Desconocida';
    }
  }

  print(obtenerNombreOpcion("1"));
  print(obtenerNombreOpcion("2"));
  print(obtenerNombreOpcion("0"));

  // ignore: unused_element
  String obtenerNombresOpcion(String opcion) {
    return switch (opcion) {
      '1' => 'Registrar',
      '2' => 'Resumen',
      '0' => 'Salir',
      _ => 'Desconocida',
    };
  }

  print(obtenerNombresOpcion("0"));
}
