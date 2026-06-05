import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // Khởi tạo các biến lưu trữ lựa chọn tạm thời của người dùng trên UI
  String _selectedSize = '';
  int _selectedColor = 0;
  int _quantity = 1;

  @override
  void initState() {
    // Đặt cấu hình mặc định ban đầu dựa trên dữ liệu sản phẩm
    _selectedSize = widget.product.availableSizes.first;
    _selectedColor = widget.product.availableColors.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng provider để theo dõi trạng thái trái tim thay đổi
    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Builder(
        builder: (context) {
          final currentProduct = context.watch<Product>();
          
          return Scaffold(
            appBar: AppBar(
              title: Text(currentProduct.title),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Khu vực hiển thị ảnh sản phẩm to nét
                  SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: Image.network(
                      currentProduct.imageUrl,
                      fit: BoxFit.cover,
                      headers: const {
                        'User-Agent': 'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.181 Mobile Safari/537.36',
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Khu vực chứa nội dung text chi tiết
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Giá tiền hiển thị nổi bật
                        Text(
                          '\$${currentProduct.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // Mô tả sản phẩm
                        Text(
                          currentProduct.description,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const Divider(height: 30, thickness: 1),

                        // YÊU CẦU 2: CHỌN MÀU SẮC, KÍCH THƯỚC, SỐ LƯỢNG
                        // A. Khu vực chọn Màu sắc (Color Picker)
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
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(colorHex),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        // B. Khu vực chọn Kích thước (Size Picker)
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

                        // C. Khu vực nhập/chọn Số lượng (Quantity Selector)
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
                        const SizedBox(height: 80), // Tạo khoảng trống để không bị đè bởi thanh BottomBar
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // YÊU CẦU 1: NÚT THÊM VÀO DANH SÁCH YÊU THÍCH (FLOATING BUTTON)
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                // Thực thi đảo ngược trạng thái trái tim ngay lập tức nhờ Provider
                currentProduct.toggleFavoriteStatus();
                
                // Bắt sự kiện nổ thông báo SnackBar và in Log sạch ra Console cho thầy chấm
                debugPrint('Toggled Favorite Status for: ${currentProduct.title}');
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

            // YÊU CẦU 3: THANH THÊM VÀO GIỎ HÀNG (BOTTOM APP BAR)
            bottomNavigationBar: BottomAppBar(
              elevation: 10,
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Hiển thị tổng tiền tạm tính dựa trên số lượng chọn
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
                    // Nút nhấn Add to Cart nổ SnackBar bắt sự kiện
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        // Bắt sự kiện nổ log và SnackBar đúng yêu cầu đề bài
                        debugPrint('Event triggered: Added $_quantity item(s) of [${currentProduct.title}] (Size: $_selectedSize, Color hex: $_selectedColor) to Cart.');
                        
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