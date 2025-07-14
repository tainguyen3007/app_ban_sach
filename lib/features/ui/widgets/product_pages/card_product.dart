import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/Product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  Product product;

  ProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth / 2 - 20, // Chiều rộng của card
      child: Card(
        color: MyColors.whiteColor,
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
                  child: 
                    product.imageUrl.isNotEmpty
                    ?Image.asset(
                      product.imageUrl,
                      height: 120,
                      width: 120,
                      fit: BoxFit.scaleDown,
                    )
                    :Image.asset(
                      "assets/sgk_tv_2_1.jpg",
                      height: 120,
                      width: 120,
                      fit: BoxFit.scaleDown,
                    ),
                ),
              ),
              // Tên sản phẩm
              const SizedBox(height: 5),
              Text(
                product.name,
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
                    MyTextStyle.formatCurrency(product.price),
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10), 
                  //giảm giá
                  product.discount != 0 ?
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.primaryColor, // Màu nền của discount
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      MyTextStyle.formatNumber(product.discount)+'%',
                      style: const TextStyle(
                        fontSize: MyTextStyle.size_13,
                        color: MyColors.whiteColor,
                        fontWeight: MyTextStyle.bold
                      ),
                    ),
                  )
                  : Row(),
                ],
              ),
              const SizedBox(height: 5),
              // Giá cũ
              Text(
                MyTextStyle.formatCurrency(product.oldPrice),
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
                  'Đã bán ${product.soldCount.toString()}',
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