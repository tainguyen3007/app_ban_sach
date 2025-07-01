import 'package:app_ban_sach/core/constants/style.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  final String title; // Tiêu đề của AppBar
  final bool showBackButton; // Hiển thị nút quay lại hay không
  final List<Widget>? actions; // Các hành động ở bên phải AppBar

  const MyAppBar({
    required this.title,
    this.showBackButton = true,
    this.actions,
    super.key,
  });
  @override
  Size get preferredSize => Size.fromHeight(50); // Chiều cao cố định của AppBar 50px
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: MyColors.primaryColor,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Quay lại màn hình trước
              },
            )
          : null,
      actions: actions, // Các widget hành động (nếu có)
    );
  }
  
  
}