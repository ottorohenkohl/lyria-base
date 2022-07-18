import 'package:args/command_runner.dart';
import 'package:auth/permission/permission/permission.dart';
import 'package:auth/permission/permission_manager.dart';
import 'package:auth/user/user/user.dart';
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

    User user = await UserManager().get(username: username);
    Iterable<Permission> permissions = await PermissionManager().get(user);

    for (Permission element in permissions) {
      print('${element.value},');
    }
  }
}
