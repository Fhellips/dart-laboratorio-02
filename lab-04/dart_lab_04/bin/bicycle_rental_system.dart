
import 'dart:io';

// =====================================================
// CLASE 1: BICYCLE
// Representa una bicicleta del negocio.
// =====================================================

class Bicycle {
  final String id;
  final String description;
  final double hourlyRate;

  bool _isAvailable = true;

  Bicycle({
    required String id,
    required String description,
    required this.hourlyRate,
  }) : id = id.trim(),
       description = description.trim() {
    if (this.id.isEmpty) {
      throw ArgumentError('El identificador no puede estar vacío.');
    }

    if (this.description.isEmpty) {
      throw ArgumentError('La descripción no puede estar vacía.');
    }

    if (!hourlyRate.isFinite || hourlyRate <= 0) {
      throw ArgumentError('La tarifa debe ser positiva y finita.');
    }
  }

  bool get isAvailable => _isAvailable;

  // Métodos privados para que solo la biblioteca
  // pueda modificar la disponibilidad directamente.

  void _markAsRented() {
    _isAvailable = false;
  }

  void _markAsAvailable() {
    _isAvailable = true;
  }
}

// =====================================================
// CLASE 2: RENTAL
// Representa un alquiler de bicicleta.
// =====================================================

class Rental {
  final int id;
  final Bicycle bicycle;
  final String customerName;

  double? _durationHours;
  double? _totalCost;

  Rental({
    required this.id,
    required this.bicycle,
    required String customerName,
  }) : customerName = customerName.trim() {
    if (this.customerName.isEmpty) {
      throw ArgumentError('El nombre del cliente no puede estar vacío.');
    }
  }

  bool get isActive => _totalCost == null;

  double? get durationHours => _durationHours;

  double? get totalCost => _totalCost;

  // Finaliza el alquiler una sola vez.
  bool finish(double durationHours) {
    if (!isActive) {
      return false;
    }

    if (!durationHours.isFinite || durationHours <= 0) {
      return false;
    }

    final double cost = bicycle.hourlyRate * durationHours;

    if (!cost.isFinite) {
      return false;
    }

    _durationHours = durationHours;
    _totalCost = cost;

    return true;
  }
}

// =====================================================
// CLASE 3: RENTAL SYSTEM
// Administra bicicletas y alquileres.
// =====================================================

class RentalSystem {
  final Map<String, Bicycle> _bicycles = <String, Bicycle>{};

  final Map<int, Rental> _rentals = <int, Rental>{};

  int _nextRentalId = 1;

  double _totalRevenue = 0.0;

  int get bicycleCount => _bicycles.length;

  double get totalRevenue => _totalRevenue;

  List<Bicycle> get bicycles {
    return List<Bicycle>.unmodifiable(_bicycles.values);
  }

  List<Rental> get rentals {
    return List<Rental>.unmodifiable(_rentals.values);
  }

  List<Bicycle> get availableBicycles {
    return List<Bicycle>.unmodifiable(
      _bicycles.values.where((bicycle) => bicycle.isAvailable),
    );
  }

  List<Rental> get activeRentals {
    return List<Rental>.unmodifiable(
      _rentals.values.where((rental) => rental.isActive),
    );
  }

  List<Rental> get completedRentals {
    return List<Rental>.unmodifiable(
      _rentals.values.where((rental) => !rental.isActive),
    );
  }

  // Registra una bicicleta con identificador único.
  bool registerBicycle(Bicycle bicycle) {
    final String key = bicycle.id.toLowerCase();

    if (_bicycles.containsKey(key)) {
      return false;
    }

    _bicycles[key] = bicycle;
    return true;
  }

  // Busca una bicicleta por su identificador.
  Bicycle? findBicycle(String id) {
    return _bicycles[id.trim().toLowerCase()];
  }

  // Inicia un alquiler.
  Rental? startRental(String bicycleId, String customerName) {
    final Bicycle? bicycle = findBicycle(bicycleId);

    if (bicycle == null || !bicycle.isAvailable) {
      return null;
    }

    if (customerName.trim().isEmpty) {
      return null;
    }

    final Rental rental = Rental(
      id: _nextRentalId,
      bicycle: bicycle,
      customerName: customerName,
    );

    _rentals[_nextRentalId] = rental;
    _nextRentalId++;

    bicycle._markAsRented();

    return rental;
  }

