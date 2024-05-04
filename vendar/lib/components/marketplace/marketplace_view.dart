import 'package:flutter/material.dart';
import 'marketplace_controller.dart';
import 'package:vendar/model/product.dart';
import 'package:vendar/components/product-detail/product_detail_view.dart';

class MarketplaceView extends StatefulWidget {
  const MarketplaceView({super.key});

  @override
  MarketplaceViewState createState() => MarketplaceViewState();
}

class MarketplaceViewState extends State<MarketplaceView> {
  final MarketplaceController _controller = MarketplaceController();
  List<Product> products = [];
  List<Product> displayedProducts = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    filterProducts();
  }

  void filterProducts() {
    List<Product> filteredProducts = products.where((product) {
      return product.name
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
    }).toList();

    setState(() {
      displayedProducts = filteredProducts;
    });
  }

  Future<void> loadProducts() async {
    var fetchedProducts = await _controller.fetchProducts();
    setState(() {
      products = fetchedProducts;
      displayedProducts = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                categoryChip('Electronics'),
                categoryChip('Books'),
                categoryChip('Clothing'),
                categoryChip('Home'),
                categoryChip('Furniture'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: loadProducts,
                    child: ListView.builder(
                      itemCount: displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = displayedProducts[index];
                        return ListTile(
                          leading: Image.network(product.imageUrls[0],
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(product.name),
                          subtitle:
                              Text('\$${product.price.toStringAsFixed(2)}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailView(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget categoryChip(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(category),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
