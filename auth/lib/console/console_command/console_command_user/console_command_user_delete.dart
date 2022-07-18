import 'package:args/command_runner.dart';
import 'package:auth/user/user_manager.dart';

/// Delete a specific 'User' object in the user module.
class ConsoleCommandUserDelete extends Command {
  @override
  final String name = 'delete';

  @override
  final String description = 'Delete an existing user.';

  ConsoleCommandUserDelete() {
    argParser.addOption('username', abbr: 'u', help: 'Username of the user.');
  }

  @override
  void run() async {
    (await UserManager().get(username: argResults!['username'])).delete();
  }
}
