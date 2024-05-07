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
        print(response.data);
        List<Product> products = List<Product>.from(
          (response.data as List).map(
            (productJson) => Product(
              id: productJson['product_id'],
              name: productJson['product_title'],
              imageUrls: List<String>.from(productJson['product_images']),
              price: double.parse(productJson['product_price'].toString()),
              description: productJson['product_desc'],
              url: productJson['product_src'],
              marketLink: productJson['product_sales_page_url'],
              category: productJson['product_feature'],
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
