import 'package:auth/config/config_manager.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/session/session/session.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class SessionManager {
  SessionManager();

  Future<Session> create(dynamic entity) async {
    var storage = await Hive.openBox<Session>('sessions');
    var config = await ConfigManager().get();

    var cookie = Uuid().v4();
    var duration = Duration(minutes: config.sessionDuration);
    var session = Session(cookie: cookie, entity: entity)
      ..validity = DateTime.now().add(duration);

    storage.add(session);
    return session;
  }

  Future<Session> search(String cookie) async {
    var storage = await Hive.openBox<Session>('sessions');
    var session = storage.values.where((session) => session.cookie == cookie);

    try {
      return session.single;
    } catch (e) {
      throw ExceptionNotFound();
    }
  }

  bool isValid(Session session) {
    var validity = session.validity;

    if (validity != null && validity.isAfter(DateTime.now())) {
      return true;
    }

    return false;
  }
}
