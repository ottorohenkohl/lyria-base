import 'package:auth/config/config_manager.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/session/session/session.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

/// For managing all tasks related to sessions.
class SessionManager {
  SessionManager();

  /// Create a new 'Session' object with specified entity.
  /// The entity must have a 'EntityAdapter' to be stored via Hive.
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

  /// Search for an existing 'Session' object.
  Future<Session> search(String cookie) async {
    var storage = await Hive.openBox<Session>('sessions');
    var session = storage.values.where((session) => session.cookie == cookie);

    try {
      return session.single;
    } catch (e) {
      throw ExceptionNotFound();
    }
  }

  /// Check whether a session is still valid.
  bool isValid(Session session) {
    var validity = session.validity;

    if (validity != null && validity.isAfter(DateTime.now())) {
      return true;
    }

    session.delete();

    return false;
  }
}
