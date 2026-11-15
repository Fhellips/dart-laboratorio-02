void main() {
  List<double> areas = [10.0, 50.0, 5.0, 80.0];
  List<double> selectedAreas = <double>[];

  for (final area in areas) {
    if (area >= 20.0) {
      selectedAreas.add(area);
    }
  }

  print(selectedAreas);

  // ignore: unused_local_variable
  List<double> areas1 = [10.0, 50.0, 5.0, 80.0];

  // ignore: unused_local_variable
  List<double> selectedAreas1 = areas.where((area) => area >= 20.0).toList();

  print(selectedAreas);

  List<String> crops = [' coffee ', ' BEANS', 'Cocoa '];

  List<String> normalized = crops
      .map((name) => name.trim().toLowerCase())
      .toList();

  print(normalized);
  print(crops);

  List<String> names = ['Coffee', '', ' Beans ', 'Rice'];

  List<String> cleanedNames = names
      .map((name) => name.trim())
      .where((name) => name.isNotEmpty)
      .toList();

  print(cleanedNames);

  // ignore: unused_local_variable
  List<double> areas2 = [125.0, 75.0, 50.0];
  double total = 0.0;

  for (final area in areas) {
    total += area;
  }

  print(total);

  // ignore: unused_local_variable
  List<double> areas3 = [125.0, 75.0, 50.0];

  // ignore: unused_local_variable
  double total3 = areas.fold<double>(0.0, (sum, area) => sum + area);

  print(total);

  List<String> original = ['Rice', 'Coffee', 'Beans'];

  List<String> sorted = List<String>.from(original);
  sorted.sort();

  print('Original: $original');
  print('Sorted: $sorted');

  Map<String, double> cropAreas = {
    'Coffee': 125.0,
    'Beans': 15.0,
    'Rice': 80.0,
  };

  List<String> largeCrops = cropAreas.entries
      .where((entry) => entry.value >= 50.0)
      .map((entry) => entry.key)
      .toList();

  largeCrops.sort();
  print(largeCrops);

  List<int> numbers = [1, 2, 3, 4];

  Iterable<int> evenNumbers = numbers.where((number) => number.isEven);

  // Observe the difference between an Iterable and a List.
  print(evenNumbers);
  print(evenNumbers.toList());
}
