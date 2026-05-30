import 'package:flutter/material.dart';
import 'package:myshop/shared/products_manager.dart';
import 'package:myshop/ui/products/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    final sampleProduct = productsManager.items[0];

    return MaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.deepOrange,
        ),
      ),
      home: ProductDetailScreen(sampleProduct),
    );
  }
}