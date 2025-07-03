import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';
import 'package:flutter/material.dart';

class ListProductCard extends StatelessWidget {
  List<ProductCard> lstCard = [];
  ListProductCard(
    this.lstCard,
    {super.key}
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (lstCard.isEmpty)
          const Center(
            child: Text(
              'Không có sản phẩm nào',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        else
          const SizedBox.shrink(), // Hiển thị khoảng trống nếu không có sản phẩm
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: lstCard.toList(),
          ),
        ), 
      ],
    );
  }
}