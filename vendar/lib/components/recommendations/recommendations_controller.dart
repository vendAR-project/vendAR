import "package:vendar/model/product.dart";

class RecommendedController {
  Future<List<Product>> fetchRecommended() async {
    // await Future.delayed(const Duration(seconds: 2));
    return List.generate(
        8,
        (index) => Product(
              id: 'id_$index',
              name: 'Product $index',
              imageUrl:
                  'https://w7.pngwing.com/pngs/884/204/png-transparent-stamp-corpulent-popularity-recognition-applause-fame-preference-recommendation-praise-name-thumbnail.png', // Placeholder image URL
              price: 10.0 * index,
              description: 'Description for Product $index',
            ));
  }
}
