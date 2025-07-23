import 'package:app_ban_sach/core/constants/style.dart';
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

  TextEditingController userController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();

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
                  labelText: 'Username',
                  hintText: 'Nhập username',
                  controller: userController,
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
                  onPressed: () async {
                    setState(() {
                      
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}