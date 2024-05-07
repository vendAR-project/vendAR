import 'package:flutter/material.dart';
import 'package:vendar/model/product.dart';
import 'package:vendar/components/product-detail/product_detail_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'recommendations_controller.dart';

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
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  initialPage: 0,
                  enableInfiniteScroll: true,
                ),
                itemCount: recommended.length,
                itemBuilder: (context, index, realIndex) {
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product.imageUrls[0],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height *
                                    0.4, // Adjust the height accordingly
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        product.description,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
