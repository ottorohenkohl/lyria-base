import 'package:args/command_runner.dart';
import 'package:auth/permission/permission/permission.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';

/// Delete an existing 'Permission' object in the permission module.
class ConsoleCommandPermissionDelete extends Command {
  @override
  final String name = 'delete';

  @override
  final String description = 'Delete an existing permission.';

  ConsoleCommandPermissionDelete() {
    argParser
      ..addOption('username', abbr: 'u', help: 'Username of the user.')
      ..addOption('value', abbr: 'v', help: 'Value of the permission.');
  }

  @override
  void run() async {
    String username = argResults!['username'];
    String value = argResults!['value'];

    User user = await UserManager().get(username: username);
    Permission permission = Permission(user: user, value: value);

    await permission.delete();
  }
}
