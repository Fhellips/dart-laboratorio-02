import 'dart:io';

// ==========================================
// 1. LEER TEXTOS OBLIGATORIOS
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

    print('Este campo no puede estar vacío.');
  }
}

// ==========================================
// 2. LEER Y VALIDAR AÑOS
// ==========================================

int? leerAnio(String mensaje) {
  while (true) {
    stdout.write(mensaje);

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      return null;
    }

    int? anio = int.tryParse(entrada.trim());

    if (anio == null || anio <= 0) {
      print('Ingrese un año válido.');
    } else {
      return anio;
    }
  }
}

// ==========================================
// 3. NORMALIZAR CÓDIGOS Y GÉNEROS
// ==========================================

String normalizarCodigo(String codigo) {
  return codigo.trim().toUpperCase();
}

String normalizarGenero(String genero) {
  return genero.trim().toLowerCase();
}

// ==========================================
// 4. REGISTRAR UN LIBRO
// ==========================================

bool registrarLibro(Map<String, Map<String, Object>> catalogo) {
  print('\n========== REGISTRAR LIBRO ==========');

  String? codigoIngresado = leerTextoObligatorio('Código del libro: ');

  if (codigoIngresado == null) {
    return false;
  }

  String codigo = normalizarCodigo(codigoIngresado);

  if (catalogo.containsKey(codigo)) {
    print('Este código ya está registrado.');
    return true;
  }

  String? titulo = leerTextoObligatorio('Título del libro: ');

  if (titulo == null) {
    return false;
  }

  String? generoIngresado = leerTextoObligatorio('Género del libro: ');

  if (generoIngresado == null) {
    return false;
  }

  String genero = normalizarGenero(generoIngresado);

  int? anio = leerAnio('Año de publicación: ');

  if (anio == null) {
    return false;
  }

  // Guardamos todos los datos del libro.
  catalogo[codigo] = <String, Object>{
    'titulo': titulo.trim(),
    'genero': genero,
    'anio': anio,
  };

  print('\n¡Libro registrado correctamente!');
  return true;
}

// ==========================================
// 5. LISTAR TODOS LOS LIBROS
// ==========================================

void listarLibros(Map<String, Map<String, Object>> catalogo) {
  print('\n========== LIBROS REGISTRADOS ==========');

  if (catalogo.isEmpty) {
    print('No hay libros registrados.');
    return;
  }

  List<String> codigos = catalogo.keys.toList();

  codigos.sort();

  for (final codigo in codigos) {
    Map<String, Object> libro = catalogo[codigo]!;

    print('\nCódigo: $codigo');
    print('Título: ${libro['titulo']}');
    print('Género: ${libro['genero']}');
    print('Año: ${libro['anio']}');
  }

  print('\nTotal de libros: ${catalogo.length}');
}

// ==========================================
// 6. BUSCAR UN LIBRO POR SU CÓDIGO
// ==========================================

bool buscarLibro(Map<String, Map<String, Object>> catalogo) {
  print('\n========== BUSCAR LIBRO ==========');

  String? codigoIngresado = leerTextoObligatorio('Ingrese el código: ');

  if (codigoIngresado == null) {
    return false;
  }

  String codigo = normalizarCodigo(codigoIngresado);

  Map<String, Object>? libro = catalogo[codigo];

  if (libro == null) {
    print('No se encontró ningún libro con ese código.');
    return true;
  }

  print('\n========== LIBRO ENCONTRADO ==========');
  print('Código: $codigo');
  print('Título: ${libro['titulo']}');
  print('Género: ${libro['genero']}');
  print('Año: ${libro['anio']}');

  return true;
}

// ==========================================
// 7. OBTENER LOS GÉNEROS ÚNICOS
// ==========================================

Set<String> obtenerGenerosUnicos(Map<String, Map<String, Object>> catalogo) {
  Set<String> generos = <String>{};

  for (final libro in catalogo.values) {
    String genero = libro['genero'] as String;

    generos.add(normalizarGenero(genero));
  }

  return generos;
}

// ==========================================
// 8. MOSTRAR LOS GÉNEROS ÚNICOS
// ==========================================

