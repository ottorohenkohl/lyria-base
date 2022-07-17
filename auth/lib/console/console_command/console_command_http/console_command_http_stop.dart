import 'package:args/command_runner.dart';
import 'package:auth/http/http_manager.dart';

/// Stop listening through the http module.
class ConsoleCommandHttpStart extends Command {
  @override
  final String name = 'stop';

  @override
  final String description = 'Stop the http module.';

  ConsoleCommandHttpStart();

  @override
  void run() async {
    HttpManager().stop();
  }
}
