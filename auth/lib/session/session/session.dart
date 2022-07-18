import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'session.g.dart';

/// 'Session' DTO for storing session information.
@HiveType(typeId: 3)
class Session extends HiveObject {
  @HiveField(0)
  final String cookie;

  @HiveField(1)
  final User user;

  @HiveField(2)
  final DateTime created;

  Session({required this.user})
      : cookie = Uuid().v4(),
        created = DateTime.now();
}
