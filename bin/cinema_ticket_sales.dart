import 'dart:io';

// Solicita un número entero dentro de un rango.
int? leerEnteroEnRango(String mensaje, int minimo, int maximo) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print('\nFin de entrada. Cerrando programa.');
      return null;
    }

    int? numero = int.tryParse(entrada.trim());

    if (numero != null && numero >= minimo && numero <= maximo) {
      return numero;
    }

    print('Ingrese un número entero entre $minimo y $maximo.');
  }
}

// Solicita una cantidad de entradas mayor que cero.
int? leerCantidadPositiva(String mensaje) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print('\nFin de entrada. Cerrando programa.');
      return null;
    }

    int? cantidad = int.tryParse(entrada.trim());

    if (cantidad != null && cantidad > 0) {
      return cantidad;
    }

    print('Ingrese una cantidad entera mayor que cero.');
  }
}

void main() {
  // Capacidad y precios de las entradas.
  const int capacidadInicial = 40;
  const int precioGeneral = 18000;
  const int precioEstudiante = 12000;

  // Contadores de entradas vendidas.
  int entradasGeneralesVendidas = 0;
  int entradasEstudianteVendidas = 0;

  // Acumulador de ingresos.
  int ingresosTotales = 0;

  // Control de la capacidad disponible.
  int entradasDisponibles = capacidadInicial;

  while (true) {
    print('\n================================');
    print('       VENTA DE ENTRADAS');
    print('================================');
    print('1. Vender entradas');
    print('2. Consultar resumen de ventas');
    print('0. Salir');

    int? opcion = leerEnteroEnRango('Seleccione una opción: ', 0, 2);

    if (opcion == null || opcion == 0) {
      print('¡Gracias por utilizar el sistema!');
      return;
    }

    switch (opcion) {
      case 1:
        {
          print('\n--- VENTA DE ENTRADAS ---');

          // Comprueba que todavía haya capacidad.
          if (entradasDisponibles == 0) {
            print('No hay entradas disponibles. La sala está llena.');
            break;
          }

          print('\nTipos de entrada:');
          print('1. General: $precioGeneral COP');
          print('2. Estudiante: $precioEstudiante COP');

          int? tipoEntrada = leerEnteroEnRango(
            'Seleccione el tipo de entrada: ',
            1,
            2,
          );

          if (tipoEntrada == null) {
            return;
          }

          int? cantidad = leerCantidadPositiva(
            '¿Cuántas entradas desea comprar?: ',
          );

          if (cantidad == null) {
            return;
          }

          // Evita vender más entradas que las disponibles.
          if (cantidad > entradasDisponibles) {
            print('\nNo se puede completar la venta.');
            print('Entradas disponibles: $entradasDisponibles');
            print('Entradas solicitadas: $cantidad');
            print('Intente nuevamente con una cantidad menor.');
            break;
          }

          // Registra la venta según el tipo seleccionado.
          if (tipoEntrada == 1) {
            entradasGeneralesVendidas += cantidad;
            ingresosTotales += cantidad * precioGeneral;
          } else {
            entradasEstudianteVendidas += cantidad;
            ingresosTotales += cantidad * precioEstudiante;
          }

          // Actualiza la capacidad después de aceptar la venta.
          entradasDisponibles -= cantidad;

          print('\n¡Venta realizada correctamente!');
          print('Entradas vendidas: $cantidad');
          print('Entradas disponibles: $entradasDisponibles');
        }

      case 2:
        {
          print('\n--- RESUMEN DE VENTAS ---');

          int totalEntradasVendidas =
              entradasGeneralesVendidas + entradasEstudianteVendidas;

          print('Capacidad inicial: $capacidadInicial');
          print('Entradas vendidas: $totalEntradasVendidas');
          print('Entradas disponibles: $entradasDisponibles');

          print('\nVentas por tipo:');
          print('Entradas generales: $entradasGeneralesVendidas');
          print('Entradas de estudiante: $entradasEstudianteVendidas');

          print('\nIngresos totales: $ingresosTotales COP');
        }
    }
  }
}
