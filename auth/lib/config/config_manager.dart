import 'package:auth/config/config/config.dart';
import 'package:hive/hive.dart';

class ConfigManager {
  ConfigManager();

  Future<Config> get() async {
    var storage = await Hive.openBox<Config>('config');
    var config = storage.get('config');

    return config ?? await standard();
  }

  Future<void> reset() async {
    var storage = await Hive.openBox<Config>('config');
    var config = await standard();

    storage.put('config', config);
  }

  Future<Config> standard() async {
    var config = Config(
        apiHost: 'localhost',
        apiPort: 8080,
        apiPath: '/',
        sessionDuration: 30,
        sessionKeeping: false);

    return config;
  }
}
