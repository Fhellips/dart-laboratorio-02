void showNote(String? note) {
  print(note ?? 'No note available');
}

void main() {
  showNote(null);
  showNote('Verified manually');
}
