import 'dart:io';

// ==========================================
// 1. FUNCIONES PARA LEER Y VALIDAR DATOS
// ==========================================

String? leerTextoObligatorio(String mensaje) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      return null;
    }

    String texto = entrada.trim();

    if (texto.isNotEmpty) {
      return texto;
    }

    print('El dato no puede estar vacío.');
  }
}

int? leerEnteroEnRango(String mensaje, int minimo, int maximo) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      return null;
    }

    int? numero = int.tryParse(entrada.trim());

    if (numero == null) {
      print('Debe ingresar un número entero.');
    } else if (numero < minimo || numero > maximo) {
      print('El número debe estar entre $minimo y $maximo.');
    } else {
      return numero;
    }
  }
}

double? leerSuperficiePositiva(String mensaje) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      return null;
    }

    double? superficie = double.tryParse(entrada.trim());

    if (superficie == null || !superficie.isFinite || superficie <= 0) {
      print('La superficie debe ser un número positivo y válido.');
    } else {
      return superficie;
    }
  }
}

// ==========================================
// 2. CREAR CLAVES DE OBSERVACIONES
// ==========================================

String crearClaveObservacion(String municipio, int anio) {
  String municipioNormalizado = municipio.trim().toLowerCase();

  return '$municipioNormalizado ($anio)';
}

// ==========================================
// 3. VALIDAR NOMBRES DE CULTIVOS ÚNICOS
// ==========================================

String? leerNombreCultivoUnico(
  String mensaje,
  Map<String, double> cultivosActuales,
) {
  while (true) {
    String? nombre = leerTextoObligatorio(mensaje);

    if (nombre == null) {
      return null;
    }

    String nombreNormalizado = nombre.trim().toLowerCase();

    if (!cultivosActuales.containsKey(nombreNormalizado)) {
      return nombreNormalizado;
    }

    print('Este cultivo ya está registrado en la observación.');
  }
}

// ==========================================
// 4. REGISTRAR UNA OBSERVACIÓN
// ==========================================

bool registrarObservacion(Map<String, Map<String, double>> observaciones) {
  print('\n========== REGISTRAR OBSERVACIÓN ==========');

  String? municipio = leerTextoObligatorio('Nombre del municipio: ');

  if (municipio == null) {
    return false;
  }

  int? anio = leerEnteroEnRango('Año de observación (2000-2100): ', 2000, 2100);

  if (anio == null) {
    return false;
  }

  String clave = crearClaveObservacion(municipio, anio);

  if (observaciones.containsKey(clave)) {
    print('Esta observación ya existe.');
    return true;
  }

  int? cantidadCultivos = leerEnteroEnRango(
    'Cantidad de cultivos (1-5): ',
    1,
    5,
  );

  if (cantidadCultivos == null) {
    return false;
  }

  Map<String, double> cultivosActuales = <String, double>{};

  for (int indice = 1; indice <= cantidadCultivos; indice++) {
    print('\nCultivo $indice de $cantidadCultivos');

    String? nombreCultivo = leerNombreCultivoUnico(
      'Nombre del cultivo: ',
      cultivosActuales,
    );

    if (nombreCultivo == null) {
      return false;
    }

    double? superficie = leerSuperficiePositiva('Superficie en hectáreas: ');

    if (superficie == null) {
      return false;
    }

    cultivosActuales[nombreCultivo] = superficie;
  }

  // Guardamos la observación completa.
  observaciones[clave] = Map<String, double>.from(cultivosActuales);

  print('\n¡Observación guardada correctamente!');
  return true;
}

// ==========================================
// 5. LISTAR OBSERVACIONES
// ==========================================

void listarObservaciones(Map<String, Map<String, double>> observaciones) {
  print('\n========== OBSERVACIONES REGISTRADAS ==========');

  if (observaciones.isEmpty) {
    print('No hay observaciones registradas.');
    return;
  }

  List<String> claves = observaciones.keys.toList();

  claves.sort();

  for (final clave in claves) {
    print(clave);
  }

  print('Total de observaciones: ${claves.length}');
}

// ==========================================
// 6. CALCULAR SUPERFICIE TOTAL
// ==========================================

double calcularSuperficieTotal(Map<String, double> cultivos) {
  return cultivos.values.fold<double>(
    0.0,
    (total, superficie) => total + superficie,
  );
}

// ==========================================
// 7. MOSTRAR RESUMEN DE UNA OBSERVACIÓN
// ==========================================

