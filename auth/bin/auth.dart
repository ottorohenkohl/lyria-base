import 'package:auth/config/config/config.dart';
import 'package:auth/console/console_manager.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/user/user/user.dart';
import 'package:auth/user/user_role/user_role.dart';
import 'package:hive/hive.dart';

void main(List<String> arguments) {
  Hive.init('./data');

  Hive.registerAdapter(ConfigAdapter());
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserRoleAdapter());

  ConsoleManager().handle(arguments);
}
