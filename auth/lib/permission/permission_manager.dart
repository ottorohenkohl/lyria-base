import 'package:auth/permission/permission/permission.dart';
import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';

class PermissionManager {
  PermissionManager();

  Future<void> add(Permission permission) async {
    Box<Permission> storage = await Hive.openBox<Permission>('permissions');

    for (Permission element in storage.values) {
      if (permission.value == element.value &&
          permission.user.uuid == element.user.uuid) {
        return;
      }
    }

    await storage.add(permission);
  }

  Future<Iterable<Permission>> get(User user) async {
    Box<Permission> storage = await Hive.openBox<Permission>('permissions');
    return storage.values.where(
      (permission) => permission.user.username == user.username,
    );
  }

  Future<bool> isAllowed(User user, String value) async {
    Iterable<Permission> permissions = await get(user);

    return permissions
        .where((permission) => permission.value == value)
        .isNotEmpty;
  }
}
