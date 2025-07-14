import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/cart_screen.dart';
import 'package:app_ban_sach/features/ui/screens/home_screen.dart';
import 'package:app_ban_sach/features/ui/screens/notification_screen.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/nav_bottom.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  
  runApp(MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
    );
  }
}
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
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
