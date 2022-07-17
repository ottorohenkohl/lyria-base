import 'dart:convert';

import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_in_use.dart';
import 'package:auth/exceptions/exception_internal_internal.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/http/http_manager.dart';
import 'package:shelf/shelf.dart';

/// Standard Http-Response templates.
///
/// For more information see the related RFC 7231.
/// https://datatracker.ietf.org/doc/html/rfc7231#section-6.1
class HttpResponse {
  HttpResponse();

  Response badRequest() {
    var exception = ExceptionBadRequest();
    var headers = HttpManager().getHeaders();
    var body = jsonEncode({'message': exception.toString()});

    return Response(exception.status, body: body, headers: headers);
  }

  Response forbidden() {
    var exception = ExceptionForbidden();
    var headers = HttpManager().getHeaders();
    var body = jsonEncode({'message': exception.toString()});

    return Response(exception.status, body: body, headers: headers);
  }

  Response internalError() {
    var exception = ExceptionInternalError();
    var headers = HttpManager().getHeaders();
    var body = jsonEncode({'message': exception.toString()});

    return Response(exception.status, body: body, headers: headers);
  }

  Response inUse() {
    var exception = ExceptionConflict();
    var headers = HttpManager().getHeaders();
    var body = jsonEncode({'message': exception.toString()});

    return Response(exception.status, body: body, headers: headers);
  }

  Response notFound() {
    var exception = ExceptionNotFound();
    var headers = HttpManager().getHeaders();
    var body = jsonEncode({'message': exception.toString()});

    return Response(exception.status, body: body, headers: headers);
  }

  Response success({Map<String, String>? headers, Map<String, dynamic>? body}) {
    body = {'message': 'worked!'}..addAll(body ?? {});
    headers = HttpManager().getHeaders()..addAll(headers ?? {});

    return Response(200, body: jsonEncode(body), headers: headers);
  }
}
