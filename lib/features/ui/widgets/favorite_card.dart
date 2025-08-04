import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/firebase_cloud/models/product.dart';
import 'package:flutter/material.dart';

class FavoriteProductCard extends StatelessWidget {
  Product item;
  VoidCallback onPressedDelete;
  FavoriteProductCard({
    required this.onPressedDelete,
    required this.item,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              item.imageUrl,
              width: 60,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: MyTextStyle.bold, fontSize: MyTextStyle.size_13),
                ),
                const SizedBox(height: 8),
                Text(
                  MyTextStyle.formatCurrency(item.price),
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: MyTextStyle.bold,
                    fontSize: MyTextStyle.size_13,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 100,
                  height: 36,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã thêm vào giỏ hàng!')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MyColors.primaryColor,
                      side: const BorderSide(color: MyColors.primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text('Mua', style: TextStyle(fontWeight: MyTextStyle.bold)),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: MyColors.errorColor),
            onPressed: onPressedDelete,
            tooltip: 'Xóa khỏi yêu thích',
          ),
        ],
      ),
    );
  }
}