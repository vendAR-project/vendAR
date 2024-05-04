import 'package:flutter/material.dart';
import 'package:vendar/model/product.dart';
import 'recommendations_controller.dart';
import 'package:vendar/components/product-detail/product_detail_view.dart';

class RecommendedView extends StatefulWidget {
  const RecommendedView({super.key});

  @override
  RecommendedViewState createState() => RecommendedViewState();
}

class RecommendedViewState extends State<RecommendedView> {
  final RecommendedController _controller = RecommendedController();
  List<Product> recommended = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRecommended();
  }

  Future<void> loadRecommended() async {
    var fetchedRecommended = await _controller.fetchRecommended();
    setState(() {
      recommended = fetchedRecommended;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadRecommended,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: recommended.length,
                itemBuilder: (context, index) {
                  Product product = recommended[index];
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
                              product.imageUrls[0],
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
            ),
    );
  }
}
