import 'dart:io';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final File? featuredImage;
  final String imageUrl;
  bool isFavorite;

  final List<String> availableSizes;
  final List<int> availableColors;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    this.featuredImage,
    this.imageUrl = '',
    this.isFavorite = false,
    this.availableSizes = const ['S', 'M', 'L', 'XL'],
    this.availableColors = const [0xFFFFFFFFF, 0xFFFF0000, 0xFF0000FF],
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  bool hasFeaturedImage() {
    return featuredImage != null || imageUrl.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      isFavorite: json['isFavorite'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    File? featuredImage,
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
      featuredImage: featuredImage ?? this.featuredImage,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      availableSizes: availableSizes ?? this.availableSizes,
      availableColors: availableColors ?? this.availableColors,
    );
  }
}