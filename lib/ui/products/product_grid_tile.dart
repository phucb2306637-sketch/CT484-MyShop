import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../cart/cart_manager.dart';
import 'products_manager.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({super.key});

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              context.read<ProductsManager>().updateProduct(
                    product.copyWith(
                      isFavorite: !product.isFavorite,
                    ),
                  );
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              final cart = context.read<CartManager>();
              cart.addItem(product);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Item added to cart',
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeItem(product.id!);
                      },
                    ),
                  ),
                );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            context.push('/products/${product.id}');
          },
          child: product.featuredImage != null
              ? Image.file(
                  product.featuredImage!,
                  fit: BoxFit.cover,
                )
              : product.imageUrl.startsWith('assets/img/')
                  ? Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, color: Colors.grey, size: 40),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}