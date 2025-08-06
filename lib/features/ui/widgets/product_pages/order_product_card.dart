import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/product.dart';
import 'package:app_ban_sach/firebase_cloud/models/cart.dart';
import 'package:app_ban_sach/firebase_cloud/service/cart_service.dart';
import 'package:flutter/material.dart';

class OrderProductCard extends StatelessWidget {
  CartItemWithProduct? item;
  OrderProductCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3), // Đổ bóng xuống dưới
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh sản phẩm
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item?.product.imageUrl?? "assets/default_images/default_image.png", // chỉnh đường dẫn đúng
                  width: 80,
                  height: 80,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          // Thông tin sản phẩm
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item?.product.name ?? "name product",
                  style: TextStyle(
                    fontWeight: MyTextStyle.bold,
                    fontSize: MyTextStyle.size_13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  MyTextStyle.formatCurrency(item?.product.price?? 0),
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: MyTextStyle.size_13,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Số lượng: ${item?.cart.quantity ?? 1}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MyTextStyle.size_13,
                          color: MyColors.warningColor
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
