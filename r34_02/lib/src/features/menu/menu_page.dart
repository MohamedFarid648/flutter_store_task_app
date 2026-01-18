import 'package:flutter/material.dart';
import 'package:flutter_store_task_app/src/core/routes/routes.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.storefront),
            title: const Text('Shop (Products)'),
            onTap: () {
              Navigator.pushReplacementNamed(context, RouteNames.productsPage);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('My Cart'),
            onTap: () {
              Navigator.pushNamed(context, RouteNames.cart);
            },
          ),
          // add more menu items (Account, Favourites, etc.)
        ],
      ),
    );
  }
}
