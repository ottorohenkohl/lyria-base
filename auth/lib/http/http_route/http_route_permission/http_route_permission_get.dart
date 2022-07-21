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

// Route for retrieving a specifig 'User' object from the user module.
Handler httpRoutePermissionGet(String path) {
  return Router()
    ..get('$path/permission', (Request request, String username) async {
      try {
        // Parse request.
        Map<String, String> parsed = await HttpManager().parseRequest(
          request,
          ['cookie', 'username'],
          [],
        );

        // Get current Session.
        Session session = await SessionManager().check(parsed['cookie']!);

        // Retrieving desired user.
        User user = await UserManager().get(username: username);

        // Checking permissions.
        if (session.user.role != UserRole.admin &&
            session.user.uuid != user.uuid) {
          throw ExceptionAuth.forbidden();
        }

        // Retrieving permissions
        Iterable<Permission> permissions = await PermissionManager().get(user);
        Map<String, List<String>> body = {'permission': []};

        for (Permission element in permissions) {
          body['permission']!.add(element.value);
        }

        // Return success.
        return HttpResponse().success(body: body);
      } catch (exception) {
        if (exception is ExceptionAuth) {
          return exception.response();
        } else {
          rethrow;
        }
      }
    });
}
