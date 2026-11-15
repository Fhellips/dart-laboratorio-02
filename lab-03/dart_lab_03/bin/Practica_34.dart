void main() {
  Map<String, dynamic> cultivo = {
    'nombre': 'Café',
    'municipio': 'Andes',
    'año': 2025,
    'superficie': 35.5,
  };

  print(cultivo);
  print(cultivo.length);
  print(cultivo["nombre"]);

  Map<String, double> superficiesCultivos = {'Café': 125.0};

  double? superficieExistente = superficiesCultivos['Café'];
  double? superficieInexistente = superficiesCultivos['Arroz'];

  print(superficieExistente);
  print(superficieInexistente);

  superficiesCultivos["frijol"] = 40.0;
  superficiesCultivos['Café'] = 130.0;
  superficiesCultivos.remove("frijol");

  Map<String, double> cropAreas = {'Coffee': 125.0, 'Beans': 40.0};

  for (final name in cropAreas.keys) {
    print('Crop: $name');
  }

  for (final area in cropAreas.values) {
    print('Area: $area');
  }

  for (final entry in cropAreas.entries) {
    String crop = entry.key;
    double area = entry.value;
    print('$crop: $area ha');
  }

  List<String> nombresCultivos = ['Café', 'Fríjol', 'Café', 'Arroz', 'Fríjol'];

  Map<String, int> apariciones = <String, int>{};

  for (final nombre in nombresCultivos) {
    int conteoAnterior = apariciones[nombre] ?? 0;

    apariciones[nombre] = conteoAnterior + 1;
  }

  print(apariciones);

  Map<String, Map<String, double>> observaciones = {
    'Andes (2025)': {'Café': 125.0, 'Plátano': 75.0},
    'Andes (2024)': {'Café': 110.0, 'Fríjol': 40.0},
  };

  print(observaciones.keys);
  print(observaciones['Andes (2025)']);

  Map<String, Map<String, double>> observations = {
    'Andes (2025)': {'Coffee': 125.0},
  };

  Map<String, double>? selected = observations['Unknown (2025)'];

  if (selected == null) {
    print('Observation not found.');
  } else {
    print(selected);
  }

  Map<String, Map<String, double>> original = {
    'Andes (2025)': {'Coffee': 125.0},
  };

  Map<String, Map<String, double>> shallowCopy = Map.of(original);

  Map<String, double>? sharedInnerMap = shallowCopy['Andes (2025)'];

  if (sharedInnerMap != null) {
    sharedInnerMap['Coffee'] = 150.0;
  }

  print(original);
}
