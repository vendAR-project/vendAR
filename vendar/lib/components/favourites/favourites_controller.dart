import "package:vendar/model/product.dart";

class FavouritesController {
  Future<List<Product>> fetchFavourites() async {
    // await Future.delayed(const Duration(seconds: 2));
    return List.generate(
        6,
        (index) => Product(
              id: 'id_$index',
              name: 'Item $index',
              imageUrl:
                  'https://www.iconpacks.net/icons/2/free-favourite-icon-2765-thumb.png',
              price: 20.99 + index * 5,
              description: 'Description for Item $index',
            ));
  }
}
