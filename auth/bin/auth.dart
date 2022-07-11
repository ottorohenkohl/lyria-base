import 'package:auth/console/console_manager.dart';
import 'package:hive/hive.dart';

void main(List<String> arguments) {
  Hive.init('./data');

  ConsoleManager().handle(arguments);
}
