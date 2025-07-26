import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/product.dart';
import 'package:app_ban_sach/data/models/product_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth / 2 - 20,
      child: Card(
        color: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: MyRadius.defaultRadius,
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 1, // Tỉ lệ vuông cho hình
                child: Image.asset(
                  product.imageUrl.isNotEmpty
                      ? product.imageUrl
                      : 'assets/default_images/default_image.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
      
            // Nội dung
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên sản phẩm
                  SizedBox(
                    height: 34,
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: MyTextStyle.size_13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      
                    ),
                  ),
      
                  const SizedBox(height: 6),
      
                  // Giá và giảm giá
                  Row(
                    children: [
                      Text(
                        MyTextStyle.formatCurrency(product.price),
                        style: const TextStyle(
                          fontSize: MyTextStyle.size_16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (product.discount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '-${product.discount.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: MyTextStyle.size_13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
      
                  const SizedBox(height: 4),
      
                  // Giá gốc
                  if (product.oldprice > 0)
                    Text(
                      MyTextStyle.formatCurrency(product.oldprice),
                      style: const TextStyle(
                        fontSize: MyTextStyle.size_13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
      
                  const SizedBox(height: 6),
      
                  // Số lượng đã bán
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Đã bán ${MyTextStyle.formatNumber(product.soldCount)}',
                      style: const TextStyle(
                        fontSize: MyTextStyle.size_11,
                        color: MyColors.darkGreyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
