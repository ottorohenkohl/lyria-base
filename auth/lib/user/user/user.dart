import 'package:auth/user/user_role/user_role.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final DateTime created;

  @HiveField(3)
  final UserRole role;

  @HiveField(4)
  String password;

  @HiveField(5)
  String? forename;

  @HiveField(6)
  String? surname;

  @HiveField(7)
  String? address;

  User({required this.username, required this.password, required this.role})
      : created = DateTime.now(),
        uuid = Uuid().v4();
}
