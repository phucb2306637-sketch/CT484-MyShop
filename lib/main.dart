import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myshop/ui/products/products_manager.dart';


import 'ui/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

    final router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/products',
      routes: [
        GoRoute(
          path: '/products',
          builder: (context, state) => const SafeArea(
            child: ProductsOverviewScreen(),
          ),
        ),
        GoRoute(
          path: '/products/:productId',
          builder: (context, state) {
            final productId = state.pathParameters['productId']!;
            final product = ProductsManager().findById(productId)!;
            return SafeArea(
              child: ProductDetailScreen(product),
            );
          },
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const SafeArea(
            child: CartScreen(),
          ),
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const SafeArea(
            child: OrdersScreen(),
          ),
        ),
        GoRoute(
          path: '/my-products',
          builder: (context, state) => const SafeArea(
            child: UserProductsScreen(),
          ),
        ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        ),
      ],
      child: MaterialApp.router(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        routerConfig: router,
      ),
    );
  }
}