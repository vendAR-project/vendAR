import 'package:dio/dio.dart';
import 'package:vendar/constants.dart';
import 'package:vendar/model/product.dart';

class FavouritesController {
  Dio dio = Dio();

  Future<List<Product>> fetchFavourites() async {
    String url =
        '${Constants.baseUrl}${Constants.getFavouriteProductsEndpoint}';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List<Product> favouriteProducts = List<Product>.from(
          (response.data as List).map((productJson) {
            return Product(
              id: productJson['product_id'],
              name: productJson['product_title'],
              imageUrl: productJson['product_images'].isNotEmpty
                  ? productJson['product_images'][0]
                  : 'default_image_url',
              price: double.parse(productJson['product_price'].toString()),
              description: productJson['product_desc'],
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
