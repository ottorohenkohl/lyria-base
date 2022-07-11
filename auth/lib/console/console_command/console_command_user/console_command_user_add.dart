import 'package:args/command_runner.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';
import 'package:auth/user/user_role/user_role.dart';

/// Command for adding a new user.
class ConsoleCommandUserAdd extends Command {
  @override
  final String name = 'add';

  @override
  final String description = 'Add a new user.';

  ConsoleCommandUserAdd() {
    argParser
      ..addOption('username', abbr: 'u', help: 'Username of the user.')
      ..addOption('password', abbr: 'p', help: 'Password of the user.')
      ..addOption('role', abbr: 'r', help: 'Role of the user.')
      ..addOption('forename', abbr: 'f', help: 'Forename of the user.')
      ..addOption('surname', abbr: 's', help: 'Surnamename of the user.');
  }

  @override
  void run() {
    if (argResults!['role'] != 'admin' && argResults!['role'] != 'user') {
      throw FormatException();
    }

    String username = argResults!['username'];
    String password = argResults!['password'];
    String role = argResults!['role'];

    var userRole = UserRole.user;
    if (role == 'admin') {
      userRole = UserRole.admin;
    }

    var user = User(username: username, password: password, role: userRole)
      ..forename = argResults!['forname']
      ..surname = argResults!['surname'];

    UserManager().add(user);
  }
}
