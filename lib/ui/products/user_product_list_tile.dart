import 'package:flutter/material.dart';
import '../../models/product.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;

  const UserProductListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundColor: Colors.purple[100],
        child: ClipOval(
          child: Image.network(
            product.imageUrl,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            headers: const {
              'User-Agent': 'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.181 Mobile Safari/537.36',
            },
            errorBuilder: (ctx, error, stackTrace) {
              return const Icon(Icons.shopping_bag, color: Colors.purple);
            },
          ),
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            // Bắt sự kiện nổ SnackBar khi bấm nút Sửa (Cây bút)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Go to edit product screen'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            // Bắt sự kiện nổ SnackBar khi bấm nút Xóa (Thùng rác)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Delete a product'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}