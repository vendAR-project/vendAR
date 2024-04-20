import 'package:flutter/material.dart';

class FavouritesView extends StatelessWidget {
  FavouritesView({Key? key}) : super(key: key);

  // Example list of favourite items
  final List<Map<String, dynamic>> favourites = [
    {'name': 'Item 1', 'price': '20.99', 'imageUrl': 'path/to/image1.jpg'},
    {'name': 'Item 2', 'price': '15.49', 'imageUrl': 'path/to/image2.jpg'},
    {'name': 'Item 3', 'price': '25.00', 'imageUrl': 'path/to/image3.jpg'},
    {'name': 'Item 4', 'price': '30.99', 'imageUrl': 'path/to/image4.jpg'},
    {'name': 'Item 5', 'price': '12.99', 'imageUrl': 'path/to/image5.jpg'},
    {'name': 'Item 6', 'price': '50.00', 'imageUrl': 'path/to/image6.jpg'},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          childAspectRatio: 0.8, // Aspect ratio of each item
          crossAxisSpacing: 10, // Horizontal space between items
          mainAxisSpacing: 10, // Vertical space between items
        ),
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    favourites[index]['imageUrl'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    favourites[index]['name'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$${favourites[index]['price']}',
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
