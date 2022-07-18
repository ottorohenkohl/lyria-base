import 'package:args/command_runner.dart';
import 'package:auth/console/console_command/console_command_config/console_command_config_get.dart';
import 'package:auth/console/console_command/console_command_config/console_command_config_reset.dart';
import 'package:auth/console/console_command/console_command_config/console_command_config_set.dart';
import 'package:auth/console/console_command/console_command_http/console_command_http_start.dart';
import 'package:auth/console/console_command/console_command_http/console_command_http_stop.dart';
import 'package:auth/console/console_command/console_command_permission/console_command_permission_add.dart';
import 'package:auth/console/console_command/console_command_permission/console_command_permission_delete.dart';
import 'package:auth/console/console_command/console_command_permission/console_command_permission_get.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_add.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_all.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_delete.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_edit.dart';
import 'package:auth/console/console_command/console_command_user/console_command_user_get.dart';

/// Subcommand for managing the config module.
class CommandConfig extends Command {
  @override
  final String name = 'config';

  @override
  final String description = 'Manage the configuration.';

  CommandConfig() {
    addSubcommand(ConsoleCommandConfigGet());
    addSubcommand(ConsoleCommandConfigReset());
    addSubcommand(ConsoleCommandConfigSet());
  }
}

/// Subcommand for managing the http module.
class CommandHttp extends Command {
  @override
  final String name = 'http';

  @override
  final String description = 'Manage the http module.';

  CommandHttp() {
    addSubcommand(ConsoleCommandHttpStart());
    addSubcommand(ConsoleCommandHttpStop());
  }
}

/// Subcommand for managing the permission module.
class CommandPermission extends Command {
  @override
  final String name = 'permission';

  @override
  final String description = 'Manage the permission module.';

  CommandPermission() {
    addSubcommand(ConsoleCommandPermissionAdd());
    addSubcommand(ConsoleCommandPermissionDelete());
    addSubcommand(ConsoleCommandPermissionGet());
  }
}

/// Subcommand for managing the user module.
class CommandUser extends Command {
  @override
  final String name = 'user';

  @override
  final String description = 'Manage the user module.';

  CommandUser() {
    addSubcommand(ConsoleCommandUserAdd());
    addSubcommand(ConsoleCommandUserAll());
    addSubcommand(ConsoleCommandUserDelete());
    addSubcommand(ConsoleCommandUserEdit());
    addSubcommand(ConsoleCommandUserGet());
  }
}
