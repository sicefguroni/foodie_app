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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ingredient && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class IngredientWithQuantity {
  final Ingredient ingredient;
  int quantity;

  IngredientWithQuantity({required this.ingredient, required this.quantity});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IngredientWithQuantity && 
           other.ingredient == ingredient && 
           other.quantity == quantity;
  }

  @override
  int get hashCode => Object.hash(ingredient, quantity);
}