void validateArea(double area) {
  if (!area.isFinite || area <= 0) {
    throw FormatException('Invalid area.');
  }
}

void processArea(double area) {
  try {
    validateArea(area);
  } on FormatException {
    print('Validation failed.');
    rethrow;
  }
}

void main() {
  try {
    processArea(-1.0);
  } on FormatException {
    print('Caller handled the error.');
  }
}
