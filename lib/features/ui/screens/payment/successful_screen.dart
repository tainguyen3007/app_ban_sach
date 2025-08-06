import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/main.dart';
import 'package:flutter/material.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "",showBackButton: false,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                width: 300,
                height: 300,
                "assets/success.png",
                fit: BoxFit.scaleDown,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Thành công!!",
                        style: TextStyle(
                          fontSize: MyTextStyle.size_30,  
                          fontWeight: MyTextStyle.bold,
                        ),
                      ),
                      Text(
                        "Đơn hàng của bạn đặt thành công",
                        style: TextStyle(
                          color: MyColors.darkGreyColor,
                          fontSize: MyTextStyle.size_20,  
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              spacing: 25,
              children: [
                MyButton(
                  text: "Quay lại trang chủ",
                   onPressed: (){
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => MainScreen(isLoggedIn: true, indexPage: 0),
                        transitionsBuilder: (_, animation, __, child) {
                          final offset = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.ease))
                              .animate(animation);
                          return SlideTransition(position: offset, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                      (Route<dynamic> route) => false, // Xóa hết stack
                    );
                   },
                ),
                MyButton(text: "Quay lại về giỏ hàng",isOutlined: true, onPressed: (){},),
              ],
            ),
          )
        ],
      ),
    );
  }
}