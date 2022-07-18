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

/// Route for retrieving all existing 'User' objects in the user module.
Handler httpRouteUserAll(String path) {
  return Router()
    ..get('$path/user', (Request request) async {
      try {
        // Parse request.
        Map<String, String> parsed = await HttpManager().parseRequest(
          request,
          ['cookie'],
          [],
        );

        // Get current Session.
        Session session = await SessionManager().check(parsed['cookie']!);

        // Checking permissions.
        if (session.user.role != UserRole.admin) {
          throw ExceptionAuth.forbidden();
        }

        List<Map<String, String>> users = [];
        for (User element in (await UserManager().all())) {
          users.add({
            'username': element.username,
            'role': element.role.toString().split('.').last,
            'forename': element.forename ?? '',
            'surname': element.surname ?? '',
          });
        }

        return HttpResponse().success(body: {'users': users});
      } catch (exception) {
        if (exception is ExceptionAuth) {
          return exception.response();
        } else {
          rethrow;
        }
      }
    });
}
