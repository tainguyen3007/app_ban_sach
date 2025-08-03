import 'package:app_ban_sach/config/firebase_options.dart';

import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/cart_screen.dart';
import 'package:app_ban_sach/features/ui/screens/home_screen.dart';
import 'package:app_ban_sach/features/ui/screens/notification_screen.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/nav_bottom.dart';
import 'package:app_ban_sach/firebase_cloud/models/user.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Bắt buộc khi dùng async ở main
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Lấy trạng thái đăng nhập và userId từ SharedPreferences
  final prefs = await SharedPreferences.getInstance(); 
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final userId = prefs.getString('userId');

  // Nếu đã đăng nhập và có userId => lấy user từ DB
  if (isLoggedIn && userId != null) {
    final user = await UserService.getUserByUid(userId);
    runApp(MainScreen(
      isLoggedIn: true,
      indexPage: 0,
      user: user,
    ));
  } else {
    // Nếu chưa đăng nhập hoặc thiếu userId => không có user
    runApp(MainScreen(
      isLoggedIn: false,
      indexPage: 0,
    ));
  }
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({
    super.key, 
    required this.isLoggedIn
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Center(),
    );
  }
}
class MainScreen extends StatefulWidget {
  final User? user;
  final bool isLoggedIn;
  final int indexPage;
  const MainScreen({super.key, required this.isLoggedIn, this.indexPage = 0, this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexPage;
  }
  late final List<Widget> _pages = [
    HomeScreen(),
    NotificationScreen(),
    CartScreen(userId: 'nguyenviettai770@gmail.com',),
    UserScreen(isLoggedIn: widget.isLoggedIn,user: widget.user),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Xử lý logic chuyển màn hình tại đây
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          toolbarHeight: 0.1,
          ),
        body: _pages[_currentIndex],
        bottomNavigationBar:  MyNavBottom(
          currentIndex: _currentIndex, 
          onTap: _onItemTapped),
      ),
    );
  }
} 
