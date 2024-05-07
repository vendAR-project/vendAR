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
          password: response.data['user_password'],
          phoneNumber: response.data['user_phone']
          // Consider security implications of sending password over API
          );
    } catch (e) {
      print('Error occurred: $e');
      throw Exception("Failed to load user data: $e");
    }
  }

  Future<List<Product>> getProducts() async {
    // await Future.delayed(const Duration(seconds: 2));

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');
    String? userId = await prefs.getString('userID');
    String url =
        '${Constants.baseUrl}${Constants.getUserProductsEndpoint}$userId';

    try {
      final response = await dio.get(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        List<Product> favouriteProducts = List<Product>.from(
          (response.data as List).map((productJson) {
            return Product(
              id: productJson['product_id'],
              name: productJson['product_title'],
              imageUrls: List<String>.from(productJson['product_images']),
              price: double.parse(productJson['product_price'].toString()),
              description: productJson['product_desc'],
              url: productJson['product_src'],
              marketLink: productJson['product_sales_page_url'],
              category: productJson['product_feature'],
            );
          }),
        );
        return favouriteProducts;
      } else {
        throw Exception(
            'Failed to load favourite products: Status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching favourite products: $e');
      throw Exception('Failed to fetch favourite products: $e');
    }
  }

  Future<Map<String, dynamic>> getUserAndModels() async {
    final User user = await getUser();
    final List<Product> models = await getProducts();
    return {'user': user, 'models': models};
  }

  Future<bool> changePassword(
      String newPassword, String currentPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');

    final String url =
        "${Constants.baseUrl}${Constants.changePasswordEndpoint}$newPassword";
    print(url);

    try {
      Response response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      print(response);
      return true;
    } catch (e) {
      print('Error occurred: $e');

      return false;
    }
  }

  Future<bool> changeEmail(String newEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');

    final String url =
        "${Constants.baseUrl}${Constants.changeEmailNumberEndpoint}$newEmail";
    print(url);

    try {
      Response response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      print(response);
      return true;
    } catch (e) {
      print('Error occurred: $e');

      return false;
    }
  }

  Future<bool> changePhoneNumber(String newPhoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');

    final String url =
        "${Constants.baseUrl}${Constants.changePhoneNumberEndpoint}$newPhoneNumber";
    print(url);

    try {
      Response response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      print(response);
      return true;
    } catch (e) {
      print('Error occurred: $e');

      return false;
    }
  }
}
