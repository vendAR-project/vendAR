import 'package:dio/dio.dart';
import 'package:vendar/constants.dart';
import 'package:vendar/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedController {
  Dio dio = Dio();

  Future<List<Product>> fetchRecommended() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userToken = await prefs.getString('userToken');
    String url =
        '${Constants.baseUrl}${Constants.getRecommendedProductsEndpoint}';

    try {
      final response = await dio.get(url,
          options: Options(headers: {
            "Authorization": "Bearer ${userToken}",
          }));
      if (response.statusCode == 200) {
        List<Product> recommendedProducts = List<Product>.from(
          (response.data as List).map((productJson) {
            return Product(
              id: productJson['product_id'],
              name: productJson['product_title'],
              imageUrl: productJson['product_images'].isNotEmpty
                  ? productJson['product_images'][0]
                  : 'default_image_url', // Provide a default image URL
              price: double.parse(productJson['product_price'].toString()),
              description: productJson['product_desc'],
            );
          }),
        );
        return recommendedProducts;
      } else {
        throw Exception(
            'Failed to load recommended products: Status code ${response.statusCode}');
      }
    } catch (e) {
      // Enhanced logging for debugging
      print('Error fetching recommended products: $e');
      throw Exception('Failed to fetch recommended products: $e');
    }
  }
}
