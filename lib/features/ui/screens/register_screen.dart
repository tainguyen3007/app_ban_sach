import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/user.dart' as User;
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/firebase_cloud/models/user.dart' as User_firebase;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginState();
}

class _LoginState extends State<RegisterScreen> {
  //
  final double paddingHorizontal = 5.0;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();
  
  Future<void> register() async {
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
    try {
      // ✅ Tạo tài khoản với Firebase Auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text,
      );

      final user = credential.user;
      if (user != null) {
        final userModel = User_firebase.User(
          uid: user.uid,
          email: emailController.text,
          password: passController.text,
          name: nameController.text,
          phoneNumber: phoneNumberController.text,
          birthday: "2000/1/1",
          gender: 1,
          role: 'user',
          avatar: 'assets/default_images/default_avatar.jpg',
        );

        // ✅ Lưu Firestore.
        await UserService.saveUser(userModel);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng ký thành công!')),
        );

      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CHưa lưu vào realtime db')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String msg = "Đăng ký thất bại.";
      if (e.code == 'email-already-in-use') {
        msg = "Email đã tồn tại!";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } finally {
      setState(() => isLoading = false);
    }
  }
  Future<void> _onClickRegister() async {
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final phone = phoneNumberController.text.trim();
    final pass = passController.text.trim();
    final passConfirm = passConfirmController.text.trim();

    

    // Thông báo & chuyển sang trang user/profile
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đăng ký thành công!')),
    );

    // Có thể điều hướng về màn hình đăng nhập hoặc trang người dùng
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (_) => UserScreen(user: user)),
    // );
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
                  onPressed: register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}