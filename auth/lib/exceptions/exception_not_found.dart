class ExceptionNotFound implements Exception {
  final String message = 'Not found.';
  final int status = 404;

  @override
  String toString() => message;
}
