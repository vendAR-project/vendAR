import 'package:flutter/material.dart';

class MarketplaceView extends StatelessWidget {
  const MarketplaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Container(
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
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text('Item ${index + 1}'),
                  subtitle: Text('Details for Item ${index + 1}'),
                  onTap: () {},
                );
              },
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
