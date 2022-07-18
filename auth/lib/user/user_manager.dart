import 'package:auth/exceptions/exception_auth.dart';
import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';

/// For user management.
///
/// Modifying and deleting 'User' objects can be done through
/// the specific 'save()' and 'delete()' methods provided by the
/// 'HiveObject' super class.
class UserManager {
  UserManager();

  /// Add a new 'User' object.
  Future<void> add(User user) async {
    Box<User> storage = await Hive.openBox<User>('users');
    RegExp validCharacters = RegExp(r'^[\w.]+$');

    if (!validCharacters.hasMatch(user.username)) {
      throw ExceptionAuth.badRequest();
    }

    try {
      await get(username: user.username);
      throw ExceptionAuth.conflict();
    } catch (exception) {
      if (exception is ExceptionAuth && exception.status == 404) {
        // IGNORED: Desired outcome.
      } else {
        rethrow;
      }
    }

    await storage.add(user);
  }

  /// Retrieve all exisiting 'User' objects.
  Future<Iterable<User>> all() async {
    Box<User> storage = await Hive.openBox<User>('users');

    return storage.values;
  }

  /// Get a specific 'User' object based on username.
  Future<User> get({String? username, String? uuid}) async {
    Box<User> storage = await Hive.openBox<User>('users');

    for (User element in storage.values) {
      if (element.username == username || element.uuid == uuid) {
        return element;
      }
    }

    throw ExceptionAuth.notFound();
  }

  /// Check username and password combination.
  Future<User> login(String username, String password) async {
    User user = await get(username: username);

    if (user.password == password) {
      return user;
    }

    throw ExceptionAuth.forbidden();
  }
}
