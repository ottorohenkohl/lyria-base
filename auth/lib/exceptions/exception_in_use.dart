class ExceptionInUse implements Exception {
  final int status = 409;
  final String message = 'Conflict.';

  @override
  String toString() => message;
}
