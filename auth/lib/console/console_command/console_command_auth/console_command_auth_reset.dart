import 'package:args/command_runner.dart';
import 'package:auth/config/config_manager.dart';
import 'package:auth/http/http_manager.dart';

/// Command for starting the auth application.
class ConsoleCommandAuthReset extends Command {
  @override
  final String name = 'reset';

  @override
  final String description = 'Reset the auth application.';

  ConsoleCommandAuthReset();

  @override
  void run() {
    HttpManager().stop();
    ConfigManager().reset();
  }
}
