import 'dart:convert';

import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_in_use.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/http/http_manager.dart';
import 'package:shelf/shelf.dart';

class HttpResponse {
  HttpResponse();

  Response badRequest() {
    var body = jsonEncode({'message': ExceptionBadRequest().toString()});
    return Response(400, body: body, headers: HttpManager().getHeaders());
  }

  Response forbidden() {
    var body = jsonEncode({'message': ExceptionForbidden().toString()});
    return Response(403, body: body, headers: HttpManager().getHeaders());
  }

  Response internalError() {
    var body = jsonEncode({'message': 'Something went wrong!'});
    return Response(500, body: body, headers: HttpManager().getHeaders());
  }

  Response inUse() {
    var body = jsonEncode({'message': ExceptionInUse().toString()});
    return Response(410, body: body, headers: HttpManager().getHeaders());
  }

  Response notFound() {
    var body = jsonEncode({'message': ExceptionNotFound().toString()});
    return Response(403, body: body, headers: HttpManager().getHeaders());
  }

  Response success({Map<String, String>? headers, Map<String, dynamic>? body}) {
    Map<String, dynamic> newBody = {'message': 'worked!'}..addAll(body ?? {});
    Map<String, String> newHeaders = HttpManager().getHeaders()
      ..addAll(headers ?? {});

    return Response(200, body: jsonEncode(newBody), headers: newHeaders);
  }
}
