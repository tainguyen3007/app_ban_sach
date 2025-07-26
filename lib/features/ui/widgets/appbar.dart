import 'package:app_ban_sach/core/constants/style.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  String title; // Tiêu đề của AppBar
  final bool showBackButton; // Hiển thị nút quay lại hay không
  final bool showSearchField;
  final List<Widget>? actions; // Các hành động ở bên phải AppBar
  final TextEditingController searchController = TextEditingController();

  MyAppBar({
    required this.title,
    this.showSearchField = false,
    this.showBackButton = true,
    this.actions,
    super.key,
  });
  @override
  Size get preferredSize => Size.fromHeight(50); // Chiều cao cố định của AppBar 50px
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: MyColors.whiteColor,
          fontWeight: MyTextStyle.bold,
          fontSize: MyTextStyle.size_24,
        ),
      ),
      backgroundColor: MyColors.primaryColor,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Quay lại màn hình trước
              },
            )
          : null,
      actions:[
        Row(
          children: [
            showSearchField ?
              Expanded(
                child: Container(
                  height: 44,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Tìm kiếm',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 16),
                          onSubmitted: (value) {},
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => searchController.clear(),
                        splashRadius: 18,
                      ),
                    ],
                  ),
                ),
              ) : SizedBox.shrink(),
              Row(
                children: actions ??[],
              )
          ],
        ),
      ],
    );
  }
  
  
}