import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/firebase_cloud/models/order.dart';
import 'package:app_ban_sach/firebase_cloud/models/address.dart';
import 'package:app_ban_sach/firebase_cloud/service/address_service.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  Address? address;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    final addr = await AddressService.getAddressById(widget.order.shippingAddressId);
    setState(() {
      address = addr;
    });
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Scaffold(
      appBar: MyAppBar(title: 'Chi tiết đơn hàng', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Mã đơn + ngày đặt + trạng thái
            Text("Đơn hàng: #${order.id}", style: TextStyle(fontSize: MyTextStyle.size_16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Ngày đặt: ${order.createdAt}", style: TextStyle(color: MyColors.darkGreyColor)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.grey),
                const SizedBox(width: 6),
                Text("Trạng thái: ${order.status}", style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Địa chỉ nhận hàng',style: TextStyle(fontWeight: MyTextStyle.bold),),
            if (address != null) ...[
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${address!.receiverName} | ${address!.phoneNumber}"),
                      Text(address!.streetAddress),
                      Text(address!.city),
                    ],
                  ),
                ],
              ),
            ] else
              const Text("Đang tải địa chỉ..."),
            const Divider(),

            // Sản phẩm trong đơn hàng
            Text("Sản phẩm", style: TextStyle(fontSize: MyTextStyle.size_16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...order.orderItems.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(item.imageUrl, width: 60, height: 60, fit: BoxFit.scaleDown),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.productName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Số lượng: x${item.quantity}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(MyTextStyle.formatCurrency(item.price), style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),

            const Divider(),

            // Thông tin thanh toán
            Text("Thanh toán", style: TextStyle(fontSize: MyTextStyle.size_16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildRow("Tổng tiền hàng:", MyTextStyle.formatCurrency(order.totalAmount)),
            _buildRow("Giảm giá:", "-${MyTextStyle.formatCurrency(order.discount)}"),
            _buildRow("Phí vận chuyển:", MyTextStyle.formatCurrency(order.shippingFee)),
            const Divider(),
            _buildRow("Tổng thanh toán:", MyTextStyle.formatCurrency(order.totalAmount - order.discount + order.shippingFee), isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
