class ExceptionBadRequest implements Exception {
  final String message = 'Bad Request.';
  final int status = 400;

  @override
  String toString() => message;
}
