import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/firebase_cloud/models/category.dart';
import 'package:app_ban_sach/firebase_cloud/models/product.dart';
import 'package:app_ban_sach/firebase_cloud/service/category_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/product_service.dart';
import 'package:app_ban_sach/features/ui/screens/detail_product_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Product>> fetchProducts() {
    return ProductService.getAllProducts();
  }
  Future<List<Category>> fetchCategories() {
    return CategoryService.getAllCategories();
  }
  Widget customListTile({
    required String title,
    void Function()? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.category, color: Colors.white), // 🔁 icon tùy chọn
            onPressed: () => Scaffold.of(context).openDrawer(),     // mở Drawer
          ),
        ),
        backgroundColor: MyColors.primaryColor,
        title: Row(
          children: [
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
                        controller: TextEditingController(),
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
                      onPressed: () => TextEditingController().clear(),
                      splashRadius: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có sản phẩm nào.'));
                  }

                  final categories = snapshot.data!;
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return customListTile(
                        title: category.name,
                        onTap: () {
                          Navigator.pop(context);
                          // TODO: xử lý khi chọn danh mục
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có sản phẩm nào.'));
          }

          final products = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  child: Row(
                    children: [
                      const Icon(Icons.trending_up_rounded, color: MyColors.primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        "Xu hướng hôm nay",
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: MyTextStyle.size_24,
                          fontWeight: MyTextStyle.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildListViewProductsByCategory(products, 6),
                
                
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.55,
                  children: products.map((p) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: p),
                          ),
                        );
                      },
                      child: ProductCard(product: p),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildListViewProductsByCategory(List<Product> products, int maxCount) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products.take(maxCount).map((product) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ProductCard(product: product),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          width: 200,
          child: MyButton(
            text: "Xem thêm",
            isOutlined: true,
            onPressed: (){
                          
            },
          ),
        ),
      ],
    );
  }
}

