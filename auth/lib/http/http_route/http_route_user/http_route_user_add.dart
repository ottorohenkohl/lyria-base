import 'dart:convert';

import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler httpRouteUserAdd(String path) {
  return Router()
    ..post('${path}user', (Request request) async {
      try {
        // Get a valid session.
        Session session = await HttpManager().getSession(request.headers);

        // Retrieving user values from request body.
        var json = jsonDecode(await request.readAsString());
        String username = json['username'];
        String password = json['password'];
        String role = json['role'];
        String? forename = json['forename'];
        String? surname = json['surname'];
        if (role != 'admin' && role != 'user') {
          throw FormatException();
        }

        // Checking permissions.
        if (session.entity.role != UserRole.admin || session.entity is! User) {
          throw ExceptionForbidden();
        }

        // Parse UserRole.
        var userRole = UserRole.user;
        if (role == 'admin') {
          userRole = UserRole.admin;
        }

        // Creating a new user.
        var user = User(username: username, password: password, role: userRole)
          ..forename = forename
          ..surname = surname;
        UserManager().add(user);

        // Return success.
        return HttpResponse().success();
      } on ExceptionBadRequest {
        return HttpResponse().badRequest();
      } on ExceptionForbidden {
        return HttpResponse().forbidden();
      } catch (exception) {
        return HttpResponse().internalError();
      }
    });
}
