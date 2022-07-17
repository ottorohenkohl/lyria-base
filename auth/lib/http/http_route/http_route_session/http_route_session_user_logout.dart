import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for logging out by deleting the current 'Session' object.
Handler httpRouteSessionLogout(String path) {
  return Router()
    ..post('$path/session/user/logout', (Request request) async {
      try {
        // Get current Session.
        var data = await request.readAsString();
        var session = await HttpManager().getSession(data);

        // Delete the session.
        session.delete();

        // Reset cookies and return success.
        return HttpResponse().success();
      } on ExceptionForbidden {
        return HttpResponse().forbidden();
      } catch (exception) {
        return HttpResponse().internalError();
      }
    });
}
