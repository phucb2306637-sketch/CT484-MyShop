import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../cart/cart_manager.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = '';
  int _selectedColor = 0;
  int _quantity = 1;

  @override
  void initState() {
    _selectedSize = widget.product.availableSizes.first;
    _selectedColor = widget.product.availableColors.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Builder(
        builder: (context) {
          final currentProduct = context.watch<Product>();
          
          return Scaffold(
            appBar: AppBar(
              title: Text(currentProduct.title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.home),
                  tooltip: 'Home',
                  onPressed: () {
                    context.go('/products');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  tooltip: 'Cart',
                  onPressed: () {
                    context.push('/cart');
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: Image.asset(
                      currentProduct.imageUrl,
                      fit: BoxFit.cover,
                      
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${currentProduct.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        Text(
                          currentProduct.description,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const Divider(height: 30, thickness: 1),

                        const Text(
                          'Select Color:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: currentProduct.availableColors.map((colorHex) {
                            final isSelected = _selectedColor == colorHex;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = colorHex;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? Colors.purple : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Select Size:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: currentProduct.availableSizes.map((size) {
                            final isSelected = _selectedSize == size;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedSize = size;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.purple : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? Colors.purple : Colors.grey[400]!,
                                  ),
                                ),
                                child: Text(
                                  size,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Quantity:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.purple,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() => _quantity++),
                              icon: const Icon(Icons.add_circle_outline),
                              color: Colors.purple,
                            ),
                          ],
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                currentProduct.toggleFavoriteStatus();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      currentProduct.isFavorite 
                          ? 'Added ${currentProduct.title} to Favorites!' 
                          : 'Removed ${currentProduct.title} from Favorites!',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Icon(
                currentProduct.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 28,
              ),
            ),

            bottomNavigationBar: BottomAppBar(
              elevation: 10,
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Price', style: TextStyle(color: Colors.grey)),
                        Text(
                          '\$${(currentProduct.price * _quantity).toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        context.read<CartManager>().addItem(currentProduct);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added $_quantity x ${currentProduct.title} ($_selectedSize) to cart successfully!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_checkout),
                      label: const Text('ADD TO CART', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}