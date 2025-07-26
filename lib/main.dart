import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/datasources/db_helper.dart';
import 'package:app_ban_sach/data/datasources/user_service.dart';
import 'package:app_ban_sach/data/models/user.dart';
import 'package:app_ban_sach/features/ui/screens/cart_screen.dart';
import 'package:app_ban_sach/features/ui/screens/home_screen.dart';
import 'package:app_ban_sach/features/ui/screens/notification_screen.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/nav_bottom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Bắt buộc khi dùng async ở main
  await DBHelper.instance.database;
  //kiểm tra trạng thái login
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final user = await UserService().getUserById(await UserService().getCurrentUserId());
  if(user != null){
    runApp(MainScreen(isLoggedIn: isLoggedIn, indexPage: 0,user : user));
  }
  else {
    runApp(MainScreen(isLoggedIn: isLoggedIn, indexPage: 0,));
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
    CartScreen(),
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
