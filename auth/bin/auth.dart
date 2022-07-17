import 'package:auth/config/config/config.dart';
import 'package:auth/console/console_manager.dart';
import 'package:auth/environment/environment_manager.dart';
import 'package:auth/permission/permission/permission.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:hive/hive.dart';

/// Entrypoint of the lyria-auth application.
void main(List<String> arguments) async {
  Hive.init('./data');

  Hive.registerAdapter(ConfigAdapter());
  Hive.registerAdapter(PermissionAdapter());
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserRoleAdapter());

  await EnvironmentManager().loadConfig();
  await EnvironmentManager().loadUser();

  ConsoleManager().handle(arguments);
}
