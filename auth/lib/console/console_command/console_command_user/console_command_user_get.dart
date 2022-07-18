import 'package:args/command_runner.dart';
import 'package:auth/user/user/user.dart';
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
    User user = await UserManager().get(username: argResults!['username']);
    Map<String, String> data = {
      'username': user.username,
      'role': user.role.toString().split('.').last,
      'forename': user.forename ?? '',
      'surname': user.surname ?? ''
    };

    print(data);
  }
}
