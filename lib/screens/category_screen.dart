import 'package:flutter/material.dart';

// Sample category data
final List<Map<String, dynamic>> categories = [
  {
    "name": "Grocery",
    "stores": [
      {
        "name": "Ali Kryana",
        "logo": "https://via.placeholder.com/80",
        "delivery": 100,
        "rating": 4.5,
        "products": [
          {"name": "Milk 1L", "price": 200, "image": "https://via.placeholder.com/100"},
          {"name": "Bread", "price": 50, "image": "https://via.placeholder.com/100"},
        ],
        "chatable": false
      },
      {
        "name": "Supermart",
        "logo": "https://via.placeholder.com/80",
        "delivery": 120,
        "rating": 4.2,
        "products": [
          {"name": "Eggs", "price": 120, "image": "https://via.placeholder.com/100"},
          {"name": "Juice", "price": 150, "image": "https://via.placeholder.com/100"},
        ],
        "chatable": false
      },
    ],
  },
  {
    "name": "Pharmacy",
    "stores": [
      {
        "name": "PharmaCare",
        "logo": "https://via.placeholder.com/80",
        "delivery": 100,
        "rating": 4.2,
        "products": [
          {"name": "Paracetamol", "price": 30, "image": "https://via.placeholder.com/100"},
          {"name": "Vitamin C", "price": 150, "image": "https://via.placeholder.com/100"},
        ],
        "chatable": true
      },
    ],
  },
  {
    "name": "Electric",
    "stores": [
      {
        "name": "Electric Hub",
        "logo": "https://via.placeholder.com/80",
        "delivery": 150,
        "rating": 4.6,
        "products": [
          {"name": "LED Bulb", "price": 200, "image": "https://via.placeholder.com/100"},
          {"name": "Fan", "price": 2500, "image": "https://via.placeholder.com/100"},
        ],
        "chatable": true
      },
    ],
  },
];

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          backgroundColor: Colors.green,
          bottom: TabBar(
            isScrollable: true,
            tabs: categories.map((cat) => Tab(text: cat["name"])).toList(),
          ),
        ),
        body: TabBarView(
          children: categories.map((cat) {
            final stores = cat["stores"];
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Store Info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(store["logo"]),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(store["name"],
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text("Delivery: Rs ${store["delivery"]}"),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.orange, size: 16),
                                      SizedBox(width: 4),
                                      Text("${store["rating"]}")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (store["chatable"])
                              IconButton(
                                icon: Icon(Icons.chat, color: Colors.green),
                                onPressed: () {
                                  // TODO: Open chat screen with store
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Open chat with ${store["name"]}")),
                                  );
                                },
                              )
                          ],
                        ),

                        SizedBox(height: 10),

                        /// Products Horizontal Scroll
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: store["products"].length,
                            itemBuilder: (context, prodIndex) {
                              final product = store["products"][prodIndex];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 2,
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          product["image"],
                                          height: 70,
                                          width: 70,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              height: 70,
                                              width: 70,
                                              color: Colors.green.shade100,
                                              child: Icon(Icons.image, color: Colors.white),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 5),
                                        Text(product["name"], textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                                        SizedBox(height: 5),
                                        Text("Rs ${product["price"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Add"),
                                          style: ElevatedButton.styleFrom(minimumSize: Size(100, 30), backgroundColor: Colors.green),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}