import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:auth/console/console_command/console_command_lyria/console_command_lyria_reset.dart';
import 'package:auth/console/console_command/console_command_lyria/console_command_lyria_start.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_add.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_all.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_delete.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_edit.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_get.dart';

/// Main Interface to interact with the 'console' module.
class ConsoleManager {
  ConsoleManager();

  // Module content.
  String get(dynamic message) {
    stdout.write('$message \$ ');
    return stdin.readLineSync()!;
  }

  void handle(Iterable<String> arguments) {
    CommandRunner('lyria-base', 'CLI of the auth application.')
      ..addCommand(CommandUser())
      ..addCommand(CommandAuth())
      ..run(arguments);
  }

  void log(dynamic message, String type) {
    var datetime = DateTime.now();
    var info = '[${type.toUpperCase()}]';
    print('$datetime $info  $message');
  }
}

/// Main handler for all 'user' commands.
class CommandUser extends Command {
  @override
  final String name = 'user';

  @override
  final String description = 'Manage the "user" module.';

  CommandUser() {
    addSubcommand(ConsoleCommandUserAdd());
    addSubcommand(ConsoleCommandUserAll());
    addSubcommand(ConsoleCommandUserDelete());
    addSubcommand(ConsoleCommandUserEdit());
    addSubcommand(ConsoleCommandUserGet());
  }
}

/// Main handler for all 'lyria' commands.
class CommandAuth extends Command {
  @override
  final String name = 'auth';

  @override
  final String description = 'Manage the auth application.';

  CommandAuth() {
    addSubcommand(ConsoleCommandLyriaStart());
    addSubcommand(ConsoleCommandAuthReset());
  }
}

/// Main handler for all 'config' commands.
class CommandConfig extends Command {
  @override
  final String name = 'config';

  @override
  final String description = 'Manage the config application.';

  CommandConfig() {
    addSubcommand(ConsoleCommandLyriaStart());
    addSubcommand(ConsoleCommandAuthReset());
  }
}
