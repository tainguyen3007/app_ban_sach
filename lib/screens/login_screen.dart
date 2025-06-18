import 'package:app_ban_sach/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Thay đổi padding ngang
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            // Logo
            Image.asset(
                'assets/logo_final_reverse.png', 
                height: 120,
                width: 120,
              ),
            const SizedBox(height: 20),
            // Số điện thoại
            TextField(
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                labelStyle: const TextStyle(color: Colors.black),
                hintText: 'Nhập số điện thoại',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Mật khẩu
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                labelStyle: const TextStyle(color: Colors.black),
                hintText: 'Nhập mật khẩu',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Đăng nhập button
            ElevatedButton(
              onPressed: () {
                // Xử lý logic đăng nhập
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                elevation: 5, // Độ cao của bóng
                shadowColor: Colors.black.withOpacity(1), // Màu bóng
              ),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            // Quên mật khẩu
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Xử lý logic quên mật khẩu
                },
                child: const Text(
                  'Quên mật khẩu?',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Đăng ký
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bạn đã có tài khoản chưa?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý logic đăng ký
                  },
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(color: MyColors.primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Hoặc
            const Text(
              'Hoặc',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Đăng nhập bằng Google
            ElevatedButton.icon(
              onPressed: () {
                // Xử lý logic đăng nhập bằng Google
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.grey),
              ),
              icon: Image.asset(
                'assets/google_logo.jpg', // Đảm lbảo bn có logo Googl trong thư mục assets
                height: 24,
                width: 24,
              ),
              label: const Text(
                'Đăng nhập bằng Google',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}