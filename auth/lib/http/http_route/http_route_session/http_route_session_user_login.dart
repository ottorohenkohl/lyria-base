import 'dart:convert';

import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/session/session_manager.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for logging in and retrieving a valid session cookie.
Handler httpRouteSessionLogin(String path) {
  return Router()
    ..post('$path/session/user/login', (Request request) async {
      try {
        // Retrieving 'username' and 'password' from request body.
        String data = await request.readAsString();
        String username = jsonDecode(data)['username'];
        String password = jsonDecode(data)['password'];

        // Checking 'password' and retrieve desired user.
        User user = await UserManager().login(username, password);

        // Creating a new session.
        var session = await SessionManager().create(user);

        // Return 'cookie'.
        var headers = HttpManager().getHeaders();
        var body = {'Cookie': session.cookie};
        return HttpResponse().success(headers: headers, body: body);
      } on ExceptionBadRequest {
        return HttpResponse().badRequest();
      } on ExceptionForbidden {
        return HttpResponse().forbidden();
      } on ExceptionNotFound {
        return HttpResponse().notFound();
      } catch (exception) {
        return HttpResponse().internalError();
      }
    });
}
