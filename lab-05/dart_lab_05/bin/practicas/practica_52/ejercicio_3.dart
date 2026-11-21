void main() {
  double? area = double.tryParse('NaN');

  if (area == null || !area.isFinite || area <= 0) {
    print('Enter a positive finite area.');
  } else {
    print('Accepted area: $area');
  }
}
