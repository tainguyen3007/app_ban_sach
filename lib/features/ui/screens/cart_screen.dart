import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/datasources/cart_service.dart';
import 'package:app_ban_sach/data/datasources/user_service.dart';
import 'package:app_ban_sach/data/datasources/product_service.dart';
import 'package:app_ban_sach/data/models/cart.dart';
import 'package:app_ban_sach/data/models/product.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/cart_product_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isAllChecked = false;
  List<Cart> listCartProCard = [];
  Map<int, Product> productMap = {};
  List<CartItem> displayItems = [];

  double get totalPriceSelected => displayItems
      .where((item) => item.isChecked)
      .fold(0, (sum, item) => sum + (item.price * item.quantity));

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final userId = await UserService().getCurrentUserId();
    final carts = await CartService().getCartByUser(userId);
    final tempProductMap = await _buildProductMap(carts);

    final items = carts.map((cart) {
      final product = tempProductMap[cart.productId]!;
      return CartItem(
        id: cart.id,
        imageUrl: product.imageUrl,
        productName: product.name,
        price: product.price,
        oldPrice: product.oldprice,
        quantity: cart.quantity,
        isChecked: false,
      );
    }).toList();

    setState(() {
      listCartProCard = carts;
      productMap = tempProductMap;
      displayItems = items;
      isAllChecked = false;
    });
  }

  Future<Map<int, Product>> _buildProductMap(List<Cart> carts) async {
    final Map<int, Product> map = {};
    for (var cart in carts) {
      final product = await ProductService().getProductById(cart.productId);
      if (product != null) {
        map[cart.productId] = product;
      }
    }
    return map;
  }

  void _toggleCheckAll(bool? value) {
    setState(() {
      isAllChecked = value ?? false;
      for (var item in displayItems) {
        item.isChecked = isAllChecked;
      }
    });
  }

  void _toggleItemCheck(int index, bool? value) {
    setState(() {
      displayItems[index].isChecked = value ?? false;
      isAllChecked = displayItems.every((item) => item.isChecked);
    });
  }

  Future<void> _removeItem(int index) async {
    final item = displayItems[index];
    if (item.id != null) {
      await CartService().deleteCartItem(item.id!);
      await _loadCartItems();
    }
  }

  Widget _buildCheckAllRow() {
    return Row(
      children: [
        Checkbox(
          value: isAllChecked,
          onChanged: _toggleCheckAll,
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (states) => states.contains(MaterialState.selected)
                ? MyColors.warningColor
                : MyColors.whiteColor,
          ),
        ),
        const Text(
          "Chọn tất cả",
          style: TextStyle(
            fontSize: MyTextStyle.size_16,
            fontWeight: MyTextStyle.semibold,
          ),
        ),
      ],
    );
  }

  Widget _buildCartList() {
    return Expanded(
      child: ListView.builder(
        itemCount: displayItems.length,
        itemBuilder: (context, index) {
          return CartProductCard(
            item: displayItems[index],
            onChanged: (value) => _toggleItemCheck(index, value),
            onRemove: () => _removeItem(index),
          );
        },
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20,left: 12,right: 12,top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thành tiền',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: MyTextStyle.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                MyTextStyle.formatCurrency(totalPriceSelected),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.warningColor,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.warningColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              // TODO: xử lý thanh toán
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            label: const Text(
              'Thanh toán',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Giỏ hàng', showBackButton: true),
      body: Column(
        children: [
          _buildCheckAllRow(),
          _buildCartList(),
          _buildTotalSection(),
        ],
      ),
    );
  }
}
