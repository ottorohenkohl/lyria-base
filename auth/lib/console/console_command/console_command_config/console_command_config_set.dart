import 'package:args/command_runner.dart';
import 'package:auth/config/config/config.dart';
import 'package:auth/config/config_manager.dart';

/// Set a value in the 'Config' object.
class ConsoleCommandConfigSet extends Command {
  @override
  final String name = 'set';

  @override
  final String description = 'Set a config value.';

  ConsoleCommandConfigSet() {
    argParser
      ..addOption('apiHost', help: 'Host of the api.')
      ..addOption('apiPath', help: 'Path of the api.')
      ..addOption('apiPort', help: 'Port of the api.')
      ..addOption('sessionDuration', help: 'Session duration (minutes).');
  }

  @override
  void run() async {
    Config config = await ConfigManager().get();

    await ConfigManager().get()
      ..apiHost = argResults!['apiHost'] ?? config.apiHost
      ..apiPath = argResults!['apiPath'] ?? config.apiPath
      ..apiPort =
          int.parse((argResults!['apiPort'] ?? config.apiPort).toString())
      ..sessionDuration = int.parse(
          (argResults!['sessionDuration'] ?? config.sessionDuration).toString())
      ..save();
  }
}
