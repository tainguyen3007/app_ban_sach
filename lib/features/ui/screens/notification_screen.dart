import 'package:app_ban_sach/data/models/Notification.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/notification_card.dart';

import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<MyNotification> listNotifi = [
    MyNotification(
      title: "Cập nhât đơn hàng", 
      text: "Bạn vừa đăng kí tài khoản tại Tri Thức Store? Hãy cập nhật email ngay để nhận đc các thông báo quà tặng dành cho khách hàng mới! Click ngay vào đây để cập nhật. Đừng quên tiếp tục tham gia mua sắm để nhận được những ưu đã dành riêng cho khách hàng tại Tri Thức Store.", 
      date: DateTime.now()
      ),
      MyNotification(
      title: "Cập nhât đơn hàng", 
      text: "Bạn vừa đăng kí tài khoản tại Tri Thức Store? Hãy cập nhật email ngay để nhận đc các thông báo quà tặng dành cho khách hàng mới! Click ngay vào đây để cập nhật. Đừng quên tiếp tục tham gia mua sắm để nhận được những ưu đã dành riêng cho khách hàng tại Tri Thức Store.", 
      date: DateTime.now()
      ),
      MyNotification(
      title: "Cập nhât đơn hàng", 
      text: "Bạn vừa đăng kí tài khoản tại Tri Thức Store? Hãy cập nhật email ngay để nhận đc các thông báo quà tặng dành cho khách hàng mới! Click ngay vào đây để cập nhật. Đừng quên tiếp tục tham gia mua sắm để nhận được những ưu đã dành riêng cho khách hàng tại Tri Thức Store.", 
      date: DateTime.now()
      ),

      MyNotification(
      title: "Cập nhât đơn hàng", 
      text: "Bạn vừa đăng kí tài khoản tại Tri Thức Store? Hãy cập nhật email ngay để nhận đc các thông báo quà tặng dành cho khách hàng mới! Click ngay vào đây để cập nhật. Đừng quên tiếp tục tham gia mua sắm để nhận được những ưu đã dành riêng cho khách hàng tại Tri Thức Store.", 
      date: DateTime.now()
      ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Thông báo', showBackButton: true,),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(listNotifi.length, (index) {
                  return NotificationCard(
                    notifi: listNotifi[index],
                  );
                }),
          ),
        ),
      ),
    );
  }
}