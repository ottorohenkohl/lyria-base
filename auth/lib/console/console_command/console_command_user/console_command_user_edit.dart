import 'package:args/command_runner.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';

/// Edit an existing 'User' object in the user module.
class ConsoleCommandUserEdit extends Command {
  @override
  final String name = 'edit';

  @override
  final String description = 'Edit an existing user.';

  ConsoleCommandUserEdit() {
    argParser
      ..addOption('username', abbr: 'u', help: 'Username of the user.')
      ..addOption('password', abbr: 'p', help: 'Password of the user.')
      ..addOption('role', abbr: 'r', help: 'Role of the user.')
      ..addOption('forename', abbr: 'f', help: 'Forename of the user.')
      ..addOption('surname', abbr: 's', help: 'Surname of the user.');
  }

  @override
  void run() async {
    User user = await UserManager().get(username: argResults!['username']);

    user
      ..password = argResults!['password'] ?? user.password
      ..forename = argResults!['forename'] ?? user.forename
      ..surname = argResults!['surname'] ?? user.surname;
  }
}
