
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/firebase_cloud/models/user.dart' as user_fb;
import 'package:app_ban_sach/data/datasources/auth.service.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:app_ban_sach/features/ui/screens/register_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:app_ban_sach/main.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginState();
}
class _LoginState extends State<LoginScreen> {
  final pref = SharedPreferences.getInstance();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final double paddingHorizontal = 5.0;

  auth.User? user;
  
  void login() async {
    final auth.User? currentUser = await AuthService().signInWithGoogle();

    if (currentUser != null) {
      user = currentUser;
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = await prefs.setBool('isLoggedIn', true);

      final authUser = user_fb.User(
        email: user?.email ?? 'guest@gmail.com',
        name: user?.displayName ?? "Guest",
        password: '',
        phoneNumber: user?.phoneNumber ?? "No phone number",
        avatar: user?.photoURL ?? "assets/default_images/default_avatar.jpg",
      );

      await UserService.saveUser(authUser);
      await prefs.setString("userId", authUser.email);
      await prefs.setBool("isLogginIn", true);

      // ✅ Gọi SnackBar trước
      if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đăng nhập thành công")),
      );
      
      // Tuỳ chọn delay
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(
            isLoggedIn: isLoggedIn,
            indexPage: 3,
            user: authUser,
          ),
        ),
        (route) => false,
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đăng nhập thất bại hoặc bị hủy")),
      );
    }
  }


  void logout() async {
    await AuthService().signOut();
    setState(() {
      user = null;
    });
  }
  Future<void> _onClickLogin() async {
    final email = phoneController.text.trim(); // hoặc dùng email nếu app bạn login bằng email
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đủ thông tin')),
      );
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Đăng nhập',showBackButton: false,),
      body: SingleChildScrollView(
        child: Container(  
          color: MyColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 10.0), // Thay đổi padding ngang
          child: Container(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0), // Thêm padding trên và hai bên
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: paddingHorizontal), 
                // Logo
                Image.asset(
                    'assets/logo_offical.png', 
                    height: 150,
                    width: 150,
                  ),
                SizedBox(height: paddingHorizontal),
                // Nhập sdt
                MyTextField(
                  labelText: 'Username',
                  hintText: 'Nhập username',
                  controller: phoneController,
                  isPassword: false,
                ),
                // Nhập password
                MyTextField(
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  controller: passwordController,
                  isPassword: true,
                ),
                // Đăng nhập button
                MyButton(
                  text: 'Đăng nhập', 
                  isOutlined: false, //nút outline
                  isDisabled: false, // nút bị vô hiêu hóa
                  onPressed: _onClickLogin,
                ),
                // Quên mật khẩu
                SizedBox(
                  height: 33,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Xử lý quên mật khẩu ở đây
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Chức năng quên mật khẩu chưa được triển khai!')),
                          );
                        },
                        child: const Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            color: MyColors.warningColor,
                            fontSize: MyTextStyle.size_13,),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 37,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Bạn đã có tài khoản chưa? ",
                        style: TextStyle(
                          color: MyColors.textColor,
                          fontSize: MyTextStyle.size_16,
                          fontWeight: MyTextStyle.semibold
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterScreen(),
                          ),
                    );
                        },
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: MyColors.primaryColor,
                            fontSize: MyTextStyle.size_16,
                            fontWeight: MyTextStyle.semibold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MyButton(text: 'Đăng nhập bằng Google', 
                  imagePath: 'assets/google_logo.jpg', // Đường dẫn hình ảnh
                  isOutlined: true, //nút outline
                  isDisabled: false, // nút bị vô hiêu hóa
                  onPressed: login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}