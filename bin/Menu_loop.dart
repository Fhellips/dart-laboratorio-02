import 'dart:io';

void main() {
  String opcion = '';

  while (opcion != '0') {
    print('\n===== EXPLORADOR AGRÍCOLA =====');
    print('1. Registrar observación');
    print('2. Consultar resumen');
    print('0. Salir');

    stdout.write('Seleccione una opción: ');

    opcion = (stdin.readLineSync() ?? '').trim();

    switch (opcion) {
      case '1':
        print('Registrando observación...');
      case '2':
        print('Consultando resumen...');
      case '0':
        print('Saliendo del programa...');
      default:
        print('Opción no válida.');
    }
  }
}
