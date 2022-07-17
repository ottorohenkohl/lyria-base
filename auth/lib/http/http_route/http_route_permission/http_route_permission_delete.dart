import 'dart:convert';

import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/permission/permission_manager.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for deleting a specific 'User' object in the user module.
Handler httpRoutePermissionDelete(String path) {
  return Router()
    ..delete('$path/permission', (Request request) async {
      try {
        // Get current Session.
        var data = await request.readAsString();
        var session = await HttpManager().getSession(data);

        // Retrieving permission values from request body.
        var json = jsonDecode(await request.readAsString());
        String username = json['username'];
        String value = json['value'];

        // Retrieving desired user.
        User user = await UserManager().get(username);

        // Checking permissions.
        if (session.entity.role != UserRole.admin) {
          throw ExceptionForbidden();
        }

        // Retrieving permissions
        var permissions = await PermissionManager().get(user);

        // Delete permission.
        permissions
            .where(((permission) => permission.value == value))
            .forEach((permission) => permission.delete());

        // Return success.
        return HttpResponse().success();
      } on ExceptionForbidden {
        return HttpResponse().forbidden();
      } on ExceptionNotFound {
        return HttpResponse().notFound();
      } catch (exception) {
        return HttpResponse().internalError();
      }
    });
}
