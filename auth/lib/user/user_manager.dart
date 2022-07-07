import 'package:auth/exceptions/exception_in_use.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';

class UserManager {
  UserManager();

  Future<void> add(User user) async {
    var storage = await Hive.openBox<User>('users');

    try {
      get(user.username);
      throw ExceptionInUse();
    } on ExceptionInUse {
      throw ExceptionInUse();
    } catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
    }

    var validCharacters = RegExp(r'^[\w.]+$');
    if (!validCharacters.hasMatch(user.username)) {
      throw FormatException();
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
    } catch (e) {
      throw ExceptionNotFound();
    }
  }
}
