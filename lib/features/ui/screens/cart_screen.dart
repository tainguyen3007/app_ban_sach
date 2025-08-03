import 'package:app_ban_sach/firebase_cloud/service/cart_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/product_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/cart_product_card.dart';

class CartScreen extends StatefulWidget {
  final String userId;
  const CartScreen({required this.userId, super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPriceSelected = 0;
  List<CartItemWithProduct> displayItems = [];
  void _updateTotalPrice(List<CartItemWithProduct> items) {
    double total = 0;
    for (var item in items) {
      if (item.cart.isChecked) {
        total += item.cart.quantity * item.product.price;
      }
    }
    setState(() {
      totalPriceSelected = total;
    });
  }

  void _toggleItemCheck(int index, bool? value) {
    final item = displayItems[index];
    item.cart.isChecked = value ?? false;

    setState(() {
      displayItems[index] = item;
      _updateTotalPrice(displayItems);
    });
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Giỏ hàng", showBackButton: false),
      body: FutureBuilder<List<CartItemWithProduct>>(
        future: CartService.getCartWithProductByUser(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Đã có lỗi xảy ra'));
          }

          displayItems = snapshot.data ?? [];

          if (displayItems.isEmpty) {
            return const Center(child: Text('Giỏ hàng trống'));
          }
          
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: displayItems.length,
                  itemBuilder: (context, index) {
                    final item = displayItems[index];

                    return CartProductCard(
                      item: item,
                      onChanged: (isChecked) => _toggleItemCheck(index, isChecked),
                      onRemove: () async {
                        await CartService.deleteCart(item.cart.id!);
                        setState(() {
                          displayItems.removeAt(index);
                        });
                        _updateTotalPrice(displayItems);
                      },
                    );
                  },
                ),
              ),
              _buildTotalSection(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 12, right: 12, top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thành tiền',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: MyTextStyle.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                MyTextStyle.formatCurrency(totalPriceSelected),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.warningColor,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.warningColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              // TODO: xử lý thanh toán
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            label: const Text(
              'Thanh toán',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

