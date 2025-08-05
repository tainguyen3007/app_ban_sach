
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/banner_slider.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/small_product_card.dart';
import 'package:app_ban_sach/features/ui/screens/detail_product_screen.dart';
import 'package:app_ban_sach/firebase_cloud/models/category.dart';
import 'package:app_ban_sach/firebase_cloud/models/product.dart';
import 'package:app_ban_sach/firebase_cloud/service/category_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/product_service.dart';
import 'package:app_ban_sach/features/ui/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Product>> _fetchProducts;
  late final Future<List<Category>> _fetchCategories;

  final ScrollController _trendingScrollController = ScrollController();
  final ScrollController _discountScrollController = ScrollController();

  Timer? _trendingScrollTimer;
  Timer? _discountScrollTimer;

  static const double _autoScrollStep = 200;
  static const Duration _trendingInterval = Duration(seconds: 3);
  static const Duration _discountInterval = Duration(seconds: 4);
  static const double _searchBarHeight = 44;
  static const double _searchBarWidth = 308;
  static const double _cardWidth = 200;

  final List<CategoryGridItem> categoriesGrid = [
  CategoryGridItem(imagePath: 'assets/sn.jpg', label: 'Sinh Nhật\n49 Năm'),
  CategoryGridItem(imagePath: 'assets/game.jpg', label: 'Điểm Danh\nMỗi Ngày'),
  CategoryGridItem(imagePath: 'assets/binhtay.jpg', label: 'Bình Tây'),
  CategoryGridItem(imagePath: 'assets/thienlong.jpg', label: 'Thiên Long'),
  CategoryGridItem(imagePath: 'assets/sale.jpg', label: 'Flash Sale'),
  CategoryGridItem(imagePath: 'assets/giamgia.jpg', label: 'Mã Giảm Giá'),
  CategoryGridItem(imagePath: 'assets/spmoi.jpg', label: 'Sản Phẩm Mời'),
  CategoryGridItem(imagePath: 'assets/sgk.jpg', label: 'SGK 2025'),
  CategoryGridItem(imagePath: 'assets/bansi.jpg', label: 'Bán Sỉ'),
  CategoryGridItem(imagePath: 'assets/manga.jpg', label: 'Manga'),
];


  @override
  void initState() {
    super.initState();
    _fetchProducts = ProductService.getAllProducts();
    _fetchCategories = CategoryService.getAllCategories();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _trendingScrollTimer = Timer.periodic(_trendingInterval, (_) => _autoScrollList(_trendingScrollController));
    _discountScrollTimer = Timer.periodic(_discountInterval, (_) => _autoScrollList(_discountScrollController));
  }

  void _autoScrollList(ScrollController controller) {
    if (!controller.hasClients) return;
    final maxScroll = controller.position.maxScrollExtent;
    final newScroll = controller.offset + _autoScrollStep;
    controller.animateTo(
      newScroll >= maxScroll ? 0 : newScroll,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _trendingScrollTimer?.cancel();
    _discountScrollTimer?.cancel();
    _trendingScrollController.dispose();
    _discountScrollController.dispose();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return Container(
      width: _searchBarWidth,
      height: _searchBarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Tìm kiếm',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
              readOnly: true,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () => FocusScope.of(context).unfocus(),
            splashRadius: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Product> products,
    required ScrollController controller,
    bool isSmallCard = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: MyTextStyle.size_20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
                  child: isSmallCard
                      ? SmallProductCard(product: product)
                      : SizedBox(width: _cardWidth, child: ProductCard(product: product)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(List<Category> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: ListTile(
            title: Text(category.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

 Widget _buildCategoriesGrid() {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 15, bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoriesGrid.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 6,
        crossAxisSpacing: 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final item = categoriesGrid[index];
        return Center( 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.imagePath,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, height: 1.1),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: FutureBuilder<List<Category>>(
          future: _fetchCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('Không có danh mục nào.'));
            }
            return _buildDrawer(snapshot.data!);
          },
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _fetchProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có sản phẩm.'));
          }

          final products = snapshot.data!;
          final trending = List<Product>.from(products)..shuffle();
          final discount = List<Product>.from(products)..shuffle();

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER XANH
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 212, 221, 228),
                        Color.fromARGB(255, 87, 147, 231)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: Image.asset('assets/logo_offical.png', width: 40, height: 40, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'TRI THUC STORE',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: MyColors.primaryColor,
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(color: Color.fromARGB(255, 13, 4, 4), blurRadius: 2, offset: Offset(1, 1)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Builder(
                            builder: (context) => IconButton(
                              icon: const Icon(Icons.category, color: Color.fromARGB(255, 254, 254, 254), size: 28),
                              onPressed: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildSearchBar(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const HomeBannerSlider(),
                      
                    ],
                  ),
                ),
                _buildCategoriesGrid(),
                _buildHorizontalSection(
                  title: 'Xu hướng hôm nay',
                  icon: Icons.trending_up_rounded,
                  color: MyColors.primaryColor,
                  products: trending.take(10).toList(),
                  controller: _trendingScrollController,
                  isSmallCard: true,
                ),
                _buildHorizontalSection(
                  title: 'Sách HOT-Giảm giá',
                  icon: Icons.local_fire_department,
                  color: MyColors.primaryColor,
                  products: discount.take(6).toList(),
                  controller: _discountScrollController,
                  isSmallCard: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.menu_book_rounded, color: MyColors.primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        "Gợi ý sách",
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: MyTextStyle.size_20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.55,
                  padding: const EdgeInsets.all(10),
                  children: products
                      .map(
                        (product) => GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
                          child: ProductCard(product: product),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryGridItem {
  final String imagePath;
  final String label;
 

  const CategoryGridItem({
    required this.imagePath,
    required this.label,
   
  });
}

