class Restaurant {
  final String name;
  final List<String> products;

  Restaurant({
    required this.name,
    required this.products,
  });
}

// Sample restaurants
List<Restaurant> restaurantsList = [
  Restaurant(
    name: "Chezious",
    products: [
      "Zinger Burger",
      "Pizza Fajita",
      "Chicken Broast",
      "BBQ Wings",
      "Club Sandwich",
      "Chicken Shawarma",
      "French Fries",
      "Pasta",
      "Nuggets",
      "Cold Drink",
    ],
  ),
  Restaurant(
    name: "BFC",
    products: [
      "Zinger",
      "Mighty Burger",
      "Broast",
      "Wings",
      "Fries",
      "Deal 1",
      "Deal 2",
      "Nuggets",
      "Shawarma",
      "Drink",
    ],
  ),
  Restaurant(
    name: "AFC",
    products: [
      "Zinger",
      "Broast",
      "Wrap",
      "Wings",
      "Fries",
      "Pizza",
      "Deal Box",
      "Sandwich",
      "Nuggets",
      "Pepsi",
    ],
  ),
  Restaurant(
    name: "Delight Cafe",
    products: [
      "Pizza",
      "Burger",
      "Pasta",
      "Fries",
      "BBQ",
      "Coffee",
      "Milkshake",
      "Nuggets",
      "Sandwich",
      "Drink",
    ],
  ),
];