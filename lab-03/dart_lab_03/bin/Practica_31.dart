double calcularParticipacion(double superficieCultivo, double superficieTotal) {
  if (superficieTotal <= 0) {
    return 0.0;
  }

  return superficieCultivo / superficieTotal * 100;
}

double calcularTotal(double primero, double segundo) {
  return primero + segundo;
}

void mostrarTotal(double primero, double segundo) {
  print(primero + segundo);
}

void registrarObservacion({
  required String municipio,
  required int anio,
  required double superficie,
}) {
  print('Municipio: $municipio');
  print('Año: $anio');
  print('Superficie: $superficie hectáreas');
}

double sumar(double numero1, double numero2) => numero1 + numero2;

String registrarCultivo() {
  String cultivo = 'Café';

  return cultivo;
}

void main() {
  double participacion = calcularParticipacion(75.0, 300.0);

  print(participacion.toStringAsFixed(2));

  double resultado = calcularTotal(30.0, 20.0);
  print(resultado);

  mostrarTotal(30.0, 20.0);

  registrarObservacion(municipio: 'Andes', anio: 2025, superficie: 120.5);

  double resultadoSuma = sumar(10.0, 15.0);
  print(resultadoSuma);

  String cultivoRegistrado = registrarCultivo();
  print('Cultivo registrado: $cultivoRegistrado');
}
