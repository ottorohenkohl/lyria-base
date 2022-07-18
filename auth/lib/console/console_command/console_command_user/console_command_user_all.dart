import 'package:args/command_runner.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_manager.dart';

/// Retrieve all 'User' objects existend in the user module.
class ConsoleCommandUserAll extends Command {
  @override
  final String name = 'all';

  @override
  final String description = 'Retrieve all users.';

  ConsoleCommandUserAll();

  @override
  void run() async {
    List<Map<String, String>> users = [];
    for (User user in (await UserManager().all())) {
      users.add({
        'username': user.username,
        'forename': user.forename ?? '',
        'surname': user.surname ?? '',
        'role': user.role.toString().split('.').last,
      });
    }
    print(users.toString());
  }
}
