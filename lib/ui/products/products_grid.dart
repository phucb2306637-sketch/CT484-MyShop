import 'package:flutter/material.dart';
import 'package:myshop/shared/products_manager.dart';
import 'product_grid_tile.dart';

class ProductsGrid extends StatelessWidget {
  final bool showLocalValue;

  const ProductsGrid(this.showLocalValue, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
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
      itemBuilder: (ctx, i) => ProductGridTile(products[i]),
    );
  }
}