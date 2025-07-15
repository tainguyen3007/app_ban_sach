import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/Product.dart';
import 'package:app_ban_sach/features/ui/screens/detail_product_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/card_product.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Sgk tâp 1',
      description: 'Sách gk',
      price: 25000,
      oldPrice: 30000,
      discount: 10,
      imageUrl: ""
    ),
    Product(
      id: '1',
      name: 'Sgk tâp 1',
      description: 'Sách gk',
      price: 25000,
      oldPrice: 30000,
      discount: 10,
      imageUrl: ""
    ),
    Product(
      id: '1',
      name: 'Sgk tâp 1',
      description: 'Sách gk',
      price: 25000,
      oldPrice: 30000,
      discount: 10,
      imageUrl: ""
    ),
    Product(
      id: '1',
      name: 'Sgk tâp 1',
      description: 'Sách gk',
      price: 25000,
      oldPrice: 30000,
      discount: 10,
      imageUrl: ""
    ),
    Product(
      id: '1',
      name: 'Sgk tâp 1',
      description: 'Sách gk',
      price: 25000,
      oldPrice: 30000,
      discount: 10,
      imageUrl: ""
    ),
    Product(
      id: '1',
      name: 'Sgk tâp 1',
      description: 'Sách gk',
      price: 25000,
      oldPrice: 30000,
      discount: 10,
      imageUrl: ""
    ),
    Product(
      id: '1',
      name: 'Sgk tâp 1',
      description: 'Sách gk',
      price: 25000,
      oldPrice: 30000,
      discount: 10,
      imageUrl: ""
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Image.asset(
                height: 50,
                width: 50,
                fit: BoxFit.scaleDown,
                'assets/logo_offical.png'),
              Wrap(
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
              ),
                
            ]
          ),
        )
      )
    );
  }
}