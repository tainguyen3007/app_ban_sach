import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imagePaths; // Danh sách đường dẫn hình ảnh

  const ImageSlider({
    required this.imagePaths,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Chiều cao của slide
      child: PageView.builder(
        itemCount: imagePaths.length, // Số lượng hình ảnh
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0), // Khoảng cách giữa các hình
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bo góc hình ảnh
              child: Image.asset(
                imagePaths[index],
                width: 320, // Chiều rộng của hình ảnh
                height: 150, // Chiều cao của hình ảnh
                fit: BoxFit.cover, // Căn chỉnh hình ảnh
              ),
            ),
          );
        },
      ),
    );
  }
}