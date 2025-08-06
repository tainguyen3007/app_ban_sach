import 'package:app_ban_sach/features/ui/screens/payment/successful_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/checked_order_product_card.dart';
import 'package:app_ban_sach/firebase_cloud/service/cart_service.dart';
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
  @override
  void initState() {
    super.initState();
    loadSelectedAddress();
    _loadCartItems();
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
    return Scaffold(
      appBar: MyAppBar(title: "Thanh toán"),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SuccessfulScreen(),
                          transitionsBuilder: (_, animation, __, child) {
                            final offset = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                                .chain(CurveTween(curve: Curves.ease))
                                .animate(animation);
                            return SlideTransition(position: offset, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