void mostrarGenerosUnicos(Map<String, Map<String, Object>> catalogo) {
  print('\n========== GÉNEROS DISPONIBLES ==========');

  Set<String> generos = obtenerGenerosUnicos(catalogo);

  if (generos.isEmpty) {
    print('No hay géneros registrados.');
    return;
  }

  List<String> generosOrdenados = generos.toList();

  generosOrdenados.sort();

  print('Cantidad de géneros únicos: ${generosOrdenados.length}');

  for (final genero in generosOrdenados) {
    print('- $genero');
  }
}

// ==========================================
// 9. CONTAR LIBROS POR GÉNERO
// ==========================================

Map<String, int> contarLibrosPorGenero(
  Map<String, Map<String, Object>> catalogo,
) {
  Map<String, int> conteo = <String, int>{};

  for (final libro in catalogo.values) {
    String genero = libro['genero'] as String;

    int cantidadAnterior = conteo[genero] ?? 0;

    conteo[genero] = cantidadAnterior + 1;
  }

  return conteo;
}

// ==========================================
// 10. MOSTRAR CANTIDAD DE LIBROS POR GÉNERO
// ==========================================

void mostrarConteoPorGenero(Map<String, Map<String, Object>> catalogo) {
  print('\n========== LIBROS POR GÉNERO ==========');

  if (catalogo.isEmpty) {
    print('No hay libros para contar.');
    return;
  }

  Map<String, int> conteo = contarLibrosPorGenero(catalogo);

  List<String> generos = conteo.keys.toList();

  generos.sort();

  for (final genero in generos) {
    print('$genero: ${conteo[genero]} libro(s)');
  }
}

// ==========================================
// 11. CONSULTAR LIBROS DE UN GÉNERO
// ==========================================

bool consultarLibrosPorGenero(Map<String, Map<String, Object>> catalogo) {
  print('\n========== CONSULTAR POR GÉNERO ==========');

  String? generoIngresado = leerTextoObligatorio('Ingrese el género: ');

  if (generoIngresado == null) {
    return false;
  }

  String generoBuscado = normalizarGenero(generoIngresado);

  List<String> titulos = <String>[];

  for (final libro in catalogo.values) {
    String genero = libro['genero'] as String;

    if (normalizarGenero(genero) == generoBuscado) {
      titulos.add(libro['titulo'] as String);
    }
  }

  if (titulos.isEmpty) {
    print('No hay libros registrados de ese género.');
    return true;
  }

  titulos.sort();

  print('\nLibros del género "$generoBuscado":');

  for (final titulo in titulos) {
    print('- $titulo');
  }

  print('Total encontrados: ${titulos.length}');

  return true;
}

// ==========================================
// 12. PROGRAMA PRINCIPAL
// ==========================================

void main() {
  Map<String, Map<String, Object>> catalogo = <String, Map<String, Object>>{};

  while (true) {
    print('\n========================================');
    print('        CATÁLOGO DE BIBLIOTECA');
    print('========================================');
    print('1. Registrar libro');
    print('2. Listar libros registrados');
    print('3. Buscar libro por código');
    print('4. Mostrar géneros únicos');
    print('5. Contar libros por género');
    print('6. Consultar libros de un género');
    print('0. Salir');
    print('========================================');

    stdout.write('Seleccione una opción: ');
    String? entrada = stdin.readLineSync();
    int? opcion = int.tryParse(entrada ?? '');

    if (opcion == null) {
      print('\nFin de la entrada. Cerrando catálogo.');
      return;
    }

    if (opcion < 0 || opcion > 6) {
      print('Opción no válida.');
      continue;
    }

    if (opcion == 0) {
      print('\n¡Gracias por utilizar el catálogo!');
      return;
    }

    switch (opcion) {
      case 1:
        bool continuar = registrarLibro(catalogo);

        if (!continuar) {
          print('\nFin de la entrada. No se guardó el registro incompleto.');
          return;
        }
        break;

      case 2:
        listarLibros(catalogo);
        break;

      case 3:
        bool continuar = buscarLibro(catalogo);

        if (!continuar) {
          print('\nFin de la entrada.');
          return;
        }
        break;

      case 4:
        mostrarGenerosUnicos(catalogo);
        break;

      case 5:
        mostrarConteoPorGenero(catalogo);
        break;

      case 6:
        bool continuar = consultarLibrosPorGenero(catalogo);

        if (!continuar) {
          print('\nFin de la entrada.');
          return;
        }
        break;
    }
  }
}
