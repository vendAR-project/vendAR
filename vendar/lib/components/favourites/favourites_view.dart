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

  Future<void> loadFavourites() async {
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
        automaticallyImplyLeading: false,
        title: const Text(
          'Favourites',
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadFavourites,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  childAspectRatio: 0.75, // Aspect ratio of each item
                  crossAxisSpacing: 10, // Horizontal space between items
                  mainAxisSpacing: 10, // Vertical space between items
                ),
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  Product product = favourites[index];
                  return buildProductCard(product);
                },
              ),
            ),
    );
  }

  Widget buildProductCard(Product product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners for the card
      ),
      elevation: 5, // Shadow effect
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailView(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  product.imageUrls[0],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
