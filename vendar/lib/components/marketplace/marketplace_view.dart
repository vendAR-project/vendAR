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
  List<String> selectedCategories = [];

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
      return (selectedCategories.isEmpty ||
              selectedCategories.contains(product.category)) &&
          product.name
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
                categoryChip('Fashion'),
                categoryChip('Electronics'),
                categoryChip('Books'),
                categoryChip('Home'),
                categoryChip('Other'),
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
                        return productCard(product);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget productCard(Product product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailView(product: product),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  product.imageUrls[0],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.category,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryChip(String category) {
    bool isSelected = selectedCategories.contains(category);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        backgroundColor: Colors.grey[300],
        selectedColor: Colors.blue,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              selectedCategories.add(category);
            } else {
              selectedCategories.remove(category);
            }
            filterProducts(); // Re-filter the products based on the new category selection
          });
        },
      ),
    );
  }
}
