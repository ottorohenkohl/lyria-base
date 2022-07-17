/// Matches the equivalent Http-Response 'Conflict'.
class ExceptionConflict implements Exception {
  final String message = 'Conflict.';
  final int status = 409;

  @override
  String toString() => message;
}
