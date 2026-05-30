import 'package:myshop/models/product.dart';

class ProductsManager {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      isFavorite: true,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/07/28/18/48/trousers-403980_1280.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/22/19/24/scarf-1850172_1280.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare perfect meals with this amazing pan!',
      price: 49.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/09/15/21/46/couch-447484_1280.jpg',
    ),
  ];

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }
}