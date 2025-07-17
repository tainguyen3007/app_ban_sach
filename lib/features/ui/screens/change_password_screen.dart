import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
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
        title: 'Quên mật khẩu',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
            _buildPasswordField(_oldController, 'Nhập mật khẩu hiện tại', _showOld, () => setState(() => _showOld = !_showOld)),
            const SizedBox(height: 16),
            const Text('Mật khẩu mới', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildPasswordField(_newController, 'Nhập mật khẩu mới', _showNew, () => setState(() => _showNew = !_showNew)),
            const SizedBox(height: 16),
            const Text('Xác nhận mật khẩu mới', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildPasswordField(_confirmController, 'Nhập mật khẩu mới', _showConfirm, () => setState(() => _showConfirm = !_showConfirm)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: const Text('Xác nhận', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
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
}
