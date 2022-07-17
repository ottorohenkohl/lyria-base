import 'dart:convert';

import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/permission/permission/permission.dart';
import 'package:auth/permission/permission_manager.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for adding a new 'User' object in the user module.
Handler httpRoutePermissionAdd(String path) {
  return Router()
    ..post('$path/permission', (Request request) async {
      try {
        // Get current Session.
        var data = await request.readAsString();
        var session = await HttpManager().getSession(data);

        // Retrieving permission values from request body.
        var json = jsonDecode(await request.readAsString());
        String username = json['username'];
        String value = json['value'];

        // Checking permissions.
        if (session.entity.role != UserRole.admin) {
          throw ExceptionForbidden();
        }

        // Get user.
        var user = await UserManager().get(username);

        // Creating a new permission.
        var permission = Permission(user: user, value: value);
        PermissionManager().add(permission);

        // Return success.
        return HttpResponse().success();
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
