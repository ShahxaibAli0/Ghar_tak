import 'dart:async'; // ✅ Timer for auto-scrolling offers
import 'package:flutter/material.dart';
import 'store_details_screen.dart';
import 'services_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All"; // default: show all stores

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> services = const [
    {"name": "Plumber", "icon": Icons.plumbing},
    {"name": "Electrician", "icon": Icons.electrical_services},
    {"name": "Carpenter", "icon": Icons.handyman},
    {"name": "Painter", "icon": Icons.format_paint},
  ];

  final List<Map<String, dynamic>> categories = const [
    {"name": "Grocery", "image": "https://via.placeholder.com/100"},
    {"name": "Restaurants", "image": "https://via.placeholder.com/100"},
    {"name": "Pharmacies", "image": "https://via.placeholder.com/100"},
    {"name": "Electronics", "image": "https://via.placeholder.com/100"},
  ];

  final List<Map<String, dynamic>> stores = const [
    {
      "name": "Ali's Grocery",
      "category": "Grocery",
      "rating": 4.5,
      "delivery": "Rs 100",
      "products": [
        {"name": "Milk", "price": 120, "image": "https://via.placeholder.com/150", "rating": 4.5, "discount": 5},
        {"name": "Bread", "price": 80, "image": "https://via.placeholder.com/150", "rating": 4.0, "discount": 0},
      ],
    },
    {
      "name": "Fresh Pharmacy",
      "category": "Pharmacies",
      "rating": 4.7,
      "delivery": "Rs 50",
      "products": [
        {"name": "Paracetamol", "price": 100, "image": "https://via.placeholder.com/150", "rating": 4.7, "discount": 10},
      ],
    },
    {
      "name": "Best Restaurant",
      "category": "Restaurants",
      "rating": 4.3,
      "delivery": "Rs 150",
      "products": [
        {"name": "Burger", "price": 250, "image": "https://via.placeholder.com/150", "rating": 4.3, "discount": 15},
      ],
    },
  ];

  final List<Map<String, String>> offers = const [
    {"image": "https://via.placeholder.com/400x150", "title": "Mega Sale! 10% Off"},
    {"image": "https://via.placeholder.com/400x150", "title": "Fresh Grocery Discount"},
    {"image": "https://via.placeholder.com/400x150", "title": "Restaurant Combo Offer"},
  ];

  @override
  void initState() {
    super.initState();
    // 🔹 Timer for auto-scroll offers
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < offers.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ghar Tak")),
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // 🔹 Offers Carousel (Auto-scroll)
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: _pageController,
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(offer['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                    child: Text(
                      offer['title']!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Services Section
          const Text("Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicesScreen(serviceName: service['name']),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(service['icon'], size: 40, color: Colors.green),
                        const SizedBox(height: 8),
                        Text(service['name'], textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Categories Section
          const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = "All"),
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: selectedCategory == "All" ? Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: const Center(child: Text("All", style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  );
                } else {
                  final category = categories[index - 1];
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = category['name']!),
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: selectedCategory == category['name'] ? Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(category['image'], height: 60, width: 60),
                          const SizedBox(height: 8),
                          Text(category['name'], textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Stores Section
          const Text("Stores", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...stores
              .where((store) => selectedCategory == "All" || store['category'] == selectedCategory)
              .map((store) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoreDetailsScreen(
                      storeName: store['name'],
                      products: List<Map<String, dynamic>>.from(store['products']),
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(store['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber.shade600, size: 16),
                            const SizedBox(width: 4),
                            Text(store['rating'].toString()),
                          ],
                        ),
                      ],
                    ),
                    Text("Delivery: ${store['delivery']}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}