
import 'package:app_ban_sach/data/datasources/product_service.dart';
import 'package:app_ban_sach/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/data/models/cart.dart';
import 'package:app_ban_sach/data/models/product_test.dart';
import 'package:app_ban_sach/features/ui/screens/home_screen.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';
import 'package:app_ban_sach/features/ui/screens/search_screen.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/screens/order_screen.dart';
import 'package:app_ban_sach/features/ui/screens/cart_screen.dart';
import 'package:app_ban_sach/data/datasources/cart_service.dart';
import 'package:app_ban_sach/data/datasources/user_service.dart';

/// Màn hình chi tiết sản phẩm
class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorite = false;
  int quantity = 1;
  // Danh sách sản phẩm gợi ý (static demo)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProductImage(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductInfo(context),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'Gợi ý cho bạn',
                          style: TextStyle(
                            fontWeight: MyTextStyle.bold,
                            fontSize: MyTextStyle.size_16,
                            color: MyColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(context),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        backgroundColor: MyColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.whiteColor, size: 26),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('', style: TextStyle(color: MyColors.whiteColor)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: MyColors.whiteColor, size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.home_outlined, color: MyColors.whiteColor, size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: MyColors.whiteColor, size: 26),
            onPressed: () {
              Navigator.push(context,
               MaterialPageRoute(builder:(_) => const CartScreen() ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, color: MyColors.whiteColor, size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserScreen())        
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      color: MyColors.whiteColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: (widget.product.imageUrl.isNotEmpty)
              ? Image.asset(widget.product.imageUrl, fit: BoxFit.contain)
              : Image.asset('assets/default_images/default_image.png', fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.name,
          style: const TextStyle(fontSize: MyTextStyle.size_16, fontWeight: MyTextStyle.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              MyTextStyle.formatCurrency(widget.product.price),
              style: const TextStyle(fontSize: MyTextStyle.size_16, color: MyColors.primaryColor, fontWeight: MyTextStyle.bold),
            ),
            const SizedBox(width: 8),
            if (widget.product.oldprice > 0 && widget.product.oldprice > widget.product.price)
              Text(
                MyTextStyle.formatCurrency(widget.product.oldprice),
                style: const TextStyle(fontSize: MyTextStyle.size_13, color: MyColors.darkGreyColor, decoration: TextDecoration.lineThrough),
              ),
            const SizedBox(width: 8),
            if (widget.product.discount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '-${widget.product.discount.toStringAsFixed(0)}%',
                  style: const TextStyle(color: MyColors.whiteColor, fontSize: MyTextStyle.size_11, fontWeight: MyTextStyle.bold),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, size: 18, color: Colors.amber),
            const SizedBox(width: 4),
            const Text(
              '4.9',
              style: TextStyle(
                fontSize: MyTextStyle.size_13,
                color: Colors.amber,
                fontWeight: MyTextStyle.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Đã bán ${MyTextStyle.formatNumber(widget.product.soldCount.toDouble())}',
              style: const TextStyle(
                fontSize: MyTextStyle.size_13,
                color: MyColors.darkGreyColor,
                fontWeight: MyTextStyle.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : MyColors.errorColor,
                size: 22,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              tooltip: isFavorite ? 'Bỏ yêu thích' : 'Yêu thích',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.local_shipping_outlined, size: 18, color: MyColors.successColor),
            const SizedBox(width: 4),
            const Text('Dự kiến giao', style: TextStyle(fontSize: MyTextStyle.size_13, color: MyColors.textColor)),
            const Spacer(),
            const Icon(Icons.chevron_right, size: 22, color: MyColors.darkGreyColor),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.verified_outlined, size: 18, color: MyColors.errorColor),
            const SizedBox(width: 4),
            Expanded(
              child: GestureDetector(
                onTap: () => showWarrantyPolicy(context),
                child: const Text(
                  'Đổi trả miễn phí toàn quốc 30 ngày - Giao nhanh và uy tín',
                  style: TextStyle(
                    fontSize: MyTextStyle.size_13,
                    color: MyColors.textColor,
                  ),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 22, color: MyColors.darkGreyColor),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.storefront_outlined, size: 18, color: MyColors.warningColor),
            const SizedBox(width: 4),
            const Text('96 nhà sách còn hàng', style: TextStyle(fontSize: MyTextStyle.size_13, color: MyColors.textColor)),
            const Spacer(),
            const Icon(Icons.chevron_right, size: 22, color: MyColors.darkGreyColor),
          ],
        ),
        const SizedBox(height: 12),
        const Text('Thông tin sản phẩm', style: TextStyle(fontWeight: MyTextStyle.bold, fontSize: MyTextStyle.size_16)),
        const SizedBox(height: 8),
        _buildProductTable(),
      ],
    );
  }

  Widget _buildProductTable() {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(130),
        1: FlexColumnWidth(),
      },
      children: [
        _buildTableRow('Mã hàng:', '8935279153367'),
        _buildTableRow('Nhà cung cấp:', 'NKB Chính Trị Quốc Gia'),
        _buildTableRow('Tác giả:', 'Bộ Giáo Dục Và Đào Tạo'),
        _buildTableRow('Nhà xuất bản:', 'Chính Trị Quốc Gia Sự Thật'),
        _buildTableRow('Năm xuất bản:', '2024'),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(right: 16),
        child: Text(label, style: const TextStyle(color: MyColors.darkGreyColor, fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(value, style: const TextStyle(fontSize: MyTextStyle.size_13)),
      ),
    ]);
  }
  Widget _buildBottomBar(BuildContext context) {
    return Column(
      children: [
        Container(
          color: MyColors.whiteColor,
          padding: const EdgeInsets.only(bottom: 10),
          child: Expanded(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 16),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add, size: 16),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () async {
                    // Lấy userId hiện tại từ UserService
                    int userId = await UserService().getCurrentUserId();
                   final cartItem = Cart(
                    userId: userId,
                    productId: widget.product.id!, // Thêm dấu ! nếu chắc chắn id không null
                    quantity: quantity,
                  );
                  await CartService().insertCart(cartItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã thêm vào giỏ hàng!')),
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: MyColors.primaryColor,
                    side: const BorderSide(color: MyColors.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text('Thêm vào giỏ hàng', style: TextStyle(fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
                  ),
                  
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Mua ngay!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Mua ngay', style: TextStyle(fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: MyColors.whiteColor,
          height: 10,
        )
      ],
    );
  }
}

/// Widget hiển thị danh sách sản phẩm gợi ý
class SuggestionSection extends StatelessWidget {
  final List<Product> products;
  const SuggestionSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: products.map((product) =>
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
          child: ProductCard(product: product),
        )
      ).toList(),
    );
  }
}

