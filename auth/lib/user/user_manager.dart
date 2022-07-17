import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_in_use.dart';
import 'package:auth/exceptions/exception_not_found.dart';
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
    var storage = await Hive.openBox<User>('users');
    var validCharacters = RegExp(r'^[\w.]+$');

    if (!validCharacters.hasMatch(user.username)) {
      throw ExceptionBadRequest();
    }

    try {
      await get(user.username);
      throw ExceptionConflict();
    } on ExceptionConflict {
      throw ExceptionConflict();
    } on ExceptionNotFound {
      // Ignored: Desired outcome.
    } catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
    }

    storage.add(user);
  }

  /// Retrieve all exisiting 'User' objects.
  Future<Iterable<User>> all() async {
    var storage = await Hive.openBox<User>('users');

    return storage.values;
  }

  /// Get a specific 'User' object based on username.
  Future<User> get(String username) async {
    var storage = await Hive.openBox<User>('users');
    var user = storage.values.where((user) => user.username == username);

    try {
      return user.single;
    } catch (exception) {
      throw ExceptionNotFound();
    }
  }

  /// Check username and password combination.
  Future<User> login(String username, String password) async {
    var user = await get(username);

    if (user.password != password) {
      throw ExceptionForbidden();
    }

    return user;
  }
}
