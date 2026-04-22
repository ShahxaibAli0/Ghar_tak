class CartItem {
  final String name;
  final int price;
  final String image;
  final String storeName;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.storeName,
    this.quantity = 1,
  });
}
