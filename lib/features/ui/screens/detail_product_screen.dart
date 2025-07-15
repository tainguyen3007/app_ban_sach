
import 'package:flutter/material.dart';
import 'package:app_ban_sach/data/models/Product.dart';
import 'package:app_ban_sach/features/ui/screens/home_screen.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';


class ProductDetailScreen extends StatelessWidget {

  static final List<Product> suggestionProducts = [
    Product(
      id: '1',
      name: 'Sách Tiếng Việt 2 - Tập 1',
      description: 'Sách giáo khoa lớp 2 tập 1',
      imageUrl: 'assets/sgk_tv_2_1.jpg',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '2',
      name: 'Logo Chính Thức',
      description: 'Logo nhà xuất bản',
      imageUrl: 'assets/logo_offical.png',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '3',
      name: 'Google Logo',
      description: 'Logo Google',
      imageUrl: 'assets/google_logo.jpg',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '4',
      name: 'Sách Tiếng Việt 2 - Tập 1 (Bản 2)',
      description: 'Sách giáo khoa lớp 2 tập 1 bản 2',
      imageUrl: 'assets/sgk_tv_2_1.jpg',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '5',
      name: 'Logo Sách Mới',
      description: 'Logo sách mới',
      imageUrl: 'assets/logo_offical.png',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '6',
      name: 'Google Sách',
      description: 'Google sách',
      imageUrl: 'assets/google_logo.jpg',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '7',
      name: 'Sách Giáo Khoa 2025',
      description: 'Sách giáo khoa năm 2025',
      imageUrl: 'assets/sgk_tv_2_1.jpg',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '8',
      name: 'Logo Nhà Xuất Bản',
      description: 'Logo nhà xuất bản',
      imageUrl: 'assets/logo_offical.png',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '9',
      name: 'Google Education',
      description: 'Google Education',
      imageUrl: 'assets/google_logo.jpg',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
    Product(
      id: '10',
      name: 'Sách Tiếng Việt 2 - Tập 1 (Bản Đặc Biệt)',
      description: 'Sách giáo khoa lớp 2 tập 1 bản đặc biệt',
      imageUrl: 'assets/sgk_tv_2_1.jpg',
      price: 85000,
      oldPrice: 105000,
      discount: 33,
      soldCount: 99,
    ),
  ];

  final Product product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: MyColors.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: MyColors.whiteColor, size: 26
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            },
          ),
          title: const Text('', style: TextStyle(color: MyColors.whiteColor)),
          actions: [
            IconButton(icon: const Icon(Icons.search, color: MyColors.whiteColor, size: 26), onPressed: () {}),
            IconButton(icon: const Icon(Icons.home_outlined, color: MyColors.whiteColor, size: 26), onPressed: () {}),
            IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: MyColors.whiteColor, size: 26), onPressed: () {}),
            IconButton(icon: const Icon(Icons.account_circle_outlined, color: MyColors.whiteColor, size: 26), onPressed: () {}),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: MyColors.whiteColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                     child: (product.imageUrl.isNotEmpty)
  ? Image.asset(product.imageUrl, fit: BoxFit.contain)
  : Image.asset('assets/sgk_tv_2_1.jpg', fit: BoxFit.contain),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontSize: MyTextStyle.size_16, fontWeight: MyTextStyle.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            MyTextStyle.formatCurrency(product.price),
                            style: const TextStyle(fontSize: MyTextStyle.size_16, color: MyColors.primaryColor, fontWeight: MyTextStyle.bold),
                          ),
                          const SizedBox(width: 8),
                          if (product.oldPrice > 0 && product.oldPrice > product.price)
                            Text(
                              MyTextStyle.formatCurrency(product.oldPrice),
                              style: const TextStyle(fontSize: MyTextStyle.size_13, color: MyColors.darkGreyColor, decoration: TextDecoration.lineThrough),
                            ),
                          const SizedBox(width: 8),
                          if (product.discount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '-${product.discount.toStringAsFixed(0)}%',
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
                            'Đã bán ${MyTextStyle.formatNumber(product.soldCount.toDouble())}',
                            style: const TextStyle(
                              fontSize: MyTextStyle.size_13,
                              color: MyColors.darkGreyColor,
                              fontWeight: MyTextStyle.bold,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.favorite_border, size: 22, color: MyColors.errorColor),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.local_shipping_outlined, size: 18, color: MyColors.successColor),
                          const SizedBox(width: 4),
                          const Text('Dự kiến giao', style: TextStyle(fontSize: MyTextStyle.size_13, color: MyColors.textColor)),
                          
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.verified_outlined, size: 18, color: MyColors.errorColor),
                          const SizedBox(width: 4),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
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
                              },
                              child: const Text(
                                'Đổi trả miễn phí toàn quốc 30 ngày - Giao nhanh và uy tín',
                                style: TextStyle(
                                  fontSize: MyTextStyle.size_13,
                                  color: MyColors.textColor,
                                  // Không có gạch chân
                                ),
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.storefront_outlined, size: 18, color: MyColors.warningColor),
                          const SizedBox(width: 4),
                          const Text('96 nhà sách còn hàng', style: TextStyle(fontSize: MyTextStyle.size_13, color: MyColors.textColor)),
                          const Spacer(),
                          
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Thông tin sản phẩm', style: TextStyle(fontWeight: MyTextStyle.bold, fontSize: MyTextStyle.size_16)),
                      const SizedBox(height: 8),
                      Table(
                        columnWidths: const {
                          0: FixedColumnWidth(130),
                          1: FlexColumnWidth(),
                        },
                        children: [
                          TableRow(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Text('Mã hàng:', style: TextStyle(color: MyColors.darkGreyColor, fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('8935279153367', style: const TextStyle(fontSize: MyTextStyle.size_13)),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Text('Nhà cung cấp:', style: TextStyle(color: MyColors.darkGreyColor, fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('NKB Chính Trị Quốc Gia', style: const TextStyle(fontSize: MyTextStyle.size_13)),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Text('Tác giả:', style: TextStyle(color: MyColors.darkGreyColor, fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('Bộ Giáo Dục Và Đào Tạo', style: const TextStyle(fontSize: MyTextStyle.size_13)),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Text('Nhà xuất bản:', style: TextStyle(color: MyColors.darkGreyColor, fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('Chính Trị Quốc Gia Sự Thật', style: const TextStyle(fontSize: MyTextStyle.size_13)),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Text('Năm xuất bản:', style: TextStyle(color: MyColors.darkGreyColor, fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('2024', style: const TextStyle(fontSize: MyTextStyle.size_13)),
                            ),
                          ]),
                        ],
                      ),
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
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemCount: ProductDetailScreen.suggestionProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: ProductDetailScreen.suggestionProducts[index]);
                        },
                      ),
                      const SizedBox(height: 80),
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
            child: Container(
              color: MyColors.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          icon: const Icon(Icons.remove, size: 18),
                          onPressed: () {},
                        ),
                        const Text('1', style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add, size: 18),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
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
                      child: const Text('Thêm vào giỏ hàng', style: TextStyle(fontSize: MyTextStyle.size_13, fontWeight: MyTextStyle.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
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
        ],
      ),
    );
  }
}
