import 'package:app_ban_sach/core/constants/style.dart';
import 'package:flutter/material.dart';

class OrderStatusTab extends StatelessWidget {
  const OrderStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,//căn đều nhau giửa các item
        children: [
          _itemTab(context, const Icon(Icons.credit_card), "Chờ thanh toán",null),
          _itemTab(context, const Icon(Icons.inbox), "Đang xử lý",null),
          _itemTab(context, const Icon(Icons.local_shipping), "Đang giao hàng",null),
          _itemTab(context, const Icon(Icons.check_circle), "Hoàn tất", null),
        ],
      ),
    );
  }
}

Widget _itemTab(BuildContext context, Icon icon, String title, VoidCallback? onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: MyColors.lightGreyColor,
          child: Icon(icon.icon, color: MyColors.textColor,),),
        const SizedBox(height: 2),
        Text(title, style: TextStyle(fontSize: MyTextStyle.size_11)),
      ],
    ),
  );
}