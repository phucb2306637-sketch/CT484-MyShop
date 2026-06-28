import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:myshop/ui/cart/cart_manager.dart';
import 'package:myshop/ui/orders/order_manager.dart';

import 'ui/auth/auth_manager.dart';
import 'ui/screens.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthManager _authManager = AuthManager();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/auto-login',
      refreshListenable: _authManager,
      redirect: (context, state) {
        final isAuth = _authManager.isAuth;
        final isAtAuthScreen = state.fullPath == '/auth';

        if (!isAuth && !isAtAuthScreen) {
          return '/auth';
        }

        if (isAuth && isAtAuthScreen) {
          return '/products';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/auth',
          builder: (context, state) => const SafeArea(
            child: AuthScreen(),
          ),
        ),
        GoRoute(
          path: '/auto-login',
          builder: (context, state) {
            return FutureBuilder(
              future: context.read<AuthManager>().tryAutoLogin(),
              builder: (context, authSnapshot) => const SafeArea(
                child: SplashScreen(),
              ),
            );
          },
        ),
        GoRoute(
          path: '/logout',
          builder: (context, state) {
            return FutureBuilder(
              future: context.read<AuthManager>().logout(),
              builder: (context, authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.done) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go('/auth');
                  });
                }
                return const SafeArea(
                  child: SplashScreen(),
                );
              },
            );
          },
        ),
        GoRoute(
          path: '/products',
          builder: (context, state) => const SafeArea(
            child: ProductsOverviewScreen(),
          ),
        ),
        GoRoute(
          path: '/products/:productId',
          pageBuilder: (context, state) {
            final productId = state.pathParameters['productId']!;
            final product = context.read<ProductsManager>().findById(productId)!;
            
            return CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: const Duration(milliseconds: 400),
              child: SafeArea(
                child: ProductDetailScreen(product),
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                );
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                );
              },
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
        GoRoute(
          path: '/my-products/new',
          builder: (context, state) => SafeArea(
            child: EditProductScreen(null),
          ),
        ),
        GoRoute(
          path: '/my-products/:productId/edit',
          builder: (context, state) {
            final productId = state.pathParameters['productId'];
            final product = productId != null
                ? context.read<ProductsManager>().findById(productId)
                : null;
            return SafeArea(
              child: EditProductScreen(product),
            );
          },
        ),
      ],
    );
  }

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _authManager,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartManager(),
        ),
      ],
      child: MaterialApp.router(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        routerConfig: _router,
      ),
    );
  }
}