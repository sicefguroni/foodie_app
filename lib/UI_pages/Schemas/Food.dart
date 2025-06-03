class Food {
  final int id;
  final String product_name;
  final double price;
  int quantity;
  final String category;
  final String description;
  final String? imageUrl;
  bool availability;

  Food({
    required this.id,
    required this.product_name,
    required this.price,
    required this.quantity,
    required this.category,
    required this.description,
    this.imageUrl,
    required this.availability,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] ?? '',
      product_name: json['product_name'] ?? '',
      price: json['price'] ?? '',
      quantity: json['quantity'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      availability: json['availability'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}