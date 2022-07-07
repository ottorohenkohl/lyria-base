import 'package:auth/config/config/config.dart';
import 'package:hive/hive.dart';

class ConfigManager {
  ConfigManager();

  Future<Config> load() async {
    var config = (await Hive.openBox('config')).get('config');
    return config ?? standard();
  }

  Future<Config> standard() async {
    var config = Config(
        apiHost: 'localhost',
        apiPort: 8080,
        apiPath: '/',
        sessionDuration: 30,
        sessionKeeping: true);

    return config;
  }

  Future<void> reset() async {
    var config = standard();
    (await Hive.openBox('config')).put('config', config);
  }
}
