# Laboratorio 05 - Dart

Proyecto académico desarrollado en el programa ADSO del SENA.

## Descripción

Este laboratorio reúne ejercicios de programación en Dart y dos retos integradores:

- AgroDiversa: procesamiento de observaciones agrícolas mediante modelos, validaciones y archivos JSON.
- Procesador de pedidos: sistema para validar pedidos de una librería y generar informes.

## Tecnologías

- Dart
- JSON
- Pruebas unitarias con el paquete test
- Git y GitHub

## Estructura

- lib/: modelos, servicios y conversores.
- bin/: programas ejecutables.
- data/: archivos JSON de entrada y salida.
- test/: pruebas unitarias.
- agrodiversa_reto_56/: paquete de referencia del reto agrícola.
- libreria_reto_pf07/: paquete de referencia del reto de la librería.

## Instalación

    dart pub get

## Análisis y pruebas

    dart analyze
    dart test

## Formato del código

    dart format lib bin test

## Ejecución de AgroDiversa

    dart run bin/agrodiversa_cli.dart compact
    dart run bin/agrodiversa_cli.dart detailed

Entrada: data/observations.json
Salida: data/normalized_observations.json

## Ejecución del procesador de pedidos

    dart run bin/bookstore_orders_cli.dart compact
    dart run bin/bookstore_orders_cli.dart detailed

Entrada: data/bookstore_orders.json
Salida: data/normalized_bookstore_orders.json

Los programas generan archivos normalizados independientes y conservan los archivos originales.

## Conceptos trabajados

- Programación orientada a objetos.
- Herencia, interfaces y polimorfismo.
- Composición y separación de responsabilidades.
- Null safety y manejo de excepciones.
- Validación de datos.
- Serialización y deserialización JSON.
- Pruebas unitarias y casos límite.

## Autor

Proyecto académico del programa ADSO del SENA.
