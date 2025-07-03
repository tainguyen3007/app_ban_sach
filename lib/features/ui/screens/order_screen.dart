import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Lịch sử mua hàng', showBackButton: true),
      body: DefaultTabController(
        initialIndex: 0,
        length: 6, // Số lượng tab
        child: Column(
          children: [
            TabBar(
              isScrollable: true, // Cho phép scroll ngang
              tabs: [
                Tab(text: 'Tất cả'),
                Tab(text: 'Đang xử lý'),
                Tab(text: 'Đã giao'),
                Tab(text: 'Đã hủy'),
                Tab(text: 'Chờ thanh toán'),
                Tab(text: 'Hoàn tất'),
              ],
              indicatorColor: MyColors.primaryColor, // Màu của chỉ báo tab
              labelColor: MyColors.primaryColor, // Màu chữ của tab được chọn
              unselectedLabelColor: Colors.grey, // Màu chữ của tab chưa được chọn
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Danh sách tất cả đơn hàng')),
                  Center(child: Text('Danh sách đơn hàng đang xử lý')),
                  Center(child: Text('Danh sách đơn hàng đã giao')),
                  Center(child: Text('Danh sách đơn hàng đã hủy')),
                  Center(child: Text('Danh sách đơn hàng chờ thanh toán')),
                  Center(child: Text('Danh sách đơn hàng hoàn tất')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}