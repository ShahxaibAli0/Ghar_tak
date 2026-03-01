import 'dart:async';
import 'package:flutter/material.dart';

import 'grocery_category_screen.dart';
import 'pharmacy_category_screen.dart';
import '../data/grocery_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PageController _pageController = PageController();

  List<String> banners = [
    "https://via.placeholder.com/400x150/4CAF50/FFFFFF?text=Super+Sale",
    "https://via.placeholder.com/400x150/4CAF50/FFFFFF?text=Flat+20%+Off",
    "https://via.placeholder.com/400x150/4CAF50/FFFFFF?text=Free+Delivery",
  ];

  List<Map<String, dynamic>> services = [
    {"icon": Icons.plumbing, "title": "Plumber"},
    {"icon": Icons.carpenter, "title": "Carpenter"},
    {"icon": Icons.electrical_services, "title": "Electrician"},
    {"icon": Icons.cleaning_services, "title": "Cleaning"},
  ];

  List<Map<String, dynamic>> categories = [
    {"icon": Icons.local_grocery_store, "title": "Grocery"},
    {"icon": Icons.local_pharmacy, "title": "Pharmacy"},
    {"icon": Icons.restaurant, "title": "Restaurants"},
    {"icon": Icons.electrical_services, "title": "Electric"},
    {"icon": Icons.hardware, "title": "Hardware"},
  ];

  @override
  void initState() {
    super.initState();

    // Auto Carousel
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage == banners.length) nextPage = 0;

        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔹 Location Bar
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Lahore - Johar Town",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // 🔹 Carousel
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          banners[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              // 🔹 Services
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Services",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(services[index]["icon"],
                              size: 40, color: Colors.green),
                          SizedBox(height: 10),
                          Text(
                            services[index]["title"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              // 🔹 Categories
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () {

                          if (categories[index]["title"] == "Grocery") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GroceryCategoryScreen(stores: groceryStores),
                              ),
                            );
                          }

                          if (categories[index]["title"] == "Pharmacy") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PharmacyCategoryScreen(),
                              ),
                            );
                          }

                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.green.shade100,
                              child: Icon(
                                categories[index]["icon"],
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(categories[index]["title"]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}