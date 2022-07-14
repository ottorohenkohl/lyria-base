import 'package:args/command_runner.dart';
import 'package:auth/http/http_manager.dart';

/// Command for starting the "lyria-base" application.
class ConsoleCommandAuthStart extends Command {
  @override
  final String name = 'start';

  @override
  final String description = 'Start the auth application.';

  ConsoleCommandAuthStart();

  @override
  void run() async {
    print('Starting...');
    HttpManager().start();
  }
}
