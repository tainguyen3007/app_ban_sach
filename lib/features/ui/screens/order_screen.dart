import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/firebase_cloud/models/order.dart';
import 'package:app_ban_sach/firebase_cloud/service/order_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> allOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final userId = await UserService.getCurrentUserId();
    final orders = await OrderService.getOrdersByUser(userId);
    setState(() {
      allOrders = orders;
      isLoading = false;
    });
  }

  List<Order> _filterOrders(String status) {
    if (status == "Tất cả") return allOrders;
    return allOrders
        .where((order) => order.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  Widget _buildOrderList(String status) {
    final filteredOrders = _filterOrders(status);
    if (filteredOrders.isEmpty) {
      return const Center(child: Text("Không có đơn hàng."));
    }
    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(filteredOrders[index]);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      color: MyColors.whiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Đơn hàng: #${order..id}"),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: MyColors.errorColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(order.status),
                )
              ],
            ),
          ),
          ListTile(
            title: Text("Đơn hàng #${order.id}",style: TextStyle(fontSize: MyTextStyle.size_13),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tổng tiền: ${order.totalAmount.toStringAsFixed(0)} đ"),
                Text("Trạng thái: ${order.status}"),
                Text("Ngày đặt: ${order.createdAt}"),
              ],
            ),
            onTap: () {
              // TODO: Navigate to order detail screen
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Lịch sử mua hàng', showBackButton: true),
      body: DefaultTabController(
        initialIndex: 0,
        length: 7,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: MyColors.primaryColor,
              labelColor: MyColors.primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Tất cả'),
                Tab(text: 'Chờ xác nhận'),
                Tab(text: 'Đang xử lý'),
                Tab(text: 'Đã giao'),
                Tab(text: 'Đã hủy'),
                Tab(text: 'Chờ thanh toán'),
                Tab(text: 'Hoàn tất'),
              ],
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      children: [
                        _buildOrderList("Tất cả"),
                        _buildOrderList("Chờ xác nhận"),
                        _buildOrderList("Đang xử lý"),
                        _buildOrderList("Đã giao"),
                        _buildOrderList("Đã hủy"),
                        _buildOrderList("Chờ thanh toán"),
                        _buildOrderList("Hoàn tất"),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
