import 'package:auth/exceptions/exception_in_use.dart';
import 'package:auth/exceptions/exception_not_found.dart';
import 'package:auth/user/user/user.dart';
import 'package:hive/hive.dart';

class UserManager {
  UserManager();

  Future<Iterable<User>> all() async {
    var users = (await Hive.openBox<User>('users'));
    return users.values;
  }

  Future<User> add(User user) async {
    var users = (await Hive.openBox<User>('users'));

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

    users.add(user);
    return user;
  }

  Future<User> get(String username) async {
    var users = (await Hive.openBox<User>('users'));
    var user = users.values.where((user) => user.username == username);

    try {
      return user.single;
    } catch (e) {
      throw ExceptionNotFound();
    }
  }
}
