class ExceptionBadRequest implements Exception {
  final int status = 400;
  final String message = 'Bad Request.';

  @override
  String toString() => message;
}
