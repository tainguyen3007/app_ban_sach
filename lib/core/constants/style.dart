import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MyColors {
  static const Color primaryColor = Color(0xFFDF001D); // Màu chính
  static const Color whiteColor = Color(0xFFFFFFFF); // Màu nền - trắng
  static const Color textColor = Colors.black;// Màu đen
  static const Color successColor = Color(0xFF5EC240); // màu xanh lá cây
  static const Color errorColor = Color(0xFFFF0000);
  static const Color warningColor = Color(0xFFF9A825); // màu cam
  static const Color lightGreyColor = Color(0xFFEAEAEA); // Màu xám nhạt
  static const Color greyColor = Color(0xFFD9D9D9); // Màu xám sáng
  static const Color darkGreyColor = Color(0xFF7E7E7E); // Màu xám tối
}

class MyRadius {
  static const BorderRadius defaultRadius = BorderRadius.all(Radius.circular(15.0)); // Bo góc mặc định
  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(5.0)); // Bo góc nhỏ
  static const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(10.0)); // Bo góc trung bình
}

class MyTextStyle {
  static const double size_30 = 30.0; //size tiêu đề
  static const double size_24 = 24; //size tiêu đề
  static const double size_20 = 20; //size tiêu đề

  static const double size_16 = 16.0; // nôi dung chính
  static const double size_13 = 13.0; // phụ đề, label
  static const double size_11 = 11.0; // chú thích, ghi chú

  static const FontWeight bold = FontWeight.bold; // Độ đậm chữ bold
  static const FontWeight semibold = FontWeight.w500; // Độ đậm chữ semibold
  static const FontWeight medium = FontWeight.normal; // Độ đậm chữ medium
  static const FontWeight light = FontWeight.w300; // light text style

  static String formatCurrency(double value) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0);
    return formatter.format(value);
  }
  static String formatNumber(double value) {
  final formatter = NumberFormat('#,###', 'vi_VN'); // Định dạng số theo chuẩn Việt Nam
  return formatter.format(value);
}
}



