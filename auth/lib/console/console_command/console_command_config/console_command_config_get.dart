import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:auth/config/config_manager.dart';

/// Get the currently saved 'Config' object.
class ConsoleCommandConfigGet extends Command {
  @override
  final String name = 'get';

  @override
  final String description = 'Get the current config.';

  ConsoleCommandConfigGet();

  @override
  void run() async {
    var config = await ConfigManager().get();

    var json = jsonEncode({
      'apiHost': config.apiHost,
      'apiPort': config.apiPort,
      'apiPath': config.apiPath,
      'sessionDuration': config.sessionDuration
    });

    print(json);
  }
}
