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

// Route for retrieving a specifig 'User' object from the user module.
Handler httpRouteUserGet(String path) {
  return Router()
    ..get('$path/user/<username>', (Request request, String username) async {
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
            session.user.username != user.username) {
          throw ExceptionAuth.forbidden();
        }

        // Format 'User' object.
        Map<String, Map<String, String>> body = {
          'user': {
            'username': user.username,
            'forename': user.forename ?? '',
            'surname': user.surname ?? '',
            'role': user.role.toString().split('.').last,
          }
        };

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
