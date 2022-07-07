class ExceptionForbidden implements Exception {
  final int status = 403;
  final String message = 'Forbidden.';

  @override
  String toString() => message;
}
