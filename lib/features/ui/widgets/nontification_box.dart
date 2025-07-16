import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/main.dart';
import 'package:flutter/material.dart';

class NontificationBox extends StatefulWidget {
  const NontificationBox({super.key});

  @override
  State<NontificationBox> createState() => _NontificationBoxState();
}

class _NontificationBoxState extends State<NontificationBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Cập nhật email ngay để nhận quà từ Tri Thức Store!",
            style: TextStyle(
              fontSize: MyTextStyle.size_13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),        
          SizedBox(height: 20,),
          Text(
            "Bạn vừa đăng kí tài khoản tại Tri Thức Store? Hãy cập nhật email ngay để nhận đc các thông báo quà tặng dành cho khách hàng mới! Click ngay vào đây để cập nhật. Đừng quên tiếp tục tham gia mua sắm để nhận được những ưu đã dành riêng cho khách hàng tại Tri Thức Store.",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: MyTextStyle.size_13,
              fontWeight: MyTextStyle.medium,
            ),
          ),

        SizedBox(height: 20,),
        Container(
          alignment: Alignment.centerRight,
          child: Text("10/06/2025",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: MyColors.darkGreyColor,
            ),
          ),
        ),
      ],),
    );
  }
}

