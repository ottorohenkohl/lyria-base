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

/// Route for deleting a specific 'User' object in the user module.
Handler httpRoutePermissionDelete(String path) {
  return Router()
    ..delete('$path/permission', (Request request, String username) async {
      try {
        // Parse request.
        Map<String, String> parsed = await HttpManager().parseRequest(
          request,
          ['cookie', 'username', 'value'],
          [],
        );

        // Get current Session.
        Session session = await SessionManager().check(parsed['cookie']!);

        // Retrieving desired user.
        User user = await UserManager().get(username: username);

        // Checking permissions.
        if (session.user.role != UserRole.admin) {
          throw ExceptionAuth.forbidden();
        }

        // Retrieving permissions
        Iterable<Permission> permissions = await PermissionManager().get(user);

        // Delete permission.
        permissions
            .where(((permission) => permission.value == parsed['value']!))
            .forEach((permission) => permission.delete());

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
