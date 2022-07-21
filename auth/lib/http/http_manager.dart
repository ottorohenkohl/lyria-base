import 'dart:convert';
import 'dart:io';

import 'package:auth/config/config_manager.dart';
import 'package:auth/console/console_manager.dart';
import 'package:auth/exceptions/exception_auth.dart';
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
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

/// For managing all Http related tasks like a REST-API.
class HttpManager {
  HttpServer? httpServer;

  HttpManager();

  /// Retrieve default Http-Headers.
  Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept-Type': 'application/json',
      'server': 'Auth application of the Lyria project.',
    };

    return headers;
  }

  Future<Map<String, String>> parseRequest(
    Request request,
    List<String> required,
    List<String> optional,
  ) async {
    Map<String, String> parsed = {};

    try {
      Map<String, dynamic> data = jsonDecode(await request.readAsString());

      for (String element in required) {
        parsed[element] = data[element];
      }

      for (String element in optional) {
        parsed[element] = data[element] ?? '';
      }
    } catch (e) {
      throw ExceptionAuth.badRequest();
    }

    return parsed;
  }

  /// Start listening on the REST-API.
  Future<void> start() async {
    String host = (await ConfigManager().get()).apiHost;
    String path = (await ConfigManager().get()).apiPath;
    int port = (await ConfigManager().get()).apiPort;

    ConsoleManager().log('Listening on http://$host:$port$path', 'info');

    httpServer = await shelf_io.serve(
        Router()
          // Routes for permission managmenet.
          ..post('$path/permission/<username>', httpRoutePermissionAdd(path))
          ..delete(
              '$path/permission/<username>', httpRoutePermissionDelete(path))
          ..get('$path/permission/<username>', httpRoutePermissionGet(path))

          // Routes for user authentication.
          ..post('$path/session', httpRouteSessionLogin(path))
          ..delete('$path/session', httpRouteSessionLogout(path))

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
    ConsoleManager().log('Stop Listening on http.', 'info');
    httpServer?.close();
  }
}
