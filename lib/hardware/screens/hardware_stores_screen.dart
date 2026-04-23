import 'package:flutter/material.dart';
import '../data/hardware_data.dart';
import 'hardware_products_screen.dart';
import '../../../widgets/seller_products_section.dart';

class HardwareStoresScreen extends StatelessWidget {
  final List<HardwareStore> stores;

  const HardwareStoresScreen({Key? key, required this.stores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hardware Stores"),
        backgroundColor: Colors.green,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SellerProductsSection(category: 'Hardware'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final store = stores[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(
                        store.image,
                        width: 50,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.store,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                      title: Text(store.name),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HardwareProductsScreen(
                              products: store.products,
                              storeName: store.name,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: stores.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}