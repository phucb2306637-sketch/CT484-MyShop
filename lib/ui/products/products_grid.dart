import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'products_manager.dart';
import 'product_grid_tile.dart';

class ProductsGrid extends StatelessWidget {
  final bool showLocalValue;

  const ProductsGrid(this.showLocalValue, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = context.watch<ProductsManager>();
    final products = showLocalValue 
        ? productsManager.favoriteItems 
        : productsManager.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: const ProductGridTile(),
      ),
    );
  }
}