import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/user/user/user.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler httpRouteSessionLogout(String path) {
  return Router()
    ..post('${path}session/user/logout', (Request request) async {
      try {
        // Check for a valid user session.
        var session = await HttpManager().getSession(request.headers);
        if (session.entity is! User) {
          throw ExceptionForbidden();
        }

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
