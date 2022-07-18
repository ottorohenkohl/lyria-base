import 'package:auth/config/config/config.dart';
import 'package:auth/config/config_manager.dart';
import 'package:auth/exceptions/exception_auth.dart';
import 'package:auth/session/session/session.dart';
import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';

/// For managing all tasks related to sessions.
class SessionManager {
  SessionManager();

  /// Create a new 'Session' object with specified entity.
  /// The entity must have a 'EntityAdapter' to be stored via Hive.
  Future<Session> create(User user) async {
    Box<Session> storage = await Hive.openBox<Session>('sessions');
    Session session = Session(user: user);

    await storage.add(session);
    return session;
  }

  /// Search for an existing 'Session' object.
  Future<Session> check(String cookie) async {
    Box<Session> storage = await Hive.openBox<Session>('sessions');

    for (Session element in storage.values) {
      if (element.cookie == cookie && await isValid(element)) {
        return element;
      }
    }

    throw ExceptionAuth.forbidden();
  }

  /// Check whether a session is still valid.
  Future<bool> isValid(Session session) async {
    Config config = await ConfigManager().get();
    Duration duration = Duration(minutes: config.sessionDuration);

    return session.created.add(duration).isAfter(DateTime.now());
  }
}
