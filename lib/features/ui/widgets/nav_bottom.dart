import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';

class MyNavBottom extends StatelessWidget {
  final int currentIndex; // Chỉ mục hiện tại
  final ValueChanged<int> onTap; // Hàm xử lý khi nhấn vào mục

  const MyNavBottom({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Màu bóng mờ
            blurRadius: 4, // Độ mờ của bóng
            offset: Offset(0, -3), // Vị trí bóng (hướng lên trên)
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: MyColors.whiteColor,
        currentIndex: currentIndex, // Chỉ mục hiện tại
        onTap: onTap, // Hàm xử lý khi nhấn vào mục
        type: BottomNavigationBarType.fixed, // Loại cố định
        selectedItemColor: MyColors.primaryColor, // Màu mục được chọn
        unselectedItemColor: MyColors.textColor, // Màu mục chưa được chọn
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}