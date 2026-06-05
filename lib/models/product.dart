import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  
  // THÊM CÁC THUỘC TÍNH MỚI CHO BÀI TẬP TỰ LÀM
  final List<String> availableSizes;  // Danh sách kích thước (S, M, L, XL...)
  final List<int> availableColors;    // Danh sách mã màu Hex (ví dụ: 0xFF000000)

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    // Cấu hình mặc định nếu không truyền vào để tránh lỗi các bước trước
    this.availableSizes = const ['S', 'M', 'L', 'XL'],
    this.availableColors = const [0xFFFFFFFFF, 0xFFFF0000, 0xFF0000FF], // Trắng, Đỏ, Xanh
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
    List<String>? availableSizes,
    List<int>? availableColors,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      availableSizes: availableSizes ?? this.availableSizes,
      availableColors: availableColors ?? this.availableColors,
    );
  }
}