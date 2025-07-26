import 'package:app_ban_sach/data/datasources/favorite_product_service.dart';
import 'package:app_ban_sach/data/models/product.dart';
import 'package:app_ban_sach/features/ui/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/data/models/product_test.dart';
import 'package:app_ban_sach/core/constants/style.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({super.key});

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  // Demo list, replace with your favorite products list from state/provider
  List<ProductTest> favoriteProducts = [];
  void removeFromFavorite(int index) {
    setState(() {
      favoriteProducts.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('Sản phẩm yêu thích', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: favoriteProducts.isEmpty ? 
      Center(
        child: const Text("Bạn chưa thêm sản phẩm yêu thích nào"),
      )
      :ListView.separated(
        itemCount: favoriteProducts.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return 
          FavoriteProductCard(
            onPressedDelete: () => removeFromFavorite(index), 
            item: product,
          );
        },
      ),
    );
  }
}
