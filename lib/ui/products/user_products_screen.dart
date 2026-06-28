import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
import 'products_manager.dart';
import 'user_product_list_tile.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  late Future<void> _fetchUserProducts;

  @override
  void initState() {
    super.initState();
    _fetchUserProducts = context.read<ProductsManager>().fetchUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/my-products/new');
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchUserProducts,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                context.read<ProductsManager>().fetchUserProducts(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Consumer<ProductsManager>(
                builder: (_, productsManager, __) {
                  return ListView.builder(
                    itemCount: productsManager.itemCount,
                    itemBuilder: (_, i) => Column(
                      children: [
                        UserProductListTile(
                          productsManager.items[i],
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}