/// Hiển thị modal chính sách bảo hành
void showWarrantyPolicy(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Chính sách bảo hành',
                style: TextStyle(
                  fontWeight: MyTextStyle.bold,
                  fontSize: MyTextStyle.size_16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.local_shipping, color: MyColors.primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Giao hàng nhanh và uy tín', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MyTextStyle.size_13)),
                      const SizedBox(height: 2),
                      const Text('TriThuc giao hàng nhanh chóng trong ngày với các đơn tại thành phố Hồ Chí Minh và Hà nội', style: TextStyle(fontSize: MyTextStyle.size_13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.assignment_return, color: MyColors.errorColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Đổi trả miễn phí toàn quốc 30 ngày', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MyTextStyle.size_13)),
                      const SizedBox(height: 2),
                      const Text('TriThuc có chính sách đổi trả cực kỳ tiện lợi. Thời gian đổi trả lên đến 30 ngày và miễn phí thu hồi', style: TextStyle(fontSize: MyTextStyle.size_13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.card_giftcard, color: MyColors.warningColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ưu đãi dành cho khách sỉ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MyTextStyle.size_13)),
                      const SizedBox(height: 2),
                      const Text('Nhận nhiều ưu đãi và chiết khấu tốt hơn khi mua sản phẩm số lượng lớn. Hotline: 1900 63 64 67', style: TextStyle(fontSize: MyTextStyle.size_13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.discount, color: MyColors.successColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Khuyến mãi TriThuc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MyTextStyle.size_13)),
                      const SizedBox(height: 2),
                      const Text('Chính sách khuyến mãi TriThuc không áp dụng cho Hệ Thống Nhà Sách TriThuc trên toàn quốc', style: TextStyle(fontSize: MyTextStyle.size_13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Đã hiểu', style: TextStyle(fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
              ),
            ),
          ],
        ),
      );
    },
  );
}
