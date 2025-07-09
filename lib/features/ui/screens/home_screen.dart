import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/cart_screen.dart';
import 'package:app_ban_sach/features/ui/screens/main_screen.dart';
import 'package:app_ban_sach/features/ui/screens/notification_screen.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/nav_bottom.dart';
import 'package:app_ban_sach/features/ui/widgets/silde.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    MyMainScreen(),
    NotificationScreen(),
    CartScreen(),
    UserScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Xử lý logic chuyển màn hình tại đây
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        toolbarHeight: 0.1,
        ),
      body: _pages[_currentIndex],
      bottomNavigationBar:  MyNavBottom(
        currentIndex: _currentIndex, 
        onTap: _onItemTapped),
    );
  }
}