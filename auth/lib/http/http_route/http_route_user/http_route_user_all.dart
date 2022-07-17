import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Route for retrieving all existing 'User' objects in the user module.
Handler httpRouteUserAll(String path) {
  return Router()
    ..get('$path/user', (Request request) async {
      try {
        // Get current Session.
        var data = await request.readAsString();
        var session = await HttpManager().getSession(data);

        // Checking permissions.
        if (session.entity.role != UserRole.admin) {
          throw ExceptionForbidden();
        }

        var users = [];
        for (var user in (await UserManager().all())) {
          users.add({
            'username': user.username,
            'forename': user.forename ?? '',
            'surname': user.surname ?? '',
            'role': user.role
          });
        }

        return HttpResponse().success(body: {'users': users});
      } on ExceptionForbidden {
        return HttpResponse().forbidden();
      } catch (exception) {
        return HttpResponse().internalError();
      }
    });
}
