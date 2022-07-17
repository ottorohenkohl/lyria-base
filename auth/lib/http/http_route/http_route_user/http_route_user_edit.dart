import 'dart:convert';

import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for editing an existing 'User' object.
Handler httpRouteUserEdit(String path) {
  return Router()
    ..patch('$path/user/<username>', (Request request, String username) async {
      try {
        // Retrieving desired changes from request.
        var json = jsonDecode(await request.readAsString());
        String? password = json['password'];
        String? forename = json['forename'];
        String? surname = json['surname'];

        // Get current Session.
        var data = await request.readAsString();
        var session = await HttpManager().getSession(data);

        // Retrieving desired user.
        User user = await UserManager().get(username);

        // Checking permissions.
        if ((session.entity.role != UserRole.admin && session.entity != user) ||
            session.entity is! User) {
          throw ExceptionForbidden();
        }

        user
          ..password = password ?? user.password
          ..forename = forename ?? user.forename
          ..surname = surname ?? user.surname
          ..save();

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
