import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';

class MyTextField extends StatelessWidget {
  final String labelText; // Nhãn của TextField
  final String hintText; // Gợi ý trong TextField
  final bool isPassword; // Có phải trường mật khẩu hay không
  final TextEditingController? controller; // Bộ điều khiển TextField

  const MyTextField({
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: MyColors.textColor,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: controller,
          obscureText: isPassword, // Hiển thị dấu * nếu là trường mật khẩu
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: MyColors.greyColor),
            border: OutlineInputBorder(
              borderRadius: MyRadius.defaultRadius,
              borderSide: const BorderSide(color: MyColors.textColor),
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}