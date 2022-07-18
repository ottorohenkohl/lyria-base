import 'dart:convert';

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

/// Route for editing an existing 'User' object.
Handler httpRouteUserEdit(String path) {
  return Router()
    ..patch('$path/user/<username>', (Request request, String username) async {
      try {
        // Parse request.
        Map<String, String> parsed = await HttpManager().parseRequest(
          request,
          ['password', 'forename', 'surname'],
          [],
        );

        // Get current Session.
        Session session = await SessionManager().check(parsed['cookie']!);

        // Retrieving desired user.
        User user = await UserManager().get(username: username);

        // Checking permissions.
        if (session.user.role != UserRole.admin &&
            session.user.uuid != user.uuid) {
          throw ExceptionAuth.forbidden();
        }

        user
          ..password = parsed['password']!
          ..forename = parsed['forename']!
          ..surname = parsed['surname']!
          ..save();

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
