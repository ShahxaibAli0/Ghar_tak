List<Map<String, dynamic>> groceryStores = [
  {
    "name": "Ali Kryana Store",
    "logo": "https://via.placeholder.com/80",
    "delivery": 100,
    "rating": 4.5,
    "products": List.generate(10, (index) => {
      "name": "Product ${index+1}",
      "price": 50 + index*10,
      "image": "https://via.placeholder.com/100",
    })
  },
  {
    "name": "Supermart Grocery",
    "logo": "https://via.placeholder.com/80",
    "delivery": 120,
    "rating": 4.2,
    "products": List.generate(12, (index) => {
      "name": "Item ${index+1}",
      "price": 60 + index*15,
      "image": "https://via.placeholder.com/100",
    })
  },
  // Add 7–8 more stores
];