import 'dart:io';

import 'package:auth/config/config/config.dart';
import 'package:auth/config/config_manager.dart';
import 'package:auth/console/console_manager.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:hive/hive.dart';

void main(List<String> arguments) {
  Hive.init('./data');

  Hive.registerAdapter(ConfigAdapter());
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserRoleAdapter());

  autoConfig();
  autoUser();

  ConsoleManager().handle(arguments);
}

void autoConfig() async {
  var environment = Platform.environment;
  var config = await ConfigManager().standard();

  String apiHost = environment['API_HOST'] ?? config.apiHost;
  String apiPath = environment['API_PATH'] ?? config.apiPath;

  config = await ConfigManager().get();
  config
    ..apiHost = apiHost
    ..apiPath = apiPath
    ..save();
}

void autoUser() async {
  var environment = Platform.environment;

  String? username = environment['USER_USERNAME'];
  String? password = environment['USER_PASSWORD'];
  String? role = environment['USER_ROLE'];

  if (username != null) {
    var userRole = UserRole.admin;
    if (role == 'admin') {
      userRole == UserRole.admin;
    }
    var user = User(username: username, password: password, role: userRole);
    try {
      await UserManager().add(user);
    } catch (exception) {
      print('Skipping user creation.');
    }
  }
}
