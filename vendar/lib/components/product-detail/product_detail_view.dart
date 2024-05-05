import 'package:flutter/material.dart';
import 'package:vendar/model/product.dart';
import 'package:vendar/components/ar-display/ar_display_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'product_detail_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late bool isFavorite = false;
  final ProductDetailController _controller = ProductDetailController();

  @override
  void initState() {
    super.initState();
    _controller.isFavourite(widget.product.id).then((value) {
      setState(() {
        isFavorite = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Enhanced styling for the AppBar
        actions: [
          IconButton(
            onPressed: () {
              if (isFavorite) {
                _controller.removeFromFavourites(widget.product.id);
              } else {
                _controller.addToFavourites(widget.product.id);
              }
              setState(() {
                isFavorite = !isFavorite;
              });
            },
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
            const SizedBox(height: 20),
            CarouselSlider.builder(
              options: CarouselOptions(
                  height: 300,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 0.85,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: false),
              itemCount: widget.product.imageUrls.length,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8), // Rounded corners for images
                  child: Image.network(
                    widget.product.imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ObjectsOnPlanesWidget(url: widget.product.url),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('View Model Here'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri url =
                            Uri.parse('https://' + widget.product.marketLink);
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
                          borderRadius: BorderRadius.circular(10),
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
