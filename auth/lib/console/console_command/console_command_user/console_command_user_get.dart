import 'package:args/command_runner.dart';
import 'package:auth/user/user_manager.dart';

/// Retrieve a specific 'User' object in the user module.
class ConsoleCommandUserGet extends Command {
  @override
  final String name = 'get';

  @override
  final String description = 'Get an existing user.';

  ConsoleCommandUserGet() {
    argParser.addOption('username', abbr: 'u', help: 'Username of the user.');
  }

  @override
  void run() async {
    var user = await UserManager().get(argResults!['username']);
    var data = {
      'username': user.username,
      'role': user.role,
      'forename': user.forename,
      'surname': user.surname
    };

    print(data);
  }
}
