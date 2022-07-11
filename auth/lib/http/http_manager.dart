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
    return {
      'Content-Type': 'application/json',
      'Accept-Type': 'application/json',
      'server': 'lyra-base with http module'
    };
  }

  Future<Session> getSession(Map<String, String> headers) async {
    if (headers['Cookie'] == null) {
      throw ExceptionForbidden();
    }
    try {
      String cookie = headers['Cookie']!.split(';')[0].split('=')[1];
      return await SessionManager().search(cookie);
    } catch (e) {
      throw ExceptionForbidden();
    }
  }

  Future<void> start() async {
    var host = (await ConfigManager().get()).apiHost;
    var port = (await ConfigManager().get()).apiPort;
    httpServer = await shelf_io.serve(
        Router()
          // Routes for user authentication.
          ..all('/session/user/login', http_route_session_login())
          ..all('/session/user/logout', http_route_session_logout())

          // Routes for user management.
          ..delete('/user/<username>', http_route_user_delete())
          ..get('/user/<username>', http_route_user_get())
          ..post('/user', http_route_user_add())
          ..get('/user', http_route_user_all())
          ..patch('/user/<username>', http_route_user_edit()),
        host,
        port);
  }

  Future<void> stop() async {
    if (httpServer != null) {
      httpServer!.close();
    }
  }
}
