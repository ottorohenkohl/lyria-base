class ExceptionNotFound implements Exception {
  final int status = 404;
  final String message = 'Not found.';

  @override
  String toString() => message;
}
