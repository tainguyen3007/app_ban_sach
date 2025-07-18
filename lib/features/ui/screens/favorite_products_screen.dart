import 'package:app_ban_sach/features/ui/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/data/models/Product.dart';
import 'package:app_ban_sach/core/constants/style.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  // Demo list, replace with your favorite products list from state/provider
  List<Product> favoriteProducts = [
    Product(
      id: '1',
      name: 'Giáo Trình Triết Học Mác - Lênin (Dành Cho Bậc Đại Học Hệ Không Chuyên Lý Luận Chính Trị)',
      description: '',
      imageUrl: 'assets/sgk_tv_2_1.jpg',
      price: 70000,
      oldPrice: 0,
      discount: 0,
      soldCount: 0,
    ),
    Product(
      id: '2',
      name: 'Giáo Trình Triết Học Mác - Lênin (Dành Cho Bậc Đại Học Hệ Không Chuyên Lý Luận Chính Trị)',
      description: '',
      imageUrl: 'assets/sgk_tv_2_1.jpg',
      price: 70000,
      oldPrice: 0,
      discount: 0,
      soldCount: 0,
    ),
    Product(
      id: '3',
      name: 'Giáo Trình Triết Học Mác - Lênin (Dành Cho Bậc Đại Học Hệ Không Chuyên Lý Luận Chính Trị)',
      description: '',
      imageUrl: 'assets/sgk_tv_2_1.jpg',
      price: 70000,
      oldPrice: 0,
      discount: 0,
      soldCount: 0,
    ),
    Product(
      id: '4',
      name: 'Giáo Trình Triết Học Mác - Lênin (Dành Cho Bậc Đại Học Hệ Không Chuyên Lý Luận Chính Trị)',
      description: '',
      imageUrl: 'assets/sgk_tv_2_1.jpg',
      price: 70000,
      oldPrice: 0,
      discount: 0,
      soldCount: 0,
    ),
  ];

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
      body: ListView.separated(
        itemCount: favoriteProducts.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return FavoriteProductCard(onPressedDelete: () => removeFromFavorite(index), product: product);
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(6),
          //         child: Image.asset(
          //           product.imageUrl,
          //           width: 60,
          //           height: 80,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //       const SizedBox(width: 12),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               product.name,
          //               maxLines: 2,
          //               overflow: TextOverflow.ellipsis,
          //               style: TextStyle(fontWeight: MyTextStyle.bold, fontSize: MyTextStyle.size_13),
          //             ),
          //             const SizedBox(height: 8),
          //             Text(
          //               MyTextStyle.formatCurrency(product.price),
          //               style: TextStyle(
          //                 color: MyColors.primaryColor,
          //                 fontWeight: MyTextStyle.bold,
          //                 fontSize: MyTextStyle.size_13,
          //               ),
          //             ),
          //             const SizedBox(height: 8),
          //             SizedBox(
          //               width: 100,
          //               height: 36,
          //               child: OutlinedButton(
          //                 onPressed: () {
          //                   ScaffoldMessenger.of(context).showSnackBar(
          //                     const SnackBar(content: Text('Đã thêm vào giỏ hàng!')),
          //                   );
          //                 },
          //                 style: OutlinedButton.styleFrom(
          //                   foregroundColor: MyColors.primaryColor,
          //                   side: const BorderSide(color: MyColors.primaryColor),
          //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          //                 ),
          //                 child: const Text('Mua', style: TextStyle(fontWeight: MyTextStyle.bold)),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       IconButton(
          //         icon: const Icon(Icons.delete_outline, color: MyColors.errorColor),
          //         onPressed: () => removeFromFavorite(index),
          //         tooltip: 'Xóa khỏi yêu thích',
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
