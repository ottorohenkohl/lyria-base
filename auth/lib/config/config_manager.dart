import 'package:auth/config/config/config.dart';
import 'package:auth/console/console_manager.dart';
import 'package:hive/hive.dart';

/// For managing any persistend configuration.
class ConfigManager {
  ConfigManager();

  /// Get a current 'Config' object.
  Future<Config> get() async {
    Box<Config> storage = await Hive.openBox<Config>('config');

    if (storage.get('config') == null) {
      await reset();
    }

    return storage.get('config')!;
  }

  /// Reset the current 'Config' object on disk.
  Future<void> reset() async {
    ConsoleManager().log('Reseting configuration.', 'info');

    Box<Config> storage = await Hive.openBox<Config>('config');
    Config config = await standard();

    storage.put('config', config);
  }

  /// Return the standard 'Config' object.
  Future<Config> standard() async {
    Config config = Config(
      apiHost: 'localhost',
      apiPort: 80,
      apiPath: '',
      sessionDuration: 30,
    );

    return config;
  }
}
