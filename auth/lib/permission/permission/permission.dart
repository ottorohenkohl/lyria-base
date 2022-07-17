import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';

part 'permission.g.dart';

@HiveType(typeId: 5)
class Permission extends HiveObject {
  @HiveField(0)
  final User user;

  @HiveField(1)
  final String value;

  Permission({required this.user, required this.value});
}
