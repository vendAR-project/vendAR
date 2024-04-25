import 'package:vendar/model/user.dart';
import 'package:vendar/model/product.dart';
import 'package:dio/dio.dart';
import 'package:vendar/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController {
  Dio dio = Dio();

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');

    print(userToken);
    final String url = "${Constants.baseUrl}${Constants.getUserEndpoint}";

    try {
      Response response = await dio.get(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      print(response);
      return User(
        name: response.data['user_name'],
        surname: response.data['user_surname'],
        email: response.data['user_email'],
        password: response.data[
            'user_password'], // Consider security implications of sending password over API
      );
    } catch (e) {
      print('Error occurred: $e');
      throw Exception("Failed to load user data: $e");
    }
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
