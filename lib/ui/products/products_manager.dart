import 'package:flutter/foundation.dart';
import '../../models/product.dart';

class ProductsManager with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      isFavorite: true,
      availableSizes: ['M', 'L', 'XL'],
      availableColors: [0xFFFF0000, 0xFF000000],
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/19/Overzeas_longpocket_jeans.jpg',
      availableSizes: ['29', '30', '31', '32'],
      availableColors: [0xFF0000FF, 0xFF808080],
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      availableSizes: ['Free Size'],
      availableColors: [0xFFFFD700, 0xFFFFA500],
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/14/Cast-Iron-Pan.jpg',
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
}