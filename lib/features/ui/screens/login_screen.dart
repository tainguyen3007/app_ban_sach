import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/register_screen.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
const List<String> scopes = <String>[
  'https://www.googleapis.com/auth/contacts.readonly',
];
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final double paddingHorizontal = 5.0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Đăng nhập'),
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
                  labelText: 'Số điện thoại',
                  hintText: 'Nhập số điện thoại',
                  controller: TextEditingController(),
                  isPassword: false,
                ),
                // Nhập password
                MyTextField(
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  controller: TextEditingController(),
                  isPassword: true,
                ),
                // Đăng nhập button
                MyButton(
                  text: 'Đăng nhập', 
                  isOutlined: false, //nút outline
                  isDisabled: false, // nút bị vô hiêu hóa
                  onPressed: () {
                    // Xử lý đăng nhập ở đây
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đăng nhập thành công!')),
                    );
                  },
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
                  onPressed: () async {
                    
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