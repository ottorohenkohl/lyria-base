import 'package:auth/exceptions/exception_auth.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/session/session_manager.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for logging out by deleting the current 'Session' object.
Handler httpRouteSessionLogout(String path) {
  return Router()
    ..delete('$path/session', (Request request) async {
      try {
        // Parse request.
        Map<String, String> parsed =
            await HttpManager().parseRequest(request, ['cookie'], []);

        // Get current Session.
        Session session = await SessionManager().check(parsed['cookie']!);

        // Delete the session.
        session.delete();

        // Reset cookies and return success.
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
