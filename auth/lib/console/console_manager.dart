import 'package:args/command_runner.dart';
import 'package:auth/console/console_command/console_command.dart';

/// For managig any CLI related tasks.
class ConsoleManager {
  ConsoleManager();

  /// Handle commandline arguments.
  void handle(Iterable<String> arguments) {
    CommandRunner('lyria-auth', 'CLI of the auth application.')
      ..addCommand(CommandConfig())
      ..addCommand(CommandHttp())
      ..addCommand(CommandPermission())
      ..addCommand(CommandUser())
      ..run(arguments);
  }

  /// Log a message with matching datetime.
  void log(dynamic message, String type) {
    DateTime datetime = DateTime.now();
    String info = '[${type.toUpperCase()}]';
    print('$datetime $info  $message');
  }
}
