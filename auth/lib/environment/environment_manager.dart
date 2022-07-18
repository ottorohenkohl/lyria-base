import 'dart:io';

import 'package:auth/config/config/config.dart';
import 'package:auth/config/config_manager.dart';
import 'package:auth/console/console_manager.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';

/// For managing environment settings.
class EnvironmentManager {
  EnvironmentManager();

  /// Add a 'User' object through environment variables.
  Future<void> loadUser() async {
    Map<String, String> environment = Platform.environment;

    String? username = environment['USER_USERNAME'];
    String? password = environment['USER_PASSWORD'];
    String? role = environment['USER_ROLE'];

    try {
      UserRole userRole = role == 'admin' ? UserRole.admin : UserRole.user;
      User user = User(
        username: username!,
        password: password!,
        role: userRole,
      );

      await UserManager().add(user);
      ConsoleManager().log('Added user through environment.', 'info');
    } catch (exception) {
      // ignore: empty_catches
    }
  }

  /// Modify the 'Config' object through environment variables.
  Future<void> loadConfig() async {
    Map<String, String> environment = Platform.environment;
    Config config = await ConfigManager().standard();

    String apiHost = environment['API_HOST'] ?? config.apiHost;
    String apiPath = environment['API_PATH'] ?? config.apiPath;

    if (environment['API_HOST'] == null && environment['API_PATH'] == null) {
      return;
    }

    config = await ConfigManager().get()
      ..apiHost = apiHost
      ..apiPath = apiPath
      ..save();

    ConsoleManager().log('Set config through environment.', 'info');
  }
}
