import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Thông báo', showBackButton: false),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            'Chức năng thông báo sẽ được cập nhật trong tương lai',
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}