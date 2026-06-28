import 'package:flutter/foundation.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  final ProductsService _productsService = ProductsService(); 

  // Đổi từ final sang non-final (List<Product> _items) để có thể gán lại danh sách khi fetch dữ liệu từ PocketBase
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/img/red_shirt.jpg',
      isFavorite: true,
      availableSizes: ['M', 'L', 'XL'],
      availableColors: [0xFFFF0000, 0xFF000000],
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'assets/img/Trousers.jpg',
      availableSizes: ['29', '30', '31', '32'],
      availableColors: [0xFF0000FF, 0xFF808080],
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'assets/img/yellow_scarf.jpg',
      availableSizes: ['Free Size'],
      availableColors: [0xFFFFD700, 0xFFFFA500],
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/img/pan.jpg',
      isFavorite: true,
      availableSizes: ['24cm', '28cm'],
      availableColors: [0xFF333333],
    ),
  ];

  int get itemCount => _items.length;
  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((item) => item.isFavorite).toList();

  Product? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  Future<void> fetchProducts() async {
    _items = await _productsService.fetchProducts();
    notifyListeners();
  }

  Future<void> fetchUserProducts() async {
    _items = await _productsService.fetchProducts(
      filteredByUser: true,
    );
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
}