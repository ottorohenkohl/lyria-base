class ExceptionInUse implements Exception {
  final String message = 'Conflict.';
  final int status = 409;

  @override
  String toString() => message;
}
