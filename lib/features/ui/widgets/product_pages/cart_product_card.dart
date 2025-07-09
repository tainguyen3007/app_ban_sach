import 'dart:ffi';
import 'package:intl/intl.dart'; // Thêm thư viện intl
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
class CartItem {
  String imageUrl;
  String productName;
  double price;
  double totalPrice;
  double oldPrice;
  bool isChecked;

  CartItem({
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.oldPrice,
    this.isChecked = false,
  }): totalPrice = price;
}

class CartProductCard extends StatefulWidget {
  CartItem item;
  final ValueChanged<bool?> onChanged;
  VoidCallback? onRemove; // Hàm xử lý khi nhấn nút xóa

  CartProductCard({
    required this.item,
    required this.onChanged,
    this.onRemove,
    super.key,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  int quantity = 1; // Số lượng sản phẩm
  double get totalPrice => widget.item.price * quantity;
  void _increaseQuantity() {
    setState(() {
      quantity++;
      widget.item.totalPrice = totalPrice;
    });
  }
  String formatCurrency(double value) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0);
    return formatter.format(value);
  }
  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        widget.item.totalPrice = totalPrice;
      }
    });
  }
  void onChangedCheckedBox(bool? value) {
    setState(() {
      widget.item?.isChecked = value ?? true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bo góc card
      ),
      elevation: 2, // Đổ bóng card
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: Checkbox(
                value: widget.item?.isChecked,
                onChanged: widget.onChanged,
                fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return MyColors.warningColor; // Màu khi được chọn
                  }
                  return MyColors.whiteColor; // Màu khi không được chọn
                }),
              )
            ),
            // Hình ảnh sản phẩm
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bo góc hình ảnh
              child: Image.asset(
                widget.item?.imageUrl ?? "assets/sgk_tv_2_1_.jpg",
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
                    widget.item?.productName?? "Name product",
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2, // Hiển thị tối đa 2 dòng
                    overflow: TextOverflow.ellipsis, // Cắt chữ nếu quá dài
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatCurrency(totalPrice),
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_13,
                      fontWeight: MyTextStyle.semibold,
                      color: MyColors.primaryColor, // Màu sắc cho giá
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatCurrency(widget.item.oldPrice),
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
