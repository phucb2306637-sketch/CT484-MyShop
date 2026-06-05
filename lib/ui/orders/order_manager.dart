import '../../models/cart_item.dart';
import '../../models/order_item.dart';

class OrdersManager {
  final List<OrderItem> _orders = [
    OrderItem(
      id: 'o1',
      amount: 59.98,
      products: [
        CartItem(
          id: 'c1',
          title: 'Red Shirt',
          // Đã hiệu chỉnh từ link mạng cũ sang đường dẫn asset cục bộ để tránh lỗi hiển thị
          imageUrl: 'assets/img/red_shirt.jpg',
          price: 29.99,
          quantity: 2,
        )
      ],
      dateTime: DateTime.now(),
    )
  ];

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }
}