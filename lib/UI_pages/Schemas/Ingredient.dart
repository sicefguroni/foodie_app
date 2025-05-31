class Ingredient {
  final int id;
  final String name;
  final String unit;
  final String category;
  int quantity;
  final String? imageUrl;

  Ingredient({
              required this.id,
              required this.name, 
              required this.unit,
              required this.category,
              required this.quantity,
              this.imageUrl});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      category: json['category'] ?? '',
      quantity: json['quantity'] ?? '',
      imageUrl: json['image_url'] ?? '', // Adjust field names based on your Supabase table
    );
  }
}