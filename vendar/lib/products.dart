import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'item_view.dart';



class ProductsPage extends StatelessWidget {
   ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      Product(
        name: 'Table',
        imageUrl: 'assets/images/Table.png', // Local asset for demonstration
        price: 35.00,
        description: 'A sturdy table made of oak wood.',
        arUrl: 'https://github.com/vendAR-project/vendAR/raw/main/vendar/models/Table/Table.glb',
      ),
      Product(
        name: 'Barrel',
        imageUrl: 'assets/images/Barrel.png', // Local asset for demonstration
        price: 17.00,
        description: 'A wooden barrel that can hold stuff.',
        arUrl: 'https://github.com/vendAR-project/vendAR/raw/main/vendar/models/Barrel/Barrel.glb',
      ),
      Product(
        name: 'Plastic Duck',
        imageUrl: 'assets/images/Duck.png', // Local asset for demonstration
        price: 5.00,
        description: 'A yellow plastic duck to use in your bathtub.',
        arUrl: 'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb',
      ),
      // Add more products here
    ];

    final examples = products.map((product) {
      return Example(
        product.name,
        'View Model',
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailView(product: product),
          ),
        ),
      );
    }).toList();

    return ListView(
      children: examples.map((example) => ExampleCard(example: example)).toList(),
    );
  }
}

class ExampleCard extends StatelessWidget {
  final Example example;

  ExampleCard({Key? key, required this.example}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () => example.onTap(),
        child: ListTile(
          title: Text(example.name),
          subtitle: Text(example.description),
        ),
      ),
    );
  }
}

class Example {
  final String name;
  final String description;
  final VoidCallback onTap;

  Example(this.name, this.description, this.onTap);
}
