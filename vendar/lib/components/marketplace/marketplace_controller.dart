import 'package:vendar/model/product.dart';

class MarketplaceController {
  Future<List<Product>> fetchProducts() async {
    // await Future.delayed(const Duration(seconds: 2));
    return List.generate(
        20,
        (index) => Product(
              id: 'id_$index',
              name: 'Product $index',
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/274/274430.png',
              price: 20.99 + index,
              description: 'Description for Product $index',
            ));
  }
}
