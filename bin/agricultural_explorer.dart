import 'dart:io';

// Solicita un texto obligatorio.
String? leerTextoObligatorio(String mensaje) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print('Fin de entrada. Cerrando programa.');
      return null;
    }

    String texto = entrada.trim();

    if (texto.isNotEmpty) {
      return texto;
    }

    print('Este campo es obligatorio. Intente nuevamente.');
  }
}

// Solicita un número entero dentro de un rango.
int? leerEnteroEnRango(String mensaje, int minimo, int maximo) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print('Fin de entrada. Cerrando programa.');
      return null;
    }

    int? numero = int.tryParse(entrada.trim());

    if (numero != null && numero >= minimo && numero <= maximo) {
      return numero;
    }

    print('Ingrese un número entero entre $minimo y $maximo.');
  }
}

// Solicita un área positiva y finita.
double? leerAreaPositiva(String mensaje) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print('Fin de entrada. Cerrando programa.');
      return null;
    }

    double? area = double.tryParse(entrada.trim());

    if (area != null && area.isFinite && area > 0) {
      return area;
    }

    print('Ingrese un área positiva y finita.');
  }
}

// Calcula la participación porcentual de un cultivo.
double calcularParticipacion(double area, double areaTotal) {
  return (area / areaTotal) * 100;
}

void main() {
  // Variables que conservan el último resumen.
  bool hayResumen = false;

  String ultimoMunicipio = '';
  int ultimoAnio = 0;
  int ultimaCantidadCultivos = 0;
  double ultimaSuperficieTotal = 0.0;
  double ultimaSuperficieMayor = 0.0;
  String ultimoCultivoMayor = '';

  while (true) {
    print('\n================================');
    print('       EXPLORADOR AGRÍCOLA');
    print('================================');
    print('1. Registrar observación');
    print('2. Consultar último resumen');
    print('0. Salir');

    int? opcion = leerEnteroEnRango('Seleccione una opción: ', 0, 2);

    if (opcion == null || opcion == 0) {
      print('¡Hasta pronto!');
      return;
    }

    switch (opcion) {
      case 1:
        {
          print('\n--- REGISTRO DE OBSERVACIÓN ---');

          String? municipio = leerTextoObligatorio('Ingrese el municipio: ');

          if (municipio == null) {
            return;
          }

          int? anio = leerEnteroEnRango(
            'Ingrese el año (2000-2100): ',
            2000,
            2100,
          );

          if (anio == null) {
            return;
          }

          int? cantidadCultivos = leerEnteroEnRango(
            'Cantidad de cultivos (1-5): ',
            1,
            5,
          );

          if (cantidadCultivos == null) {
            return;
          }

          // Variables que comienzan desde cero en cada registro.
          double superficieTotal = 0.0;
          double superficieMayor = 0.0;
          String cultivoMayor = '';

          // Lectura y cálculo de cada cultivo.
          for (
            int numeroCultivo = 1;
            numeroCultivo <= cantidadCultivos;
            numeroCultivo++
          ) {
            print('\nCultivo número $numeroCultivo');

            String? nombreCultivo = leerTextoObligatorio(
              'Nombre del cultivo: ',
            );

            if (nombreCultivo == null) {
              return;
            }

            double? superficie = leerAreaPositiva('Superficie en hectáreas: ');

            if (superficie == null) {
              return;
            }

            superficieTotal += superficie;

            // Conserva el primer cultivo si existe un empate.
            if (superficie > superficieMayor) {
              superficieMayor = superficie;
              cultivoMayor = nombreCultivo;
            }
          }

          // Actualiza el resumen únicamente cuando el registro termina.
          ultimoMunicipio = municipio;
          ultimoAnio = anio;
          ultimaCantidadCultivos = cantidadCultivos;
          ultimaSuperficieTotal = superficieTotal;
          ultimaSuperficieMayor = superficieMayor;
          ultimoCultivoMayor = cultivoMayor;

          hayResumen = true;

          print('\n¡Observación registrada correctamente!');
        }

      case 2:
        {
          print('\n--- ÚLTIMO RESUMEN ---');

          if (!hayResumen) {
            print('Todavía no hay ninguna observación registrada.');
          } else {
            double promedio = ultimaSuperficieTotal / ultimaCantidadCultivos;

            double participacion = calcularParticipacion(
              ultimaSuperficieMayor,
              ultimaSuperficieTotal,
            );

            print('Municipio: $ultimoMunicipio');
            print('Año: $ultimoAnio');
            print('Cultivos procesados: $ultimaCantidadCultivos');

            print(
              'Superficie total: '
              '${ultimaSuperficieTotal.toStringAsFixed(2)} ha',
            );

            print(
              'Superficie promedio: '
              '${promedio.toStringAsFixed(2)} ha',
            );

            print('Cultivo con mayor superficie: $ultimoCultivoMayor');

            print(
              'Mayor superficie: '
              '${ultimaSuperficieMayor.toStringAsFixed(2)} ha',
            );

            print(
              'Participación del cultivo mayor: '
              '${participacion.toStringAsFixed(2)}%',
            );
          }
        }

      default:
        print('Opción desconocida.');
    }
  }
}
