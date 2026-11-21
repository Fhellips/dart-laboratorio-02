class CropArea {
  final String name;
  final double plantedArea;

  CropArea({required String name, required this.plantedArea})
    : name = name.trim() {
    if (this.name.isEmpty) {
      throw FormatException('Crop name must not be empty.');
    }

    if (!plantedArea.isFinite || plantedArea <= 0) {
      throw FormatException('Planted area must be positive and finite.');
    }
  }
}

void main() {
  try {
    CropArea crop = CropArea(name: '', plantedArea: 12.5);
    print(crop.name);
  } on FormatException catch (error) {
    print('Invalid crop: ${error.message}');
  }
}
