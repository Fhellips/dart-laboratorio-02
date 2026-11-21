Procesador de pedidos de una librería - Reto de aplicación PF07

Esta solución es independiente de AgroDiversa, pero comparte el paquete Dart
dart_lab_05. Copia las carpetas lib/, bin/, data/ y test/ dentro de la raíz
del proyecto existente, combinándolas con las carpetas ya creadas.

Desde la raíz de dart_lab_05 ejecuta:
  dart pub get
  dart format lib bin test
  dart analyze
  dart test

Ejecuta informes:
  dart run bin/bookstore_orders_cli.dart compact
  dart run bin/bookstore_orders_cli.dart detailed

Archivo de entrada:
  data/bookstore_orders.json

Archivo de salida:
  data/normalized_bookstore_orders.json

Datos de ejemplo y resultados:
- ORD-001: 2 x 85.000 + 1 x 110.000 = 280.000
- ORD-002: 3 x 72.000 = 216.000
- ORD-003: 95.000 + 88.000 = 183.000
- Ventas totales: 679.000

El programa valida todos los pedidos antes de exportar. Nunca escribe sobre
el archivo JSON original.
