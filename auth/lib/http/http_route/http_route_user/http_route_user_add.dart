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

/// Route for adding a new 'User' object in the user module.
Handler httpRouteUserAdd(String path) {
  return Router()
    ..post('$path/user', (Request request) async {
      try {
        // Parse request.
        Map<String, String> parsed = await HttpManager().parseRequest(
          request,
          ['cookie', 'username', 'password', 'role'],
          ['forename', 'surname'],
        );

        // Get current Session.
        Session session = await SessionManager().check(parsed['cookie']!);

        // Checking correct formating.
        if (parsed['role']! != 'admin' && parsed['role']! != 'user') {
          throw ExceptionAuth.badRequest();
        }

        // Checking permissions.
        if (session.user.role != UserRole.admin) {
          throw ExceptionAuth.forbidden();
        }

        // Parse UserRole.
        UserRole role =
            parsed['role']! == 'admin' ? UserRole.admin : UserRole.user;

        // Creating a new user.
        User user = User(
            username: parsed['username']!,
            password: parsed['password']!,
            role: role)
          ..forename = parsed['forename']
          ..surname = parsed['surname'];
        await UserManager().add(user);

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
