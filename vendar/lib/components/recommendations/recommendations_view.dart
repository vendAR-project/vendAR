import 'package:flutter/material.dart';

class RecommendedView extends StatelessWidget {
  const RecommendedView({Key? key}) : super(key: key);

  // Example list of recommended items
  final List<Map<String, dynamic>> recommended = const [
    {'name': 'Product 1', 'price': '29.99', 'imageUrl': 'path/to/image1.jpg'},
    {'name': 'Product 2', 'price': '19.99', 'imageUrl': 'path/to/image2.jpg'},
    {'name': 'Product 3', 'price': '39.99', 'imageUrl': 'path/to/image3.jpg'},
    {'name': 'Product 4', 'price': '49.99', 'imageUrl': 'path/to/image4.jpg'},
    {'name': 'Product 5', 'price': '9.99', 'imageUrl': 'path/to/image5.jpg'},
    {'name': 'Product 6', 'price': '59.99', 'imageUrl': 'path/to/image6.jpg'},
    {'name': 'Product 7', 'price': '15.99', 'imageUrl': 'path/to/image7.jpg'},
    {'name': 'Product 8', 'price': '25.99', 'imageUrl': 'path/to/image8.jpg'},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Three items per row
          childAspectRatio: 0.8, // Aspect ratio of each item
          crossAxisSpacing: 10, // Horizontal space between items
          mainAxisSpacing: 10, // Vertical space between items
        ),
        itemCount: recommended.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    recommended[index]['imageUrl'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    recommended[index]['name'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$${recommended[index]['price']}',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
