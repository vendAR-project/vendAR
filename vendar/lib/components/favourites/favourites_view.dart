import 'package:flutter/material.dart';
import 'favourites_controller.dart';
import 'package:vendar/model/product.dart';
import 'package:vendar/components/product-detail/product_detail_view.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  FavouritesViewState createState() => FavouritesViewState();
}

class FavouritesViewState extends State<FavouritesView> {
  final FavouritesController _controller = FavouritesController();
  List<Product> favourites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  void loadFavourites() async {
    var fetchedFavourites = await _controller.fetchFavourites();
    setState(() {
      favourites = fetchedFavourites;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                childAspectRatio: 0.8, // Aspect ratio of each item
                crossAxisSpacing: 10, // Horizontal space between items
                mainAxisSpacing: 10, // Vertical space between items
              ),
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                Product product = favourites[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailView(product: product),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
