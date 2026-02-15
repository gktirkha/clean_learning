class ServerException implements Exception {
  ServerException([this.message = 'Oops Something went Wrong']);

  final String message;
}
