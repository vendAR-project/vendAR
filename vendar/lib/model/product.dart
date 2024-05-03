class Product {
  final String id;
  final String name;
  final List<String> imageUrls;
  final double price;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrls,
    required this.price,
    required this.description,
  });
}
