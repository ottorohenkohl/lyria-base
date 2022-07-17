/// Matches the equivalent Http-Response 'Internal Server Error'.
class ExceptionInternalError implements Exception {
  final String message = 'Internal Server Error.';
  final int status = 500;

  @override
  String toString() => message;
}
