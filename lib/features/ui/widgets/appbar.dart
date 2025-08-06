import 'package:app_ban_sach/core/constants/style.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showSearchField;
  final List<Widget>? actions;
  final TextEditingController searchController;

  MyAppBar({
    required this.title,
    this.showSearchField = false,
    this.showBackButton = true,
    this.actions,
    TextEditingController? controller,
    Key? key,
  })  : searchController = controller ?? TextEditingController(),
        super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: MyColors.primaryColor,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : const SizedBox.shrink(),

      title: showSearchField
          ? Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        // Thêm logic xử lý tìm kiếm nếu cần
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => searchController.clear(),
                    splashRadius: 18,
                  ),
                ],
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                color: MyColors.whiteColor,
                fontWeight: MyTextStyle.bold,
                fontSize: MyTextStyle.size_20,
              ),
            ),
      actions: actions,
    );
  }
}
