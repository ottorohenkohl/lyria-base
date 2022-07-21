import 'package:auth/exceptions/exception_auth.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/session/session_manager.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for deleting a specific 'User' object in the user module.
Handler httpRouteUserDelete(String path) {
  return Router()
    ..delete('$path/user/<username>', (Request request, String username) async {
      try {
        // Parse request.
        Map<String, String> parsed = await HttpManager().parseRequest(
          request,
          ['cookie'],
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

        // Deleting user.
        user.delete();

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
