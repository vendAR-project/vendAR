import 'package:vendar/model/user.dart';
import 'package:vendar/model/product.dart';

class ProfileController {
  Future<User> getUser() async {
    String name = "Ege";
    String surname = "Ayan";
    String email = "egeayan2001@gmail.com";
    String password = "egeayan2001";
    // await Future.delayed(const Duration(seconds: 1));
    return User(name: name, surname: surname, email: email, password: password);
  }

  Future<List<Product>> getProducts() async {
    // await Future.delayed(const Duration(seconds: 2));

    return const [
      Product(
        id: 'product_1',
        name: 'Barrel',
        imageUrl:
            'https://sjc1.vultrobjects.com/cucdn/gallery-16/art/dkcr-barrel.jpg',
        price: 29.99,
        description: 'A sturdy and stylish barrel for storage or decoration.',
      ),
      Product(
        id: 'product_2',
        name: 'Duck',
        imageUrl:
            'https://www.romeduckstore.it/wp-content/uploads/2020/05/paperella-di-gomma-gialla-classica.png',
        price: 5.99,
        description: 'A classic yellow rubber duck for bath time fun.',
      ),
      Product(
        id: 'product_3',
        name: 'Table',
        imageUrl:
            'https://images.thdstatic.com/productImages/cfc2ff4b-f4bc-527e-88ec-d11edbd1dd79/svn/oak-homesullivan-kitchen-dining-tables-40531-60ak-tbl-64_600.jpg',
        price: 199.99,
        description:
            'A sturdy and functional oak table for your kitchen or dining room.',
      ),
    ];
  }

  Future<Map<String, dynamic>> getUserAndModels() async {
    final User user = await getUser();
    final List<Product> models = await getProducts();
    return {'user': user, 'models': models};
  }

  Future<void> changePassword() async {}
  Future<void> chaneEmail() async {}
}
