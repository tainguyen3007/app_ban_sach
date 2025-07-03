import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/cart_product_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Giỏ hàng', showBackButton: false),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: CartProductCard(
            imageUrl: 'assets/sgk_tv_2_1.jpg',
            productName: 'Giáo trình triết học Mác - Lênin',
            price: '140.000đ',
            oldPrice: '175.000đ',
            onRemove: () {
              // Xử lý xóa sản phẩm
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sản phẩm đã được xóa khỏi giỏ hàng')),
              );
            },
          ),
        ),
      ),
    );
  }
}