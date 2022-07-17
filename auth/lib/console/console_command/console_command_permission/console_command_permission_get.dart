import 'package:args/command_runner.dart';
import 'package:auth/permission/permission_manager.dart';
import 'package:auth/user/user_manager.dart';

/// Get a specific 'Permission' object in the permission module.
class ConsoleCommandPermissionGet extends Command {
  @override
  final String name = 'get';

  @override
  final String description = 'Get all permissions of an user.';

  ConsoleCommandPermissionGet() {
    argParser.addOption('username', abbr: 'u', help: 'Username of the user.');
  }

  @override
  void run() async {
    String username = argResults!['username'];

    var user = await UserManager().get(username);
    var permissions = await PermissionManager().get(user);

    for (var permission in permissions) {
      print('${permission.value},');
    }
  }
}
