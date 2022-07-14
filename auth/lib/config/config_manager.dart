import 'package:auth/config/config/config.dart';
import 'package:hive/hive.dart';

class ConfigManager {
  ConfigManager();

  Future<Config> get() async {
    var storage = await Hive.openBox<Config>('config');
    var config = storage.get('config');

    if (config == null) {
      config = await standard();
      storage.put('config', config);
    }
    return config;
  }

  Future<void> reset() async {
    var storage = await Hive.openBox<Config>('config');
    var config = await standard();

    storage.put('config', config);
  }

  Future<Config> standard() async {
    var config = Config(
        apiHost: 'localhost',
        apiPort: 80,
        apiPath: '/',
        sessionDuration: 30,
        sessionKeeping: false);

    return config;
  }
}