  // Finaliza un alquiler activo.
  bool finishRental(int rentalId, double durationHours) {
    final Rental? rental = _rentals[rentalId];

    if (rental == null || !rental.isActive) {
      return false;
    }

    if (!durationHours.isFinite || durationHours <= 0) {
      return false;
    }

    final double cost = rental.bicycle.hourlyRate * durationHours;
    final double nextRevenue = _totalRevenue + cost;

    if (!cost.isFinite || !nextRevenue.isFinite) {
      return false;
    }

    final bool finished = rental.finish(durationHours);

    if (!finished) {
      return false;
    }

    _totalRevenue = nextRevenue;
    rental.bicycle._markAsAvailable();

    return true;
  }

  // Busca un alquiler por su identificador.
  Rental? findRental(int rentalId) {
    return _rentals[rentalId];
  }
}

// =====================================================
// FUNCIONES DE LECTURA Y VALIDACIÓN
// =====================================================

String? readRequiredText(String prompt) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final String text = input.trim();

    if (text.isNotEmpty) {
      return text;
    }

    print('El texto no puede estar vacío.');
  }
}

int? readPositiveInt(String prompt) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final int? number = int.tryParse(input.trim());

    if (number == null || number <= 0) {
      print('Ingrese un número entero positivo.');
      continue;
    }

    return number;
  }
}

double? readPositiveDouble(String prompt) {
  while (true) {
    stdout.write(prompt);

    final String? input = stdin.readLineSync();

    if (input == null) {
      return null;
    }

    final double? number = double.tryParse(input.trim());

    if (number == null || !number.isFinite || number <= 0) {
      print('Ingrese un número positivo y finito.');
      continue;
    }

    return number;
  }
}

// =====================================================
// REGISTRAR UNA BICICLETA
// =====================================================

bool registerBicycle(RentalSystem system) {
  final String? id = readRequiredText('Identificador: ');

  if (id == null) {
    return false;
  }

  if (system.findBicycle(id) != null) {
    print('Ya existe una bicicleta con ese identificador.');
    return true;
  }

  final String? description =
      readRequiredText('Descripción de la bicicleta: ');

  if (description == null) {
    return false;
  }

  final double? rate =
      readPositiveDouble('Tarifa por hora: ');

  if (rate == null) {
    return false;
  }

  final Bicycle bicycle = Bicycle(
    id: id,
    description: description,
    hourlyRate: rate,
  );

  if (system.registerBicycle(bicycle)) {
    print('Bicicleta registrada correctamente.');
  } else {
    print('No se pudo registrar la bicicleta.');
  }

  return true;
}

// =====================================================
// MOSTRAR BICICLETAS
// =====================================================

void showBicycles(RentalSystem system) {
  if (system.bicycles.isEmpty) {
    print('No hay bicicletas registradas.');
    return;
  }

  print('\n===== BICICLETAS =====');

  for (final bicycle in system.bicycles) {
    final String status =
        bicycle.isAvailable ? 'Disponible' : 'Alquilada';

    print('ID: ${bicycle.id}');
    print('Descripción: ${bicycle.description}');
    print('Tarifa por hora: \$${bicycle.hourlyRate.toStringAsFixed(2)}');
    print('Estado: $status');
    print('-------------------------');
  }
}

// =====================================================
// INICIAR UN ALQUILER
// =====================================================

bool startBicycleRental(RentalSystem system) {
  final String? bicycleId =
      readRequiredText('Identificador de la bicicleta: ');

  if (bicycleId == null) {
    return false;
  }

  final String? customerName =
      readRequiredText('Nombre del cliente: ');

  if (customerName == null) {
    return false;
  }

  final Rental? rental =
      system.startRental(bicycleId, customerName);

  if (rental == null) {
    print('No se pudo iniciar el alquiler.');
    print('Verifique que la bicicleta exista y esté disponible.');
  } else {
    print('Alquiler iniciado correctamente.');
    print('Número de alquiler: ${rental.id}');
    print('Cliente: ${rental.customerName}');
    print('Bicicleta: ${rental.bicycle.id}');
  }

  return true;
}

// =====================================================
// MOSTRAR ALQUILERES ACTIVOS
// =====================================================

