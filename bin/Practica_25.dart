// ignore: file_names
import 'dart:io';

void main() {
  int numero = 1;

  while (numero <= 5) {
    print(numero);

    numero++;
  }

  numero = 1;

  do {
    print(numero);

    numero++;
  } while (numero <= 5);

  String entrada = '25';

  int? cantidad = int.tryParse(entrada);

  print(cantidad);

  //

  String entrada1 = 'hola';

  int? cantidad1 = int.tryParse(entrada1);

  if (cantidad1 == null) {
    print('Debe ingresar un número entero.');
  } else {
    print('Cantidad ingresada: $cantidad1');
  }

  double resultado = double.nan;

  print(resultado);

  double superficie = 25.5;

  if (superficie.isFinite) {
    print('El número es válido.');
  } else {
    print('El número no es válido.');
  }

  String entrada2 = '25.5';

  double? superficie1 = double.tryParse(entrada2);

  if (superficie1 != null && superficie1.isFinite) {
    print('Superficie válida: $superficie1');
  } else {
    print('Debe ingresar un número válido.');
  }

  // ignore: unused_element
  String leerTextoObligatorio(String mensaje) {
    while (true) {
      stdout.write(mensaje);

      String texto = (stdin.readLineSync() ?? '').trim();

      if (texto.isNotEmpty) {
        return texto;
      }

      print('Este campo es obligatorio.');
    }
  }

  // ignore: unused_local_variable
  String municipio = leerTextoObligatorio('Ingrese el municipio: ');
  // ignore: unused_local_variable
  String cultivo = leerTextoObligatorio('Ingrese el cultivo: ');

  // ignore: unused_element
  int leerEnteroEnRango(String mensaje, int minimo, int maximo) {
    while (true) {
      stdout.write(mensaje);

      String entrada = stdin.readLineSync() ?? '';

      int? numero = int.tryParse(entrada);

      if (numero != null && numero >= minimo && numero <= maximo) {
        return numero;
      }

      print('Ingrese un número entero entre $minimo y $maximo.');
    }
  }

  int cantidadCultivos = leerEnteroEnRango(
    '¿Cuántos cultivos desea registrar? ',
    1,
    5,
  );

  print('Cantidad seleccionada: $cantidadCultivos');

  // ignore: unused_element
  double leerAreaPositiva(String mensaje) {
    while (true) {
      stdout.write(mensaje);

      String entrada = stdin.readLineSync() ?? '';

      double? area = double.tryParse(entrada);

      if (area != null && area.isFinite && area > 0) {
        return area;
      }

      print('Ingrese un área válida, positiva y finita.');
    }
  }

  double superficie3 = leerAreaPositiva('Ingrese la superficie del cultivo: ');

  print('Superficie registrada: $superficie3 hectáreas');
}
