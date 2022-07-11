import 'package:auth/user/user_role/user_role.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final DateTime created;

  @HiveField(2)
  final UserRole role;

  @HiveField(3)
  String? password;

  @HiveField(4)
  String? forename;

  @HiveField(5)
  String? surname;

  @HiveField(6)
  String? address;

  User({required this.username, required this.password, required this.role})
      : created = DateTime.now();
}
