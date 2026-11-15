void main() {
  Set<String> municipios = {
    'Andes',
    'Jardín',
    // ignore: equal_elements_in_set
    'Andes',
    'Támesis',
  };

  print(municipios.length);

  List<String> registros = ['Andes', 'Jardín', 'Andes', 'Támesis', 'Jardín'];

  Set<String> municipiosUnicos = registros.toSet();

  print(municipiosUnicos);

  Set<String> cultivos = <String>{};

  cultivos.add('Café');
  cultivos.add('Maíz');
  cultivos.remove('Café');

  print(cultivos.contains('Café'));
  print(cultivos.length);

  Set<String> crops = <String>{};

  crops.add('Café'.trim().toLowerCase());
  crops.add('CAFÉ'.trim().toLowerCase());
  crops.add(' café '.trim().toLowerCase());

  print(crops);
  print(crops.length);
}
