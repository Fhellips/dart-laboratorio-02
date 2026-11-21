AgroDiversa - Reto integrador 5.6

1. Copia el contenido de este paquete dentro de la raíz de tu proyecto dart_lab_05.
2. Desde la raíz ejecuta:
   dart pub add --dev test
   dart pub get
3. Formatea y revisa:
   dart format lib bin test
   dart analyze
   dart test
4. Ejecuta los informes:
   dart run bin/agrodiversa_cli.dart compact
   dart run bin/agrodiversa_cli.dart detailed

El programa lee data/observations.json y escribe data/normalized_observations.json.
Nunca escribe sobre el archivo de entrada.

Resultados esperados con los datos incluidos:
- Andes (2025): 250.00 ha; promedio 83.33 ha; Coffee 125.00 ha (50.00%).
- La Mesa (2024): 50.00 ha; promedio 25.00 ha; Beans 30.00 ha (60.00%).
- Total general: 300.00 ha.
