import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/user_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/cart_product_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isAllChecked = false;
  List<CartItem> listCartProCard = [
    CartItem(
      imageUrl: "assets/sgk_tv_2_1.jpg",
      productName: "Sách TV 2 tập 1",
      price: 25000,
      oldPrice: 30000,
    ),
    CartItem(
      imageUrl: "assets/sgk_tv_2_1.jpg",
      productName: "Sách TV 2 tập 2",
      price: 25000,
      oldPrice: 30000,
    ),
    CartItem(
      imageUrl: "assets/sgk_tv_2_1.jpg",
      productName: "Sách TV 2 tập 3",
      price: 25000,
      oldPrice: 30000,
    ),
  ];
  void onChangedCheckedBox(bool? value){
    setState(() {
      isAllChecked = value ?? true;
      for (var item in listCartProCard) {
        item.isChecked = isAllChecked;
      }
    });
  }
  void onChangedItemChecked(int index, bool? value) {
    setState(() {
      listCartProCard[index].isChecked = value ?? false;
      isAllChecked = listCartProCard.every((e) => e.isChecked);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Giỏ hàng', showBackButton: false),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[ 
                    Checkbox(
                      value: isAllChecked,
                      onChanged: onChangedCheckedBox,
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return MyColors.warningColor; // Màu khi được chọn
                        }
                        return MyColors.whiteColor; // Màu khi không được chọn
                      }),
                    ),
                    Text(
                      "Chọn tất cả ",
                      style: const TextStyle(
                        fontSize: MyTextStyle.size_16,
                        fontWeight: MyTextStyle.semibold,
                      ),
                    ),
                  ]
              ),
              Column(
                children: List.generate(listCartProCard.length, (index) {
                  return CartProductCard(
                    item: listCartProCard[index],
                    onChanged: (value) => onChangedItemChecked(index, value),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
