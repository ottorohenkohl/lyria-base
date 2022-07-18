import 'package:args/command_runner.dart';
import 'package:auth/http/http_manager.dart';

/// Stop listening through the http module.
class ConsoleCommandHttpStop extends Command {
  @override
  final String name = 'stop';

  @override
  final String description = 'Stop the http module.';

  ConsoleCommandHttpStop();

  @override
  void run() async {
    HttpManager().stop();
  }
}
