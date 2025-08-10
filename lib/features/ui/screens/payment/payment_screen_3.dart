import 'package:app_ban_sach/features/ui/screens/payment/successful_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/checked_order_product_card.dart';
import 'package:app_ban_sach/firebase_cloud/models/order.dart';
import 'package:app_ban_sach/firebase_cloud/models/order_item.dart';
import 'package:app_ban_sach/firebase_cloud/service/cart_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/order_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:app_ban_sach/main.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/payment/payment_screen_2.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/firebase_cloud/models/address.dart';
import 'package:app_ban_sach/firebase_cloud/service/address_service.dart';

class PaymentScreen3 extends StatefulWidget {
  final int currentStep;
  final double? total;
  PaymentScreen3({super.key, required this.currentStep, this.total});

  @override
  State<PaymentScreen3> createState() => _PaymentScreen3State();
}

class _PaymentScreen3State extends State<PaymentScreen3> {
  Future<Address?>? addressFuture;
  List<CartItemWithProduct> displayItems = [];
  bool _isLoading = true;
  bool _isError = false;
  TextEditingController noteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadSelectedAddress();
    _loadCartItems();
  }
  void _onPressOrder() async{
    final userId = await UserService.getCurrentUserId();
    final addressId = await AddressService.getSelectedAddressId();
    final paymentMehod = await OrderService.getPaymentMethod();
    final shippingFee = await OrderService.getShippingFee();
    if (displayItems.isEmpty) return;

    
    final order = Order(
      id: '', // sẽ được sinh tự động trong service
      userId: userId,
      totalAmount: widget.total ?? 0,
      discount: 0,
      shippingFee: shippingFee,
      createdAt: DateTime.now().toString(),
      shippingAddressId: addressId,
      paymentMethod: paymentMehod, // hoặc lấy từ người dùng chọn
      status: 'Chờ xác nhận',
      note: noteController.text.trim(),
      orderItems: displayItems.map((item) => OrderItem(
        productId: item.product.id!,
        productName: item.product.name,
        price: item.product.price,
        imageUrl: item.product.imageUrl,
        quantity: item.cart.quantity,
      )).toList(),
    );

    await OrderService.addOrder(order);
    await CartService.clearCheckedCart(userId); // nếu muốn xoá giỏ hàng đã chọn

    // Chuyển đến màn hình thành công
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SuccessfulScreen()),
      );
    }
  }
  void loadSelectedAddress() async {
    final id = await AddressService.getSelectedAddressId();
    setState(() {
      addressFuture = AddressService.getAddressById(id);
    });
  }
  Future<void> _loadCartItems() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      final userId = await UserService.getCurrentUserId();
      final items = await CartService.getCheckedCartWithProductByUser(userId);
      if (mounted) {
        setState(() {
          displayItems = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: MyAppBar(title: "Thanh toán"),
        body: Container(
          color: MyColors.lightGreyColor,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        color: MyColors.lightGreyColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStepProgress(),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "KIỂM TRA ĐƠN HÀNG",
                                style: TextStyle(
                                  fontWeight: MyTextStyle.bold,
                                  fontSize: MyTextStyle.size_16,
                                ),
                              ),
                            ),
                            FutureBuilder<Address?>(
                              future: addressFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError || snapshot.data == null) {
                                  return const Center(child: Text('Không thể tải địa chỉ'));
                                }
                                final address = snapshot.data!;
                                return _buildAddressCard(address);
                              },
                            ),
                            _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: displayItems.length,
                                  itemBuilder: (context, index) {
                                    return CheckedOrderProductCard(item: displayItems[index]);
                                  }
                                ),
                              ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ghi chú đơn hàng",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: noteController, // ← bạn cần tạo controller trong State
                                    autofocus: true,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      hintText: "Nhập ghi chú cho đơn hàng...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.blue),
                                      ),
                                      contentPadding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
      
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: MyColors.whiteColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Thanh toán đơn hàng",
                                        style: TextStyle(
                                          fontWeight: MyTextStyle.bold,
                                          fontSize: MyTextStyle.size_16
                                        ),
                                      ),
                                      Text(
                                        MyTextStyle.formatCurrency(widget.total ?? 0),
                                        style: TextStyle(
                                          fontWeight: MyTextStyle.bold,
                                          fontSize: MyTextStyle.size_16,
                                          color: MyColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: MyButton(
                        text: "Đặt hàng",
                        onPressed: _onPressOrder,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepProgress() {
    return Container(
      height: 75,
      color: MyColors.whiteColor,
      alignment: Alignment.center,
      child: Row(
        children: [
          _buildStep(step: 1, label: 'Giao hàng'),
          _buildLine(),
          _buildStep(step: 2, label: 'Thanh toán'),
          _buildLine(),
          _buildStep(step: 3, label: 'Kiểm tra'),
        ],
      ),
    );
  }

  Widget _buildStep({required int step, required String label}) {
    double r = 32;
    bool isActive = step <= widget.currentStep;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: r,
            height: r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? MyColors.successColor : Colors.white,
              border: Border.all(
                color: isActive ? MyColors.successColor : Colors.grey,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '$step',
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildLine() {
    return Container(width: 20, height: 2, color: Colors.grey);
  }

  Widget _buildAddressCard(Address address) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.whiteColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, size: 28,color: MyColors.primaryColor,),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address.receiverName,
                      style: TextStyle(fontSize: MyTextStyle.size_16, fontWeight: MyTextStyle.bold),
                    ),
                    Text(
                      '| ${address.phoneNumber}',
                      style: TextStyle(fontSize: MyTextStyle.size_13),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(address.streetAddress, style: TextStyle(fontSize: MyTextStyle.size_13)),
                Text(address.city, style: TextStyle(fontSize: MyTextStyle.size_13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
