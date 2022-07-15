import 'dart:io';

import 'package:auth/config/config_manager.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/http/http_route/http_route_session/http_route_session_user_login.dart';
import 'package:auth/http/http_route/http_route_session/http_route_session_user_logout.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_add.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_all.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_delete.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_edit.dart';
import 'package:auth/http/http_route/http_route_user/http_route_user_get.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/session/session_manager.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class HttpManager {
  HttpServer? httpServer;

  HttpManager();

  Map<String, String> getHeaders() {
    var headers = {
      'Content-Type': 'application/json',
      'Accept-Type': 'application/json',
      'server': 'Auth application of the Lyria project.'
    };

    return headers;
  }

  Future<Session> getSession(Map<String, String> headers) async {
    if (headers['Cookie'] == null) {
      throw ExceptionForbidden();
    }

    try {
      var cookie = headers['Cookie']!.split(';')[0].split('=')[1];
      return await SessionManager().search(cookie);
    } catch (e) {
      throw ExceptionForbidden();
    }
  }

  Future<void> start() async {
    var host = (await ConfigManager().get()).apiHost;
    var path = (await ConfigManager().get()).apiPath;
    var port = (await ConfigManager().get()).apiPort;

    httpServer = await shelf_io.serve(
        Router()
          // Routes for user authentication.
          ..all('${path}session/user/login', httpRouteSessionLogin(path))
          ..all('${path}session/user/logout', httpRouteSessionLogout(path))

          // Routes for user management.
          ..delete('${path}user/<username>', httpRouteUserDelete(path))
          ..get('${path}user/<username>', httpRouteUserGet(path))
          ..post('${path}user', httpRouteUserAdd(path))
          ..get('${path}user', httpRouteUserAll(path))
          ..patch('${path}user/<username>', httpRouteUserEdit(path)),
        host,
        port);
  }

  Future<void> stop() async {
    if (httpServer != null) {
      httpServer!.close();
    }
  }
}
