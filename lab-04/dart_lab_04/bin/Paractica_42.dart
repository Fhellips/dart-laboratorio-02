class CropArea {
  final String name;
  final double plantedArea;

  CropArea(this.name, this.plantedArea);

  String describe() {
    return '$name: $plantedArea ha';
  }
}

void main() {
  CropArea coffee = CropArea('Coffee', 125.0);
  CropArea beans = CropArea('Beans', 40.0);

  print(coffee.describe());
  print(beans.describe());
}