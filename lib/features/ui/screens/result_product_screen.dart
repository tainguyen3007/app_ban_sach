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

  String _selectedSort = 'Mặc định';

  final List<String> _sortOptions = [
    'Mặc định',
    'Giá thấp → cao',
    'Giá cao → thấp',
    'Bán chạy',
    'Giảm giá nhiều',
  ];

  @override
  void initState() {
    super.initState();
    _searchResults = ProductService.searchProductsByName1(widget.keyword);
  }

  void _onSortChanged(String? newSort) {
    if (newSort != null) {
      setState(() {
        _selectedSort = newSort;
      });
    }
  }

  List<Product> sortProducts(List<Product> products, String sortOption) {
    final sortedList = List<Product>.from(products); // sao chép để không ảnh hưởng gốc

    switch (sortOption) {
      case 'Giá thấp → cao':
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Giá cao → thấp':
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Bán chạy':
        sortedList.sort((a, b) => b.soldCount.compareTo(a.soldCount));
        break;
      case 'Giảm giá nhiều':
        sortedList.sort((a, b) => b.discount.compareTo(a.discount));
        break;
      case 'Mặc định':
      default:
        // Không sắp xếp lại
        break;
    }

    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Kết quả: \"${widget.keyword}\"",
        showSearchField: false,
      ),
      body: Column(
        children: [
          // 🔽 Bộ lọc sắp xếp
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                const Icon(Icons.sort, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Sắp xếp:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedSort,
                      isExpanded: true,
                      items: _sortOptions.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option, style: const TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: _onSortChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔍 Kết quả tìm kiếm
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                }

                var products = sortProducts(snapshot.data ?? [], _selectedSort);

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
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.55,
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
          ),
        ],
      ),
    );
  }
}
