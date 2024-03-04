import 'package:flutter/material.dart';
import 'ar_view.dart'; // Ensure you import the AR view widget

class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final String arUrl;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.arUrl,
  });
}

class ProductDetailView extends StatelessWidget {
  final Product product;
  ProductDetailView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Model model = Model(arUrl: product.arUrl, name: product.name);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // TODO: Handle favorite
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Handle more options
            },
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(product.imageUrl, fit: BoxFit.cover), // Adjusted for a better image fit
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16.0, height: 1.5),
                  ),
                  SizedBox(height: 24.0),
                  // Adding buttons for Select type
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Select your type',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 8.0,
                              children: [
                                ChoiceChip(label: Text('Wooden'), selected: true),
                                ChoiceChip(label: Text('Furniture'), selected: false),
                                ChoiceChip(label: Text('Medium'), selected: false),
                                ChoiceChip(label: Text('Hard'), selected: false),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch the buttons to full width in the column
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ObjectsOnPlanesWidget(model: model),
                              ),
                            );
                          },
                          child: Text('VIEW MODEL', style: TextStyle(fontSize: 18.0, color: Colors.white)), // Set text color here
                          style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Less rounded corners
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0), // Space between the buttons
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Handle ORDER HERE press
                          },
                          child: Text('ORDER HERE', style: TextStyle(fontSize: 18.0, color: Colors.white)), // Set text color here
                          style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Less rounded corners
                            ),
                          ),
                        ),
                      ),
                    ],
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
