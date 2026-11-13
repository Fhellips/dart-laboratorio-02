void main() {
  var AreaCultivo = 75.0;
  var AreaTotal = 250.0;

  print(AreaCultivo > 100.0);
  print(AreaCultivo < AreaTotal);
  print(AreaCultivo == AreaTotal);
  print(AreaCultivo != AreaTotal);
  print(AreaCultivo >= 75.0);
  print(AreaCultivo <= 74.0);

  bool AreaSuficiente = AreaCultivo > 100.0;
  print(AreaSuficiente);

  bool NecesitaRevision = AreaCultivo < 60.0;
  print(NecesitaRevision);

  var cultivo1 = "cafe";
  var cultivo2 = "CAFE";

  print(cultivo1 == cultivo2);
  print(cultivo2.toLowerCase() == cultivo2.toLowerCase());

  double area = 120.0;
  int ano = 2025;

  bool cumpleAmbas = area > 0 && ano >= 2000;
  print(cumpleAmbas);

  area = 0.0;
  bool esPreliminar = false;

  bool requiereRevision = area <= 0 || esPreliminar;
  print(requiereRevision);

  bool esDefinitivo = !esPreliminar;
  print(esDefinitivo);

  bool tieneNombre = true;
  bool tieneAreaPositiva = false;

  print('Resultado con Y: ${tieneNombre && tieneAreaPositiva}');
  // ignore: dead_code
  print('Resultado con O: ${tieneNombre || tieneAreaPositiva}');

  String municipio = 'Andes';
  double areaSembrada = 15.5;
  int anioObservacion = 2025;

  bool esUtilizable =
      municipio.trim().isNotEmpty && areaSembrada > 0 && anioObservacion > 0;

  print('¿Registro utilizable? $esUtilizable');
}
