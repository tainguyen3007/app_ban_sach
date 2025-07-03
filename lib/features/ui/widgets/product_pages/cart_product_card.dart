import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';

class CartProductCard extends StatefulWidget {
  final String imageUrl; // URL hình ảnh sản phẩm
  final String productName; // Tên sản phẩm
  final String price; // Giá sản phẩm
  final String oldPrice; // Giá cũ (nếu có)
  final VoidCallback onRemove; // Hàm xử lý khi nhấn nút xóa

  const CartProductCard({
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.oldPrice,
    required this.onRemove,
    super.key,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  int quantity = 1; // Số lượng sản phẩm

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bo góc card
      ),
      elevation: 3, // Đổ bóng card
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // Hình ảnh sản phẩm
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bo góc hình ảnh
              child: Image.asset(
                widget.imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(width: 10),
            // Thông tin sản phẩm
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2, // Hiển thị tối đa 2 dòng
                    overflow: TextOverflow.ellipsis, // Cắt chữ nếu quá dài
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_13,
                      fontWeight: MyTextStyle.semibold,
                      color: MyColors.primaryColor, // Màu sắc cho giá
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.oldPrice,
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_13,
                      color: MyColors.darkGreyColor, // Màu sắc cho giá cũ
                      decoration: TextDecoration.lineThrough, // Gạch ngang
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nút tăng giảm số lượng
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: _decreaseQuantity,
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: MyColors.greyColor
                            ),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: MyTextStyle.size_13,
                                fontWeight: MyTextStyle.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: _increaseQuantity,
                            ),
                          ),
                        ],
                      ),
                      // Nút xóa sản phẩm
                      IconButton(
                        icon: const Icon(Icons.delete, color: MyColors.errorColor),
                        onPressed: widget.onRemove,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
