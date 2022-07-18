import 'package:auth/http/http_response.dart';
import 'package:shelf/shelf.dart';

class ExceptionAuth implements Exception {
  final String message;
  final int status;

  @override
  String toString() => message;

  Response response() => HttpResponse().custom(message, status);

  ExceptionAuth.badRequest()
      : status = 400,
        message = 'Bad Request.';

  ExceptionAuth.conflict()
      : status = 409,
        message = 'Conflict.';

  ExceptionAuth.forbidden()
      : status = 403,
        message = 'Forbidden.';

  ExceptionAuth.internalError()
      : status = 500,
        message = 'Internal Server Error.';

  ExceptionAuth.notFound()
      : status = 404,
        message = 'Not Found.';
}
