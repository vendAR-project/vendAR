import 'package:dio/dio.dart';
import 'package:vendar/constants.dart';
import 'package:vendar/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketplaceController {
  Dio dio = Dio();

  Future<List<Product>> fetchProducts() async {
    String url = '${Constants.baseUrl}${Constants.getProductsEndpoint}';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');

    try {
      final response = await dio.get(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        List<Product> products = List<Product>.from(
          (response.data as List).map(
            (productJson) => Product(
              id: productJson['product_id'],
              name: productJson['product_title'],
              imageUrl: productJson['product_images'].isNotEmpty
                  ? productJson['product_images'][0]
                  : 'default_image_url',
              price: double.parse(productJson['product_price'].toString()),
              description: productJson['product_desc'],
            ),
          ),
        );
        return products;
      } else {
        throw Exception(
            'Failed to load products: Status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle possible network errors
      throw Exception('Failed to fetch products: $e');
    }
  }
}
