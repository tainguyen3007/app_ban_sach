import 'package:flutter/material.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/firebase_cloud/models/product.dart';
import 'package:app_ban_sach/firebase_cloud/service/product_service.dart';
import 'package:app_ban_sach/features/ui/screens/detail_product_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';

class ResultProductScreen extends StatefulWidget {
  final String keyword;

  const ResultProductScreen({Key? key, required this.keyword}) : super(key: key);

  @override
  State<ResultProductScreen> createState() => _ResultProductScreenState();
}

class _ResultProductScreenState extends State<ResultProductScreen> {
  late Future<List<Product>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = ProductService.searchProductsByName1(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Kết quả: \"${widget.keyword}\"",
        showSearchField: false,
      ),
      body: FutureBuilder<List<Product>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text(
                'Không tìm thấy sản phẩm nào.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,              // 2 sản phẩm mỗi hàng
              crossAxisSpacing: 10,           // khoảng cách ngang
              mainAxisSpacing: 12,            // khoảng cách dọc
              childAspectRatio: 0.55,          // tỷ lệ khung của mỗi card
            ),
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
                child: ProductCard(product: product),
              );
            },
          );
        },
      ),
    );
  }
}
