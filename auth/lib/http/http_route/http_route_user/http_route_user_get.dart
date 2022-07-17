import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/http/http_manager.dart';
import 'package:auth/http/http_response.dart';
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
        // Get current Session.
        var data = await request.readAsString();
        var session = await HttpManager().getSession(data);

        // Retrieving desired user.
        User user = await UserManager().get(username);

        // Checking permissions.
        if (session.entity.role != UserRole.admin && session.entity != user) {
          throw ExceptionForbidden();
        }

        // Return success.
        return HttpResponse().success(body: {
          'user': {
            'username': user.username,
            'forename': user.forename ?? '',
            'surname': user.surname ?? '',
            'role': user.role
          }
        });
      } on ExceptionForbidden {
        return HttpResponse().forbidden();
      } on ExceptionNotFound {
        return HttpResponse().notFound();
      } catch (exception) {
        return HttpResponse().internalError();
      }
    });
}
