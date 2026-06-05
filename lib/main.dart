import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:myshop/ui/products/products_overview_screen.dart';
import 'package:myshop/ui/products/user_products_screen.dart'; 

// Thêm import của màn hình giỏ hàng theo hình ảnh image_b5b9e4.png
import 'ui/cart/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tách riêng cấu hình ColorScheme để dùng lại cho đối tượng themeData
    final colorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.purple,
    ).copyWith(
      secondary: Colors.deepOrange,
    );

    final themeData = ThemeData(
      fontFamily: 'Lato',
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      // Định nghĩa dialogTheme vào ThemeData theo đúng thiết kế image_b630ea.png
      dialogTheme: DialogThemeData(
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
        ),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        
        // Hiệu chỉnh trang home để trỏ về CartScreen xem giao diện giỏ hàng theo image_b5b9e4.png
        home: const SafeArea(
          child: CartScreen(),
        ),
        
        // KHAI BÁO THÊM ĐƯỜNG DẪN ROUTE Ở ĐÂY
        routes: {
          UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
        },
      ),
    );
  }
}