import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'products_grid.dart';
import '../shared/app_drawer.dart';
import '../cart/cart_manager.dart';
import 'products_manager.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  late Future<void> _fetchProducts; // Thêm biến trạng thái để quản lý Future tải dữ liệu [cite: 357]

  @override
  void initState() {
    super.initState();
    // Gọi phương thức fetchProducts() từ ProductsManager khi khởi tạo widget [cite: 358]
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
          ),
          ShoppingCartButton(
            onPressed: () {
              context.push('/cart');
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      // Sử dụng FutureBuilder bao bọc lấy ProductsGrid để hiển thị thanh tiến trình chờ khi tải dữ liệu [cite: 356, 357]
      body: FutureBuilder(
        future: _fetchProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ProductsGrid(_showOnlyFavorites); // Khi tải dữ liệu xong thì hiển thị danh sách [cite: 359]
          }
          return const Center(
            child: CircularProgressIndicator(), // Trong lúc chờ thì xoay vòng tiến trình [cite: 356]
          );
        },
      ),
    );
  }
}

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartManager>(
      builder: (_, cartManager, __) {
        return IconButton(
          icon: Badge.count(
            count: cartManager.productCount,
            child: const Icon(
              Icons.shopping_cart,
            ),
          ),
          onPressed: onPressed,
        );
      },
    );
  }
}