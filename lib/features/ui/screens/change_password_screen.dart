import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _showOld = false;
  bool _showNew = false;
  bool _showConfirm = false;
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Đổi mật khẩu',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Vui lòng nhập mật khẩu mới cho tài khoản',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Mật khẩu hiện tại', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildPasswordField(
                _oldController,
                'Nhập mật khẩu hiện tại',
                _showOld,
                () => setState(() => _showOld = !_showOld),
              ),
              const SizedBox(height: 16),
              const Text('Mật khẩu mới', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildPasswordField(
                _newController,
                'Nhập mật khẩu mới',
                _showNew,
                () => setState(() => _showNew = !_showNew),
              ),
              const SizedBox(height: 16),
              const Text('Xác nhận mật khẩu mới', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildPasswordField(
                _confirmController,
                'Nhập mật khẩu mới',
                _showConfirm,
                () => setState(() => _showConfirm = !_showConfirm),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _changePassword,
                  child: const Text(
                    'Xác nhận',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildPasswordField(TextEditingController controller, String hint, bool show, VoidCallback onToggle) {
    return TextField(
      controller: controller,
      obscureText: !show,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(show ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggle,
        ),
      ),
    );
  }
  Future<void> _changePassword() async {
    final oldPass = _oldController.text.trim();
    final newPass = _newController.text.trim();
    final confirmPass = _confirmController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng điền đầy đủ thông tin")),
      );
      return;
    }

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Xác nhận mật khẩu không khớp")),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Chưa đăng nhập");

      // ✅ Xác thực lại bằng mật khẩu cũ
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPass,
      );
      await user.reauthenticateWithCredential(cred);

      // ✅ Đổi mật khẩu
      await user.updatePassword(newPass);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đổi mật khẩu thành công")),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String msg = "Đổi mật khẩu thất bại";
      if (e.code == 'wrong-password') {
        msg = "Mật khẩu hiện tại không đúng";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: ${e.toString()}")),
      );
    }
  }

}
