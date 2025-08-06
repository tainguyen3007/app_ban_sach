import 'package:app_ban_sach/features/ui/screens/result_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/core/constants/style.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> popularSearches = [
    {'title': 'Các Tác Phẩm Kinh Điển', 'image': 'assets/haisophan.jpg'},
    {'title': 'Giấy Bao Tập Xinh', 'image': 'assets/giaybaotap.png'},
    {'title': 'Mua Bút Tặng Bút', 'image': 'assets/muabuttangbut.png'},
    {'title': '50 Đề Minh Họa THPT Môn Vật Lý', 'image': 'assets/dethi.jpg'},
    {'title': 'Bút Pilot', 'image': 'assets/but01.jpg'},
    {'title': 'Sách Học Ngoại Ngữ', 'image': 'assets/sachhoc.png'},
  ];

  final List<Map<String, String>> featuredCategories = [
    {'title': 'Bao Lô Xịn', 'image': 'assets/balo.png'},
    {'title': 'Manga Mới', 'image': 'assets/maga.png'},
    {'title': 'Tủ Sách', 'image': 'assets/tusach.png'},
    {'title': 'Ngoại Văn', 'image': 'assets/ngoaivan.png'},
  ];

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSearchItem(Map<String, String> item) {
    return Material(
      color: Colors.white,
      elevation: 1.5,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(item['image']!, width: 38, height: 38, fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Text(
                item['title']!,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, String> item) {
    return Material(
      color: Colors.white,
      elevation: 1.5,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(item['image']!, width: 48, height: 48, fit: BoxFit.cover),
            ),
            const SizedBox(height: 6),
            Text(
              item['title']!,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryColor,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
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
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Tìm kiếm',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 16),
                          textInputAction: TextInputAction.search, // 👉 để bàn phím hiển thị nút search
                          onSubmitted: (value) {
                            final keyword = value.trim();
                            if (keyword.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ResultProductScreen(keyword: keyword),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => _searchController.clear(),
                        splashRadius: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lịch sử tìm kiếm
            Row(
              children: [
                const Icon(Icons.access_time, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                const Text('Lịch sử tìm kiếm', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.grey),
                  onPressed: () {},
                  splashRadius: 18,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSectionTitle(Icons.show_chart, 'Tìm kiếm phổ biến'),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.8,
              ),
              itemCount: popularSearches.length,
              itemBuilder: (context, index) => _buildSearchItem(popularSearches[index]),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle(Icons.grid_view, 'Danh mục nổi bật'),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: featuredCategories.length,
              itemBuilder: (context, index) => _buildCategoryItem(featuredCategories[index]),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
