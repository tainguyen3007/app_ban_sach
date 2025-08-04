import 'package:app_ban_sach/config/firebase_options.dart';

import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/cart_screen.dart';
import 'package:app_ban_sach/features/ui/screens/home_screen.dart';
import 'package:app_ban_sach/features/ui/screens/notification_screen.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/nav_bottom.dart';
import 'package:app_ban_sach/firebase_cloud/demo_data.dart';
import 'package:app_ban_sach/firebase_cloud/models/user.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance(); 
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final userId = prefs.getString('userId') ?? 'null';

  if (isLoggedIn) {
    try {
      final user = await UserService.getUserByUid(userId);
      runApp(MainScreen(
        isLoggedIn: true,
        indexPage: 0,
        user: user,
      ));
    } catch (e) {
      // Nếu lỗi, fallback về chưa đăng nhập
      runApp(const MainScreen(
        isLoggedIn: false,
        indexPage: 0,
      ));
    }
  } else {
    runApp(const MainScreen(
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
  final String? userId;
  final bool isLoggedIn;
  final int indexPage;
  const MainScreen({super.key, required this.isLoggedIn, this.indexPage = 0, this.user,this.userId});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  String? userId;
  List<Widget>? _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexPage;
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final pref = await SharedPreferences.getInstance();
    final id = pref.getString("userId") ?? "null";

    setState(() {
      userId = id;
      _pages = [
        HomeScreen(),
        NotificationScreen(),
        CartScreen(userId: userId!), // dùng dấu chấm than vì đã set
        UserScreen(isLoggedIn: widget.isLoggedIn, user: widget.user),
      ];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
        body: _pages == null
            ? const Center(child: CircularProgressIndicator())
            : _pages![_currentIndex],
        bottomNavigationBar: MyNavBottom(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

