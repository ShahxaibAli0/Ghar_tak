import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

// ✅ Category Screens
import '../categories/grocery_category_screen.dart';
import '../categories/pharmacy_category_screen.dart';
import '../../restaurants/screens/restaurants_category_screen.dart';
import '../../electric/screens/electric_category_screen.dart';
import '../../hardware/screens/hardware_screen.dart';

// ✅ Service Screen
import '../services/location_permission_screen.dart';
import '../services/service_request_screen.dart';

// ✅ Data
import '../../data/grocery_data.dart';
import '../../data/location_data.dart';

import 'package:geolocator/geolocator.dart';

// ✅ Bottom Navigation Screens
import '../offers/offers_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

// ✅ Notification Screens
import '../notifications/notifications_screen.dart';
import '../../models/notifications_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  final PageController _pageController = PageController();
  Timer? _timer;

  int _currentPage = 0;

  String selectedCity = "Pattoki";
  String selectedArea = "Shadman City";

  List<String> banners = [
    "assets/images/banner1.jpeg",
    "assets/images/banner2.jpeg",
    "assets/images/banner3.jpeg",
  ];

  List<Map<String, dynamic>> categories = [
    {"icon": Icons.local_grocery_store, "title": "Grocery"},
    {"icon": Icons.local_pharmacy, "title": "Pharmacy"},
    {"icon": Icons.restaurant, "title": "Restaurants"},
    {"icon": Icons.electrical_services, "title": "Electric"},
    {"icon": Icons.hardware, "title": "Hardware"},
  ];

  List<Map<String, dynamic>> services = [
    {"image": "assets/images/plumber.jpeg", "title": "Plumber"},
    {"image": "assets/images/carpenter.jpeg", "title": "Carpenter"},
    {"image": "assets/images/electrician.jpeg", "title": "Electrician"},
    {"image": "assets/images/it_technician.jpeg", "title": "It Technician"},
  ];

  List<Widget> get _pages => [
    _homeContent(),
    const OffersScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {

        _currentPage++;

        if (_currentPage == banners.length) {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        setState(() {});
      }
    });
  }

  @override
  void dispose() {

    _timer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  void _openLocationSelector() {

    showModalBottomSheet(
      context: context,
      builder: (context) {

        return ListView(
          children: cities.map((city) {

            return ExpansionTile(

              title: Text(city.name),

              children: city.areas.map((area) {

                return ListTile(
                  title: Text(area),
                  onTap: () {

                    setState(() {

                      selectedCity = city.name;
                      selectedArea = area;

                    });

                    Navigator.pop(context);
                  },
                );

              }).toList(),

            );

          }).toList(),
        );
      },
    );
  }

  void _navigate(String title) {

    if (title == "Grocery") {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GroceryCategoryScreen(stores: groceryStores),
        ),
      );
    }

    if (title == "Pharmacy") {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PharmacyCategoryScreen(),
        ),
      );
    }

    if (title == "Restaurants") {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const RestaurantsCategoryScreen(),
        ),
      );
    }

    if (title == "Electric") {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const ElectricCategoryScreen(),
        ),
      );
    }

    if (title == "Hardware") {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const HardwareScreen(),
        ),
      );
    }
  }

  Future<void> _navigateService(String title) async {

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ServiceRequestScreen(serviceName: title),
        ),
      );

    } else {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              LocationPermissionScreen(serviceName: title),
        ),
      );
    }
  }

  Widget _homeContent() {

    return SafeArea(

      child: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(

              padding: const EdgeInsets.all(16),

              decoration: const BoxDecoration(

                gradient: LinearGradient(
                  colors: [Colors.green, Colors.greenAccent],
                ),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),

              ),

              child: GestureDetector(

                onTap: _openLocationSelector,

                child: Row(

                  children: [

                    const Icon(Icons.location_on,color: Colors.white),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        "$selectedCity - $selectedArea",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    Stack(
                      children: [

                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationScreen(),
                              ),
                            );

                            setState(() {});
                          },
                        ),

                        if (appNotifications.isNotEmpty)

                          Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                appNotifications.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),

                      ],
                    )

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search,color: Colors.green),
                        hintText: "Search for products...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 170,
              child: PageView.builder(
                controller: _pageController,
                itemCount: banners.length,
                itemBuilder: (context, index) {

                  return Padding(

                    padding: const EdgeInsets.symmetric(horizontal: 15),

                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(20),

                      child: Image.asset(
                        banners[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(

              height: 100,

              child: ListView.builder(

                scrollDirection: Axis.horizontal,

                padding: const EdgeInsets.symmetric(horizontal: 15),

                itemCount: categories.length,

                itemBuilder: (context, index) {

                  final title = categories[index]["title"];

                  return GestureDetector(

                    onTap: () => _navigate(title),

                    child: Container(

                      margin: const EdgeInsets.only(right: 15),

                      width: 80,

                      child: Column(

                        children: [

                          Container(

                            padding: const EdgeInsets.all(15),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                )
                              ],
                            ),

                            child: Icon(
                              categories[index]["icon"],
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(title,textAlign: TextAlign.center),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Services",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 15),

              child: GridView.builder(

                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),

                itemCount: services.length,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.9,

                ),

                itemBuilder: (context, index) {

                  final title = services[index]["title"];

                  return GestureDetector(

                    onTap: () => _navigateService(title),

                    child: Column(

                      children: [

                        Container(

                          height: 110,
                          width: double.infinity,

                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),

                            image: DecorationImage(
                              image: AssetImage(
                                services[index]["image"],
                              ),
                              fit: BoxFit.cover,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.green.shade50,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.shopping_cart),
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,

        selectedItemColor: Colors.green,

        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

        onTap: (index) {

          setState(() {
            _selectedIndex = index;
          });

        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: "Offers",
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