import 'package:auth/permission/permission/permission.dart';
import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';

class PermissionManager {
  PermissionManager();

  Future<void> add(Permission permission) async {
    var storage = await Hive.openBox<Permission>('permissions');
    storage.add(permission);
  }

  Future<Iterable<Permission>> get(User user) async {
    var storage = await Hive.openBox<Permission>('permissions');
    return storage.values.where((permission) => permission.user == user);
  }

  Future<bool> isAllowed(User user, String value) async {
    var permissions = await get(user);

    return permissions
        .where((permission) => permission.value == value)
        .isNotEmpty;
  }
}
