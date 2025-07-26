import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/datasources/user_service.dart';
import 'package:app_ban_sach/data/models/user.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginState();
}

class _LoginState extends State<RegisterScreen> {
  //
  final double paddingHorizontal = 5.0;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();

  Future<void> _onClickRegister() async {
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final phone = phoneNumberController.text.trim();
    final pass = passController.text.trim();
    final passConfirm = passConfirmController.text.trim();

    if (email.isEmpty || phone.isEmpty || pass.isEmpty || passConfirm.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin.')),
      );
      return;
    }

    if (pass != passConfirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu xác nhận không khớp!')),
      );
      return;
    }

    // Kiểm tra email đã tồn tại chưa
    final existingUser = await UserService().getUserByEmail(email);
    if (existingUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email đã tồn tại!')),
      );
      return;
    }

    // Tạo user mới
    User user = User(
      email: email,
      password: pass,
      name: name,
      phoneNumber: phone,
    );

    await UserService().insertUser(user);

    // Thông báo & chuyển sang trang user/profile
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đăng ký thành công!')),
    );

    // Có thể điều hướng về màn hình đăng nhập hoặc trang người dùng
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => UserScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Đăng ký'),
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
                MyTextField(
                  labelText: 'Email',
                  hintText: 'Nhập email',
                  controller: emailController,
                  isPassword: false,
                ),
                MyTextField(
                  labelText: 'Họ và tên',
                  hintText: 'Nhập tên',
                  controller: nameController,
                  isPassword: false,
                ),
                // Nhập sdt
                MyTextField(
                  labelText: 'Số điện thoại',
                  hintText: 'Nhập số điện thoại',
                  controller: phoneNumberController,
                  isPassword: false,
                ),
        
                // Nhập password
                MyTextField(
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  controller: passController,
                  isPassword: true,
                ),
                MyTextField(
                  labelText: 'Xác nhận mật khẩu',
                  hintText: 'Nhập lại mật khẩu',
                  controller: passConfirmController,
                  isPassword: true,
                ),
                SizedBox(height: 10,),
                MyButton(text: 'Đăng ký tài khoản', 
                  onPressed: _onClickRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}