/// Matches the equivalent Http-Response 'Forbidden'.
class ExceptionForbidden implements Exception {
  final String message = 'Forbidden.';
  final int status = 403;

  @override
  String toString() => message;
}
