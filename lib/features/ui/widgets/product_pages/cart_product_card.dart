import 'package:app_ban_sach/firebase_cloud/service/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';

class CartProductCard extends StatefulWidget {
  final CartItemWithProduct item;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback? onRemove;
  final VoidCallback? onQuantityChanged;

  const CartProductCard({
    super.key,
    required this.item,
    required this.onChanged,
    this.onQuantityChanged,
    this.onRemove,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  late int quantity;
  double get totalPrice => widget.item.product.price * quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.item.cart.quantity;
  }

  Future<void> _updateQuantity(int change) async {
    final newQuantity = quantity + change;

    if (newQuantity < 1) {
      // Nếu muốn xóa khi về 0:
      if (widget.onRemove != null) {
        await CartService.deleteCart(widget.item.cart.id!);
        widget.onRemove!();
      }
      return;
    }

    setState(() {
      quantity = newQuantity;
      widget.item.cart.quantity = quantity;
    });

    // Cập nhật trên Firebase
    if (widget.item.cart.id != null) {
      await CartService.updateCart(widget.item.cart);
    }

    // Báo về cha cập nhật tổng giá
    if (widget.onQuantityChanged != null) {
      widget.onQuantityChanged!();
    }
  }

  Widget _buildQuantityControl() {
    return Row(
      children: [
        _iconButton(Icons.remove, () => _updateQuantity(-1)),
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: MyColors.greyColor),
          child: Text(
            '$quantity',
            style: const TextStyle(
              fontSize: MyTextStyle.size_13,
              fontWeight: MyTextStyle.bold,
            ),
          ),
        ),
        _iconButton(Icons.add, () => _updateQuantity(1)),
      ],
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Checkbox
            SizedBox(
              width: 20,
              child: Checkbox(
                value: item.cart.isChecked,
                onChanged: widget.onChanged,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => states.contains(MaterialState.selected)
                      ? MyColors.warningColor
                      : MyColors.whiteColor,
                ),
              ),
            ),
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.product.imageUrl == ''
                  ? Image.asset(
                      "assets/default_images/default_image.png",
                      height: 120,
                      width: 120,
                      fit: BoxFit.scaleDown,
                    )
                  : Image.asset(
                      item.product.imageUrl,
                      height: 120,
                      width: 120,
                      fit: BoxFit.scaleDown,
                    ),
            ),
            const SizedBox(width: 10),
            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    MyTextStyle.formatCurrency(totalPrice),
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_13,
                      fontWeight: MyTextStyle.bold,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    MyTextStyle.formatCurrency(item.product.oldprice),
                    style: const TextStyle(
                      fontSize: MyTextStyle.size_13,
                      color: MyColors.darkGreyColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildQuantityControl(),
                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: MyColors.errorColor),
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
