import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/order_detail_screen.dart';
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
final Map<String, bool> _expandedOrders = {};

Widget _buildOrderCard(Order order) {
  final isExpanded = _expandedOrders[order.id] ?? false;

  final displayedItems = isExpanded
      ? order.orderItems
      : order.orderItems.take(1).toList();
  
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrderDetailScreen(order: order),
        ),
      );
    },
    child: Card(
      color: MyColors.whiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trạng thái đơn hàng
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  order.status,
                  style: const TextStyle(color: Colors.white,fontSize: MyTextStyle.size_11,fontWeight: MyTextStyle.semibold),
                ),
              ),
            ),
    
            const SizedBox(height: 8),
            Text("Đơn hàng: #${order.id}", style: TextStyle(
              fontSize: MyTextStyle.size_16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Ngày đặt: ${order.createdAt}", style: TextStyle(
              fontSize: MyTextStyle.size_13, color: MyColors.darkGreyColor)),
            const SizedBox(height: 8),
            const Divider(),
    
            // Danh sách sản phẩm (1 hoặc tất cả)
            Column(
              children: displayedItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.productName,
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text("x${item.quantity}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(MyTextStyle.formatCurrency(item.price),
                                  style: const TextStyle(color: Colors.red)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
    
            // Nút Xem thêm
            if (!isExpanded && order.orderItems.length > 1)
              TextButton(
                onPressed: () {
                  setState(() {
                    _expandedOrders[order.id] = true;
                  });
                },
                child: const Text("Xem thêm sản phẩm",style: TextStyle(color: MyColors.darkGreyColor),),
              ),
            if (isExpanded)
              TextButton(
                onPressed: () {
                  setState(() {
                    _expandedOrders[order.id] = false;
                  });
                },
                child: const Text("Ẩn",style: TextStyle(color: MyColors.darkGreyColor),),
              ),
            const Divider(),
    
            // Tổng tiền
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Tổng tiền: ${MyTextStyle.formatCurrency(order.totalAmount)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MyTextStyle.size_16,
                ),
              ),
            ),
          ],
        ),
      ),
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