void showActiveRentals(RentalSystem system) {
  final List<Rental> active = system.activeRentals;

  if (active.isEmpty) {
    print('No hay alquileres activos.');
    return;
  }

  print('\n===== ALQUILERES ACTIVOS =====');

  for (final rental in active) {
    print('Alquiler: ${rental.id}');
    print('Cliente: ${rental.customerName}');
    print('Bicicleta: ${rental.bicycle.id}');
    print('Tarifa por hora: \$${rental.bicycle.hourlyRate.toStringAsFixed(2)}');
    print('-------------------------');
  }
}

// =====================================================
// FINALIZAR UN ALQUILER
// =====================================================

bool finishBicycleRental(RentalSystem system) {
  final int? rentalId =
      readPositiveInt('Número del alquiler: ');

  if (rentalId == null) {
    return false;
  }

  final Rental? rental = system.findRental(rentalId);

  if (rental == null) {
    print('No existe ese alquiler.');
    return true;
  }

  if (!rental.isActive) {
    print('Ese alquiler ya fue finalizado.');
    return true;
  }

  final double? duration = readPositiveDouble(
    'Duración del alquiler en horas: ',
  );

  if (duration == null) {
    return false;
  }

  final bool finished =
      system.finishRental(rentalId, duration);

  if (finished) {
    print('Alquiler finalizado correctamente.');
    print('Duración: ${duration.toStringAsFixed(2)} horas');
    print(
      'Importe: \$${rental.totalCost!.toStringAsFixed(2)}',
    );
  } else {
    print('No se pudo finalizar el alquiler.');
  }

  return true;
}

// =====================================================
// MOSTRAR ALQUILERES FINALIZADOS
// =====================================================

void showCompletedRentals(RentalSystem system) {
  final List<Rental> completed = system.completedRentals;

  if (completed.isEmpty) {
    print('No hay alquileres finalizados.');
    return;
  }

  print('\n===== ALQUILERES FINALIZADOS =====');

  for (final rental in completed) {
    print('Alquiler: ${rental.id}');
    print('Cliente: ${rental.customerName}');
    print('Bicicleta: ${rental.bicycle.id}');
    print(
      'Duración: ${rental.durationHours!.toStringAsFixed(2)} horas',
    );
    print(
      'Importe: \$${rental.totalCost!.toStringAsFixed(2)}',
    );
    print('-------------------------');
  }
}

// =====================================================
// MOSTRAR INGRESOS
// =====================================================

void showRevenue(RentalSystem system) {
  print('\n===== RESUMEN DE INGRESOS =====');

  print(
    'Total de alquileres finalizados: '
    '${system.completedRentals.length}',
  );

  print(
    'Ingresos acumulados: '
    '\$${system.totalRevenue.toStringAsFixed(2)}',
  );
}

// =====================================================
// MENÚ PRINCIPAL
// =====================================================

void main() {
  final RentalSystem system = RentalSystem();

  while (true) {
    print('\n================================');
    print('     SISTEMA DE ALQUILER');
    print('          BICICLETAS');
    print('================================');
    print('1. Registrar bicicleta');
    print('2. Mostrar bicicletas');
    print('3. Iniciar alquiler');
    print('4. Mostrar alquileres activos');
    print('5. Finalizar alquiler');
    print('6. Mostrar alquileres finalizados');
    print('7. Consultar ingresos');
    print('0. Salir');

    stdout.write('Seleccione una opción: ');

    final String? input = stdin.readLineSync();

    if (input == null) {
      print('¡Hasta pronto!');
      return;
    }

    final int? option = int.tryParse(input.trim());

    if (option == null || option < 0 || option > 7) {
      print('Opción no válida.');
      continue;
    }

    switch (option) {
      case 1:
        if (!registerBicycle(system)) return;
        break;

      case 2:
        showBicycles(system);
        break;

      case 3:
        if (!startBicycleRental(system)) return;
        break;

      case 4:
        showActiveRentals(system);
        break;

      case 5:
        if (!finishBicycleRental(system)) return;
        break;

      case 6:
        showCompletedRentals(system);
        break;

      case 7:
        showRevenue(system);
        break;

      case 0:
        print('¡Gracias por utilizar el sistema!');
        return;
    }
  }
}
