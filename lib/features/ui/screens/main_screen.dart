import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';
import 'package:flutter/material.dart';

class MyMainScreen extends StatelessWidget {
   MyMainScreen({super.key});
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
    Product(
      imageUrl: "assets/sgk_tv_2_1.jpg",
      productName: "Sách TV 2 Tập 2",
      price: "28.000đ",
      oldPrice: "35.000đ",
      discount: "20%",
      soldCount: 18,
    ),
    Product(
      imageUrl: "assets/sgk_tv_2_1.jpg",
      productName: "Sách TV 2 Tập 2",
      price: "28.000đ",
      oldPrice: "35.000đ",
      discount: "20%",
      soldCount: 18,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                      child: Image.asset("assets/logo_offical.png", height: 50, width: 50, fit: BoxFit.scaleDown),
                    ),
                    Text("Tri thuc Store",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: MyTextStyle.size_16,
                      ),
                    ),
                      ],
                    ),
                    
                    Wrap(
                      children: products.map((product) => ProductCard(product: product)).toList(),
                    ),

                  ],
                ),
              ),

            ],
          ),

        ),
      )
    );
  }
}