import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendar/constants.dart';
import 'package:vendar/model/product.dart';

class ProductDetailController {
  Dio dio = Dio();

  Future<bool> addToFavourites(String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');
    String url =
        '${Constants.baseUrl}${Constants.addFavouritesEndpoint}${productId}'; // Use constants

    try {
      final response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Add to favourites failed: Status code ${response.statusCode}');
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromFavourites(String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');
    String url =
        '${Constants.baseUrl}${Constants.removeFavouriteEndpoint}${productId}'; // Use constants

    try {
      final response = await dio.put(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Remove from favourites failed: Status code ${response.statusCode}');
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> isFavourite(String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');
    String url =
        '${Constants.baseUrl}${Constants.getFavouriteProductsEndpoint}';

    try {
      final response = await dio.get(url,
          options: Options(headers: {
            "Authorization": "Bearer $userToken",
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
        // Check if the productId exists in favouriteProducts
        return favouriteProducts.any((product) => product.id == productId);
      } else {
        print(
            'Failed to load favourite products: Status code ${response.statusCode}');
        return false; // If the response failed, assume not favourite
      }
    } catch (e) {
      print('Error fetching favourite products: $e');
      return false; // If there was an error, assume not favourite
    }
  }
}
