import 'package:app_ban_sach/core/constants/style.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl; // URL hình ảnh sản phẩm
  final String productName; // Tên sản phẩm
  final String price; // Giá sản phẩm
  final String oldPrice; // Giá cũ (nếu có)
  final String discount; // Phần trăm giảm giá
  final String soldCount; // Số lượng đã bán

  const ProductCard({
    this.imageUrl = 'assets/sgk_tv_2_1.jpg',
    required this.productName,
    required this.price,
    required this.oldPrice,
    this.discount = '',
    required this.soldCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth /2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: MyRadius.defaultRadius,
        ),
        elevation: 3, // Đổ bóng card
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh sản phẩm
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: MyRadius.defaultRadius,
                  child: Image.asset(
                    imageUrl,
                    height: 120,
                    width: 120,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              // Tên sản phẩm
              const SizedBox(height: 5),
              Text(
                productName,
                style: const TextStyle(
                  fontSize: MyTextStyle.size_13,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2, // Hiển thị tối đa 2 dòng
                overflow: TextOverflow.ellipsis, // Cắt chữ nếu quá dài
              ),
              // Giá và giảm giá
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10), 
                  //giảm giá
                  if (discount != '')
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.primaryColor, // Màu nền của discount
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      discount,
                      style: const TextStyle(
                        fontSize: MyTextStyle.size_13,
                        color: MyColors.whiteColor,
                        fontWeight: MyTextStyle.bold
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // Giá cũ
              Text(
                oldPrice,
                style: const TextStyle(
                  fontSize: MyTextStyle.size_13,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough, // Gạch ngang giá cũ
                ),
              ),
              const SizedBox(height: 5),
              // Số lượng đã bán
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'Đã bán $soldCount',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}