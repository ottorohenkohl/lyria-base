import 'package:hive/hive.dart';

part 'session.g.dart';

/// 'Session' DTO for storing session information.
@HiveType(typeId: 3)
class Session extends HiveObject {
  @HiveField(0)
  final String cookie;

  @HiveField(1)
  final dynamic entity;

  @HiveField(2)
  DateTime? validity;

  Session({required this.cookie, required this.entity});
}
