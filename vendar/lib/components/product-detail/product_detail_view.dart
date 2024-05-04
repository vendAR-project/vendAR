import 'package:flutter/material.dart';
import 'package:vendar/model/product.dart';
import 'package:vendar/components/ar-display/ar_display_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  bool isFavorite = false; // Track favorite state
  PageController _pageController = PageController(); // Controller for PageView

  @override
  void dispose() {
    _pageController.dispose(); // Dispose controller when not in use
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => setState(() => isFavorite = !isFavorite),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Use PageView to swipe through images
            Container(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.product.imageUrls.length,
                itemBuilder: (context, index) => Hero(
                  tag:
                      '${widget.product.id}_$index', // Unique tag for each image
                  child: ClipRRect(
                    child: Image.network(
                      widget.product.imageUrls[index],
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 50.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ObjectsOnPlanesWidget(
                                  url: widget.product.url)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('View Model Here'),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(widget.product.marketLink);
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Order Model Here'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
