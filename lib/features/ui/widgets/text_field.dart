import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';

class MyTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const MyTextField({
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    super.key,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isEmpty = false;

  void _validate() {
    setState(() {
      _isEmpty = widget.controller?.text.trim().isEmpty ?? true;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_validate);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_validate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            color: MyColors.textColor,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: MyColors.greyColor),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: MyRadius.defaultRadius,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: MyRadius.defaultRadius,
              borderSide: BorderSide(
                color: _isEmpty ? MyColors.textColor : MyColors.greyColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: MyRadius.defaultRadius,
              borderSide: BorderSide(
                color: _isEmpty ? MyColors.textColor : MyColors.primaryColor,
                width: 2,
              ),
            ),
          ),
        ),
        if (_isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 5, left: 4),
            child: Text(
              'Không được để trống',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
