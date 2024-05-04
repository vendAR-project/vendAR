import 'package:dio/dio.dart';
import 'package:vendar/constants.dart';
import 'package:vendar/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesController {
  Dio dio = Dio();

  Future<List<Product>> fetchFavourites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');
    String url =
        '${Constants.baseUrl}${Constants.getFavouriteProductsEndpoint}';

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
}
