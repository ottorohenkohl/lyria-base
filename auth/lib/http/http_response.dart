import 'dart:convert';

import 'package:auth/http/http_manager.dart';
import 'package:shelf/shelf.dart';

/// Standard Http-Response templates.
///
/// For more information see the related RFC 7231.
/// https://datatracker.ietf.org/doc/html/rfc7231#section-6.1
class HttpResponse {
  HttpResponse();

  Response custom(String message, int status) {
    String body = jsonEncode({'message': message});
    Map<String, Object> headers = HttpManager().getHeaders();

    return Response(200, body: body, headers: headers);
  }

  Response success({Map<String, String>? headers, Map<String, dynamic>? body}) {
    body = {'message': 'worked!'}..addAll(body ?? {});
    headers = HttpManager().getHeaders()..addAll(headers ?? {});

    return Response(200, body: jsonEncode(body), headers: headers);
  }
}
