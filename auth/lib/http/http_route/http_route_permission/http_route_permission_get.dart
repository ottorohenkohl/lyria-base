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

// Route for retrieving a specifig 'User' object from the user module.
Handler httpRoutePermissionGet(String path) {
  return Router()
    ..get('$path/permission', (Request request) async {
      try {
        // Get current Session.
        var data = await request.readAsString();
        var session = await HttpManager().getSession(data);

        // Retrieving permission values from request body.
        var json = jsonDecode(await request.readAsString());
        String username = json['username'];

        // Retrieving desired user.
        User user = await UserManager().get(username);

        // Checking permissions.
        if (session.entity.role != UserRole.admin &&
            session.entity.username != user.username) {
          throw ExceptionForbidden();
        }

        // Retrieving permissions
        var permissions = await PermissionManager().get(user);
        var body = <String>[];

        for (var permission in permissions) {
          body.add(permission.value);
        }

        // Return success.
        return HttpResponse().success(body: {'permission': body});
      } on ExceptionForbidden {
        return HttpResponse().forbidden();
      } on ExceptionNotFound {
        return HttpResponse().notFound();
      } catch (exception) {
        return HttpResponse().internalError();
      }
    });
}
