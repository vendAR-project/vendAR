import 'package:vendar/model/user.dart';
import 'package:vendar/model/model.dart';

class ProfileController {
  Future<User> getUser() async {
    String name = "Ege";
    String surname = "Ayan";
    String email = "egeayan2001@gmail.com";
    String password = "egeayan2001";
    await Future.delayed(const Duration(seconds: 1));
    return User(name: name, surname: surname, email: email, password: password);
  }

  Future<List<Model>> getModels() async {
    await Future.delayed(const Duration(seconds: 2));

    return const [
      Model(
          name: 'Barrel',
          imageUrl:
              'https://sjc1.vultrobjects.com/cucdn/gallery-16/art/dkcr-barrel.jpg'),
      Model(
          name: 'Duck',
          imageUrl:
              'https://www.romeduckstore.it/wp-content/uploads/2020/05/paperella-di-gomma-gialla-classica.png'),
      Model(
          name: 'Table',
          imageUrl:
              'https://images.thdstatic.com/productImages/cfc2ff4b-f4bc-527e-88ec-d11edbd1dd79/svn/oak-homesullivan-kitchen-dining-tables-40531-60ak-tbl-64_600.jpg'),
    ];
  }

  Future<Map<String, dynamic>> getUserAndModels() async {
    final User user = await getUser();
    final List<Model> models = await getModels();
    return {'user': user, 'models': models};
  }

  Future<void> changePassword() async {}
  Future<void> chaneEmail() async {}
}
