import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/nav_bottom.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Xử lý logic chuyển màn hình tại đây
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'home',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar:  MyNavBottom(currentIndex: _currentIndex, onTap: _onItemTapped),
    );
  }
}