import 'package:flutter/material.dart';

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
