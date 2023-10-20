class InvalidNameException implements Exception {
  String error() => "Insira seu nome.";

  @override
  String toString() {
    return error();
  }
}
