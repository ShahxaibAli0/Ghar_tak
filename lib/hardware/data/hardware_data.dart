class HardwareStore {
  final String name;
  final String image;
  final List<HardwareProduct> products;

  HardwareStore({
    required this.name,
    required this.image,
    required this.products,
  });
}

class HardwareProduct {
  final String name;
  final String image;
  final String price;

  HardwareProduct({
    required this.name,
    required this.image,
    required this.price,
  });
}

List<HardwareStore> hardwareStores = [
  HardwareStore(
    name: "City Hardware Store",
    image: "https://via.placeholder.com/150",
    products: [
      HardwareProduct(
        name: "Hammer",
        image: "https://via.placeholder.com/150",
        price: "Rs 500",
      ),
      HardwareProduct(
        name: "Screwdriver Set",
        image: "https://via.placeholder.com/150",
        price: "Rs 1200",
      ),
    ],
  ),
  HardwareStore(
    name: "Modern Tools Shop",
    image: "https://via.placeholder.com/150",
    products: [
      HardwareProduct(
        name: "Drill Machine",
        image: "https://via.placeholder.com/150",
        price: "Rs 3500",
      ),
      HardwareProduct(
        name: "Wrench",
        image: "https://via.placeholder.com/150",
        price: "Rs 800",
      ),
    ],
  ),
];