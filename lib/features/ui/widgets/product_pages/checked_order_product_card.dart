import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/product.dart';
import 'package:app_ban_sach/firebase_cloud/models/cart.dart';
import 'package:app_ban_sach/firebase_cloud/service/cart_service.dart';
import 'package:flutter/material.dart';

class CheckedOrderProductCard extends StatelessWidget {
  CartItemWithProduct? item;
  CheckedOrderProductCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
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
                  width: 50,
                  height: 50,
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
                    fontWeight: FontWeight.normal,
                    fontSize: MyTextStyle.size_13,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "x${item?.cart.quantity ?? 1}",
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
