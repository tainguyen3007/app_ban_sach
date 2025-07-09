import 'dart:convert';
import 'dart:developer';

import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/login_screen.dart';
import 'package:app_ban_sach/features/ui/screens/order_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';
import 'package:app_ban_sach/features/ui/widgets/list_tile.dart';
import 'package:app_ban_sach/features/ui/widgets/order_status_tab.dart';
import 'package:app_ban_sach/features/ui/widgets/user_profile.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final List<Product> products = [
    Product(
      imageUrl: "assets/sgk_tv_2_1.jpg",
      productName: "Sách TV 2 Tập 1",
      price: "25.000đ",
      oldPrice: "30.000đ",
      discount: "17%",
      soldCount: 98,
    ),
    Product(
      imageUrl: "assets/sgk_tv_2_1.jpg",
      productName: "Sách TV 2 Tập 2",
      price: "28.000đ",
      oldPrice: "35.000đ",
      discount: "20%",
      soldCount: 18,
    ),
    // Thêm sản phẩm nếu cần
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Tài khoản ',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: MyColors.whiteColor),
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút cài đặt
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cài đặt')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserProfile(
                name: "Tài Nguyễn",
                username: "tai770@gmail.com",
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen()))
                },
              ),
              const SizedBox(height: 10),
              MyListTile(
                title: 'Đơn hàng của tôi', 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  OrderScreen()),
                  );
                },
                leadingIcon: Icons.shopping_cart,
              ),
              OrderStatusTab(),
              MyListTile(
                title: 'Sản phẩm yêu thích', 
                onTap: (){},
                leadingIcon: Icons.favorite_border,
              ),
              MyListTile(
                title: 'Trung tâm trợ giúp', 
                onTap: (){},
                leadingIcon: Icons.info_outline,
              ),
              MyListTile(
                title: 'Voucher của tôi', 
                onTap: (){},
                leadingIcon: Icons.redeem_rounded,
              ),
              Wrap(
                children: products.map((product) => ProductCard(product: product)).toList(),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
