import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/firebase_cloud/models/user.dart' as UserLocal;
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:app_ban_sach/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/firebase_cloud/models/user.dart' as User_firebase;
import 'package:shared_preferences/shared_preferences.dart';

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
  
  Future<void> onClickRegister() async {
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
        final pref = await SharedPreferences.getInstance();
        final userId = pref.setString('userId', email);
        pref.setBool('isLoggedIn', true);
        Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen(isLoggedIn: true, indexPage: 3,userId: userId.toString(),)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Đăng ký'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                padding: const EdgeInsets.all(16),
                color: MyColors.whiteColor,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/logo_offical.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
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
                      MyTextField(
                        labelText: 'Số điện thoại',
                        hintText: 'Nhập số điện thoại',
                        controller: phoneNumberController,
                        isPassword: false,
                      ),
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
                      const SizedBox(height: 10),
                      MyButton(
                        text: 'Đăng ký tài khoản',
                        onPressed: onClickRegister,
                      ),
                      const Spacer(), // Đẩy nội dung lên nếu dư chiều cao
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}