void mostrarResumenObservacion(String clave, Map<String, double> cultivos) {
  print('\n========== DETALLES DE LA OBSERVACIÓN ==========');
  print('Observación: $clave');

  if (cultivos.isEmpty) {
    print('No hay cultivos registrados.');
    return;
  }

  List<String> nombresCultivos = cultivos.keys.toList();

  nombresCultivos.sort();

  print('\nCultivos registrados:');

  for (final nombre in nombresCultivos) {
    print('- $nombre: ${cultivos[nombre]!.toStringAsFixed(2)} ha');
  }

  double total = calcularSuperficieTotal(cultivos);

  double promedio = total / cultivos.length;

  String cultivoMayor = '';
  double superficieMayor = 0.0;

  for (final entrada in cultivos.entries) {
    if (entrada.value > superficieMayor) {
      superficieMayor = entrada.value;
      cultivoMayor = entrada.key;
    }
  }

  double participacion = superficieMayor / total * 100;

  print('\n========== ESTADÍSTICAS ==========');
  print('Cantidad de cultivos: ${cultivos.length}');
  print('Superficie total: ${total.toStringAsFixed(2)} ha');
  print('Superficie promedio: ${promedio.toStringAsFixed(2)} ha');
  print('Cultivo con mayor superficie: $cultivoMayor');
  print('Mayor superficie: ${superficieMayor.toStringAsFixed(2)} ha');
  print(
    'Participación del cultivo mayor: ${participacion.toStringAsFixed(2)}%',
  );
}

// ==========================================
// 8. CONSULTAR UNA OBSERVACIÓN
// ==========================================

bool consultarObservacion(Map<String, Map<String, double>> observaciones) {
  print('\n========== CONSULTAR OBSERVACIÓN ==========');

  String? municipio = leerTextoObligatorio('Nombre del municipio: ');

  if (municipio == null) {
    return false;
  }

  int? anio = leerEnteroEnRango('Año de observación: ', 2000, 2100);

  if (anio == null) {
    return false;
  }

  String clave = crearClaveObservacion(municipio, anio);

  Map<String, double>? cultivos = observaciones[clave];

  if (cultivos == null) {
    print('No se encontró la observación solicitada.');
    return true;
  }

  mostrarResumenObservacion(clave, cultivos);

  return true;
}

// ==========================================
// 9. MOSTRAR NOMBRES DE CULTIVOS ÚNICOS
// ==========================================

void mostrarCultivosUnicos(Map<String, Map<String, double>> observaciones) {
  print('\n========== CATÁLOGO DE CULTIVOS ÚNICOS ==========');

  Set<String> cultivosUnicos = <String>{};

  for (final cultivos in observaciones.values) {
    cultivosUnicos.addAll(cultivos.keys);
  }

  if (cultivosUnicos.isEmpty) {
    print('No hay cultivos disponibles.');
    return;
  }

  List<String> nombresOrdenados = cultivosUnicos.toList();

  nombresOrdenados.sort();

  print('Cantidad de cultivos únicos: ${nombresOrdenados.length}');

  for (final nombre in nombresOrdenados) {
    print('- $nombre');
  }
}

// ==========================================
// 10. PROGRAMA PRINCIPAL
// ==========================================

void main() {
  Map<String, Map<String, double>> observaciones =
      <String, Map<String, double>>{};

  while (true) {
    print('\n==========================================');
    print('          AGRODIVERSA CATALOG');
    print('==========================================');
    print('1. Registrar observación');
    print('2. Listar observaciones');
    print('3. Consultar detalles de observación');
    print('4. Mostrar nombres de cultivos únicos');
    print('0. Salir');
    print('==========================================');

    int? opcion = leerEnteroEnRango('Seleccione una opción: ', 0, 4);

    if (opcion == null || opcion == 0) {
      print('\n¡Gracias por utilizar AgroDiversa Catalog!');
      return;
    }

    switch (opcion) {
      case 1:
        bool continuar = registrarObservacion(observaciones);

        if (!continuar) {
          print('\nEntrada finalizada. No se guardó el registro incompleto.');
          return;
        }
        break;

      case 2:
        listarObservaciones(observaciones);
        break;

      case 3:
        bool continuar = consultarObservacion(observaciones);

        if (!continuar) {
          print('\nEntrada finalizada.');
          return;
        }
        break;

      case 4:
        mostrarCultivosUnicos(observaciones);
        break;
    }
  }
}
