import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler http_route_user_all() {
  return Router()
    ..get('/user', (Request request) async {
      try {
        // Get a valid session.
        Session session = await HttpManager().getSession(request.headers);

        // Checking permissions.
        if (session.entity.role != UserRole.admin || session.entity is! User) {
          throw ExceptionForbidden();
        }

        var users = [];
        (await UserManager().all()).forEach((user) {
          users.add({
            'username': user.username,
            'forename': user.forename ?? '',
            'surname': user.surname ?? '',
            'role': user.role
          });
        });

        return HttpResponse().success(body: {'users': users});
      } on ExceptionForbidden {
        return HttpResponse().forbidden();
      } catch (exception) {
        return HttpResponse().internalError();
      }
    });
}
