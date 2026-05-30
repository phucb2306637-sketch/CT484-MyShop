import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'products_manager.dart';
import 'user_product_list_tile.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = context.watch<ProductsManager>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          // Bắt sự kiện nổ SnackBar khi bấm nút Thêm (+)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Add a product'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}