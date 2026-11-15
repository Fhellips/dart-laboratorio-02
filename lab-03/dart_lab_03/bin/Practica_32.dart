void main() {
  // ignore: unused_local_variable
  List<String> cultivos = ["cafe", "Maíz", "Arroz"];

  print(cultivos[0]);
  print(cultivos[1]);
  print(cultivos[2]);
  print(cultivos.length);
  print(cultivos.first);
  print(cultivos.last);

  List<String> municipios = [];

  if (municipios.isNotEmpty) {
    print(municipios.first);
  } else {
    print('No hay municipios registrados');
  }

  cultivos.add("frijol");
  cultivos.addAll(["trigo", "avena", "cebada"]);
  cultivos.insert(1, "soya");
  cultivos[1] = "cacao";

  print(cultivos.contains("cafe"));
  print(cultivos.contains("papa"));
  print(cultivos.indexOf("maiz"));
  print(cultivos.indexOf("trigo"));
  cultivos.remove("maiz");
  cultivos.removeAt(3);

  List<String> departamento = ['Andes', 'Jardín', 'Támesis'];

  for (int i = 0; i < departamento.length; i++) {
    print(departamento[i]);
  }

  for (String municipio in municipios) {
    print(municipio);
  }

  List<double> superficies = [10.5, 20.0, 15.5, 8.0];

  double total = 0.0;

  for (double superficie in superficies) {
    total = total + superficie;
  }
  double promedio = total / superficies.length;

  print(promedio);
  print(total);

  final List<String> mutableCrops = ['Coffee', 'Cocoa'];
  mutableCrops.add('Beans');

  const List<String> fixedCrops = ['Rice', 'Plantain'];

  print(mutableCrops);
  print(fixedCrops);

  List<String> original = ['Coffee', 'Beans'];
  List<String> shared = original;
  List<String> separate = List<String>.from(original);

  shared.add('Cocoa');
  separate.add('Rice');

  print('Original: $original');
  print('Separate copy: $separate');
}
