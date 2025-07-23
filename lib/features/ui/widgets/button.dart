import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';

class MyButton extends StatelessWidget {
  final String text; // Văn bản trên nút
  final VoidCallback? onPressed; // Hàm xử lý khi nhấn nút
  final bool isOutlined; // Có phải dạng outline hay không
  final bool isDisabled; // Có phải dạng bị vô hiệu hóa hay không
  final String? imagePath; // Đường dẫn hình ảnh (nếu có)

  const MyButton({
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.isDisabled = false,
    this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      onPressed: isDisabled ? null : onPressed, // Nếu nút bị vô hiệu hóa thì không làm gì
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: MyRadius.defaultRadius, // Bo góc nút
        ),
        backgroundColor: isOutlined
            ? MyColors.whiteColor // Nền trong suốt cho nút outline
            : (isDisabled ? MyColors.greyColor : MyColors.primaryColor),
        minimumSize: const Size(double.infinity, 45), // Chiều cao tối đa 45px
        side: isOutlined
            ? BorderSide(color: MyColors.primaryColor, width: 1) // Viền cho nút outline
            : BorderSide.none, // Không có viền cho nút thường
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null) // Hiển thị hình ảnh nếu có
            Padding(
              padding: const EdgeInsets.only(right: 10.0), // Khoảng cách giữa hình ảnh và văn bản
              child: Image.asset(
                imagePath!,
                width: 30,
                height: 30,
              ),
            ),
          Text(
            text,
            style: TextStyle(
              color: isOutlined
                  ? MyColors.primaryColor // Màu chữ cho nút outline
                  : (isDisabled ? MyColors.darkGreyColor : MyColors.whiteColor), // Màu chữ cho nút thường hoặc bị vô hiệu hóa
              fontSize: MyTextStyle.size_16, // Kích thước chữ
              fontWeight: MyTextStyle.semibold
            ),
          ),
        ],
      ),
    );
  }
}