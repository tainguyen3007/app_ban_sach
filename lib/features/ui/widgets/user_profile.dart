import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/login_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/list_tile.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  String username;
  String name;
  String avatar;
  VoidCallback? onPressed;

  UserProfile({
    this.username = "your username",
    this.name = "your name",
    this.avatar = 'assets/google_logo.jpg',
    this.onPressed,
    super.key
  }
  );
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          child: ListTile(
            onTap: widget.onPressed,
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(widget.avatar),
            ),
            title: Text(
              widget.username, // username
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.name,
              style: TextStyle(fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.semibold),
            ),
          ),
        ),
      ],
    );
  }
}