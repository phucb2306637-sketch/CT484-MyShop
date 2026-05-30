import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:myshop/ui/products/products_overview_screen.dart';
import 'package:myshop/ui/products/user_products_screen.dart'; // Import màn hình user vào đây

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
          ).copyWith(
            secondary: Colors.deepOrange,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
        ),
        home: const ProductsOverviewScreen(),
        // KHAI BÁO THÊM ĐƯỜNG DẪN ROUTE Ở ĐÂY
        routes: {
          UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
        },
      ),
    );
  }
}