import 'package:vendar/model/user.dart';

class ProfileController {
  Future<User> getUser() async {
    String name = "Ege";
    String surname = "Ayan";
    String email = "egeayan2001@gmail.com";
    String password = "egeayan2001";
    await Future.delayed(const Duration(seconds: 1));
    return User(name: name, surname: surname, email: email, password: password);
  }

  Future<void> changePassword() async {}
  Future<void> chaneEmail() async {}
}
