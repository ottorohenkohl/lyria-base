import 'package:auth/exceptions/exception_auth.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/permission/permission/permission.dart';
import 'package:auth/permission/permission_manager.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/session/session_manager.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for adding a new 'User' object in the user module.
Handler httpRoutePermissionAdd(String path) {
  return Router()
    ..post('$path/permission/<username>',
        (Request request, String username) async {
      try {
        // Parse request.
        Map<String, String> parsed = await HttpManager().parseRequest(
          request,
          ['cookie', 'value'],
          [],
        );

        // Get current Session.
        Session session = await SessionManager().check(parsed['cookie']!);

        // Checking permissions.
        if (session.user.role != UserRole.admin) {
          throw ExceptionAuth.forbidden();
        }

        // Get user.
        User user = await UserManager().get(username: username);

        // Creating a new permission.
        Permission permission = Permission(user: user, value: parsed['value']!);
        PermissionManager().add(permission);

        // Return success.
        return HttpResponse().success();
      } catch (exception) {
        if (exception is ExceptionAuth) {
          return exception.response();
        } else {
          rethrow;
        }
      }
    });
}
