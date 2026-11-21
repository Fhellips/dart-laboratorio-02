void showMunicipality(String? municipality) {
  if (municipality == null) {
    print('Municipality is missing.');
    return;
  }

  print(municipality.trim().toLowerCase());
}

void main() {
  showMunicipality(null);
  showMunicipality(' Andes ');
}
