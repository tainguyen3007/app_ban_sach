import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/datasources/product_service.dart';
import 'package:app_ban_sach/data/models/product.dart';
import 'package:app_ban_sach/features/ui/screens/detail_product_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Product>> fetchProducts() {
    return ProductService().getAllProducts();
  }
  void openFullScreenDrawer() {
    showDialog(
      context: context,
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text('Danh mục sản phẩm'),
                backgroundColor: MyColors.primaryColor,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text('Nội dung danh mục ở đây'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: MyColors.primaryColor),
              child: const Text(
                "Danh mục",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Sách văn học"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Sách kỹ năng"),
              onTap: () {
                Navigator.pop(context);
              },
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
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
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
                    },
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.6,
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
}
