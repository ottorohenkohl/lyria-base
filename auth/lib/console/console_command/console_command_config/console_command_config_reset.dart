import 'package:args/command_runner.dart';
import 'package:auth/config/config_manager.dart';

/// Reset the current 'Config' object on disk.
class ConsoleCommandConfigReset extends Command {
  @override
  final String name = 'reset';

  @override
  final String description = 'Reset the current config.';

  ConsoleCommandConfigReset();

  @override
  void run() {
    ConfigManager().reset();
  }
}
