import 'dart:convert';

import 'package:auth/config/config_manager.dart';
import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/session/session_manager.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler http_route_session_login() {
  return Router()
    ..post('/session/user/login', (Request request) async {
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
        var headers = {'Set-Cookie': 'name=${session.cookie}'};
        return HttpResponse().success(headers: headers);
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
