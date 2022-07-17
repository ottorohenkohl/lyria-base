import 'dart:convert';
import 'dart:io';

import 'package:auth/config/config_manager.dart';
import 'package:auth/console/console_manager.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/http/http_route/http_route_permission/http_route_permission_add.dart';
import 'package:auth/http/http_route/http_route_permission/http_route_permission_delete.dart';
import 'package:auth/http/http_route/http_route_permission/http_route_permission_get.dart';
import 'package:auth/http/http_route/http_route_session/http_route_session_user_login.dart';
import 'package:auth/http/http_route/http_route_session/http_route_session_user_logout.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_add.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_all.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_delete.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_edit.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_get.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/session/session_manager.dart';
import 'package:auth/user/user/user.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

/// For managing all Http related tasks like a REST-API.
class HttpManager {
  HttpServer? httpServer;

  HttpManager();

  /// Retrieve default Http-Headers.
  Map<String, String> getHeaders() {
    var headers = {
      'Content-Type': 'application/json',
      'Accept-Type': 'application/json',
      'server': 'Auth application of the Lyria project.'
    };

    return headers;
  }

  /// Retrieve a 'Session' object through the Http-Request's data.
  Future<Session> getSession(String request) async {
    try {
      var cookie = jsonDecode(request)['cookie'];
      var session = await SessionManager().search(cookie);

      if (session.entity is! User || !SessionManager().isValid(session)) {
        throw ExceptionForbidden();
      }

      return session;
    } catch (execption) {
      throw ExceptionForbidden();
    }
  }

  /// Start listening on the REST-API.
  Future<void> start() async {
    var host = (await ConfigManager().get()).apiHost;
    var path = (await ConfigManager().get()).apiPath;
    var port = (await ConfigManager().get()).apiPort;

    ConsoleManager().log('Listening on http://$host:$port$path', 'info');

    httpServer = await shelf_io.serve(
        Router()
          // Routes for permission managmenet.
          ..post('$path/permission', httpRoutePermissionAdd(path))
          ..delete('$path/permission', httpRoutePermissionDelete(path))
          ..get('$path/permission', httpRoutePermissionGet(path))

          // Routes for user authentication.
          ..all('$path/session/user/login', httpRouteSessionLogin(path))
          ..all('$path/session/user/logout', httpRouteSessionLogout(path))

          // Routes for user management.
          ..delete('$path/user/<username>', httpRouteUserDelete(path))
          ..get('$path/user/<username>', httpRouteUserGet(path))
          ..post('$path/user', httpRouteUserAdd(path))
          ..get('$path/user', httpRouteUserAll(path))
          ..patch('$path/user/<username>', httpRouteUserEdit(path)),
        host,
        port);
  }

  // Stop listening on the REST-API.
  Future<void> stop() async {
    if (httpServer != null) {
      ConsoleManager().log('Stop Listening on http.', 'info');
      httpServer!.close();
    }
  }
}
