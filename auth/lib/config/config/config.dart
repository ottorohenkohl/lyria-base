import 'package:hive/hive.dart';

part 'config.g.dart';

/// 'Config' DTO for storing configuration values.
@HiveType(typeId: 2)
class Config extends HiveObject {
  @HiveField(0)
  String apiHost;

  @HiveField(1)
  String apiPath;

  @HiveField(2)
  int apiPort;

  @HiveField(3)
  int sessionDuration;

  Config({
    required this.apiHost,
    required this.apiPort,
    required this.apiPath,
    required this.sessionDuration,
  });
}
