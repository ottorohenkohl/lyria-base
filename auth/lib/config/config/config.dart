import 'package:hive/hive.dart';

part 'config.g.dart';

@HiveType(typeId: 2)
class Config extends HiveObject {
  @HiveField(0)
  final String apiHost;

  @HiveField(1)
  final String apiPath;
  
  @HiveField(2)
  final int apiPort;

  @HiveField(3)
  final int sessionDuration;

  @HiveField(4)
  final bool sessionKeeping;

  Config(
      {required this.apiHost,
      required this.apiPort,
      required this.apiPath,
      required this.sessionDuration,
      required this.sessionKeeping});
}
