import 'package:app_ban_sach/core/constants/style.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData? leadingIcon; // Biểu tượng bên trái (nếu cần)
  final String title; // Tiêu đề của ListTile
  final VoidCallback? onTap; // Hàm xử lý khi nhấn vào ListTile

  const MyListTile({
    this.leadingIcon, 
    required this.title,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 44,
      leading: leadingIcon != null
          ? Icon(leadingIcon, color: MyColors.textColor) // Hiển thị biểu tượng nếu có
          : null,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MyTextStyle.size_13
          ),
      ),
      trailing: const Icon(Icons.chevron_right, color: MyColors.textColor),
      onTap: onTap, // Tham chiếu hàm xử lý từ bên ngoài
    );
  }
}