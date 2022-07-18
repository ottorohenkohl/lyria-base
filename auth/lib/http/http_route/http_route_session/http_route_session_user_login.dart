import 'package:auth/exceptions/exception_auth.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/session/session_manager.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for logging in and retrieving a valid session cookie.
Handler httpRouteSessionLogin(String path) {
  return Router()
    ..post('$path/session/login', (Request request) async {
      try {
        // Parse request.
        Map<String, String> parsed = await HttpManager().parseRequest(
          request,
          ['username', 'password'],
          [],
        );

        // Checking 'password' and retrieve desired user.
        User user = await UserManager().login(
          parsed['username']!,
          parsed['password']!,
        );

        // Creating a new session.
        Session session = await SessionManager().create(user);

        // Return 'cookie'.
        Map<String, String> body = {'cookie': session.cookie};
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
