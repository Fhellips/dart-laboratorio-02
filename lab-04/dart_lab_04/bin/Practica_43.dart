class AreaCounter {
  double _totalArea = 0.0;

  double get totalArea => _totalArea;

  bool addArea(double area) {
    if (!area.isFinite || area <= 0) {
      return false;
    }

    double nextTotal = _totalArea + area;

    if (!nextTotal.isFinite) {
      return false;
    }

    _totalArea = nextTotal;
    return true;
  }
}

void main() {
  AreaCounter counter = AreaCounter();

  print(counter.addArea(25.0));
  print(counter.addArea(-3.0));
  print(counter.totalArea);
}