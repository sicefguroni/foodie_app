class OrderModel {
  final int id;
  final String customerName;
  String status;
  final double totalAmount;
  final String? customerImageUrl;
  final String? productImageUrl;
  final List<OrderItem> orderedItems;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.status,
    required this.totalAmount,
    required this.orderedItems,
    this.customerImageUrl,
    this.productImageUrl,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final customer = json['customers'] ?? {};
    final List orderedItemsRaw = json['order_items'] ?? [];

    final List<OrderItem> items = orderedItemsRaw.map((item) {
      final product = item['products'] ?? {};
      return OrderItem(
        productName: product['product_name'] ?? 'Unnamed',
        quantity: item['quantity'] ?? 1,
        imageUrl: product['image_url'] ?? '',
      );
    }).toList();

    return OrderModel(
      id: json['id'],
      customerName: "${customer['first_name']} ${customer['last_name']}",
      status: json['order_status'],
      totalAmount: (json['order_total'] as num).toDouble(),
      customerImageUrl: customer['image_url'],
      productImageUrl: orderedItemsRaw.isNotEmpty ? orderedItemsRaw[0]['products']['image_url'] : null,
      orderedItems: items,
    );
  }
}

class OrderItem {
  final String productName;
  final int quantity;
  final String imageUrl;

  OrderItem({
    required this.productName,
    required this.quantity,
    required this.imageUrl,
  });
}