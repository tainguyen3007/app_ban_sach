import 'package:app_ban_sach/main.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/change_password_screen.dart';
import 'package:app_ban_sach/features/ui/screens/login_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'vi';

  final List<Map<String, String>> _languages = [
    {'value': 'vi', 'label': 'Tiếng Việt', 'asset': 'assets/vn.jpg'},
    {'value': 'en', 'label': 'English', 'asset': 'assets/anh.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Cài đặt',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                const _SectionTitle(title: 'Ngôn ngữ'),
                ..._languages.map(
                  (lang) => _buildLanguageTile(
                    lang['value']!,
                    lang['label']!,
                    lang['asset']!,
                  ),
                ),
                const Divider(),
                _buildOptionTile(
                  icon: Icons.lock_outline,
                  title: 'Đổi mật khẩu',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangePasswordScreen(),
                      ),
                    );
                  },
                ),
                _buildOptionTile(
                  icon: Icons.person_remove_outlined,
                  title: 'Yêu cầu xóa tài khoản',
                  onTap: _showDeleteAccountDialog,
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Phiên bản 1.0',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(String value, String text, String flagAsset) {
    return ListTile(
      leading: Radio<String>(
        value: value,
        groupValue: _language,
        activeColor: MyColors.primaryColor,
        onChanged: (val) => setState(() => _language = val!),
      ),
      title: Row(
        children: [
          Image.asset(flagAsset, width: 28, height: 20, fit: BoxFit.cover),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
      onTap: () => setState(() => _language = value),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton.icon(
          icon: const Icon(Icons.logout, color: MyColors.primaryColor),
          label: const Text(
            'Đăng xuất',
            style: TextStyle(
              color: MyColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: MyColors.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.white,
          ),
          onPressed: _handleLogout,
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa tài khoản'),
        content: const Text('Bạn có chắc chắn muốn xóa tài khoản?'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // TODO: Thực hiện xóa tài khoản
              Navigator.of(context).pop();
            },
            child: const Text('Xóa tài khoản'),
          ),
        ],
      ),
    );
  }

  void _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainScreen(isLoggedIn: false,)), (route)=> false);
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
