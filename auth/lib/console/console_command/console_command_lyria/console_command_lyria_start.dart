import 'package:args/command_runner.dart';
import 'package:auth/http/http_manager.dart';

/// Command for starting the "lyria-base" application.
class ConsoleCommandLyriaStart extends Command {
  @override
  final String name = 'start';

  @override
  final String description = 'Start the "lyria-base" application.';

  ConsoleCommandLyriaStart();

  @override
  void run() async {
    HttpManager().start();
  }
}
