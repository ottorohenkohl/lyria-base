import 'package:auth/exceptions/exception_bad_request.dart';
import 'package:auth/exceptions/exception_forbidden.dart';
import 'package:auth/exceptions/exception_in_use.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';

class UserManager {
  UserManager();

  Future<void> add(User user) async {
    var storage = await Hive.openBox<User>('users');
    var validCharacters = RegExp(r'^[\w.]+$');

    if (!validCharacters.hasMatch(user.username)) {
      throw ExceptionBadRequest();
    }

    try {
      get(user.username);
      throw ExceptionInUse();
    } on ExceptionInUse {
      throw ExceptionInUse();
    } catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
    }

    storage.add(user);
  }

  Future<Iterable<User>> all() async {
    var storage = await Hive.openBox<User>('users');

    return storage.values;
  }

  Future<User> get(String username) async {
    var storage = await Hive.openBox<User>('users');
    var user = storage.values.where((user) => user.username == username);

    try {
      return user.single;
    } catch (exception) {
      throw ExceptionNotFound();
    }
  }

  Future<User> login(String username, String password) async {
    var user = await get(username);

    if (user.password != password) {
      throw ExceptionForbidden();
    }

    return user;
  }
}
