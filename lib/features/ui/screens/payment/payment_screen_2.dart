import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/payment/payment_screen_3.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/product_pages/order_product_card.dart';
import 'package:app_ban_sach/firebase_cloud/service/cart_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:app_ban_sach/firebase_cloud/models/order_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen2 extends StatefulWidget {
  final int currentStep;
  const PaymentScreen2({super.key, required this.currentStep});

  @override
  State<PaymentScreen2> createState() => _PaymentScreen2State();
}

class _PaymentScreen2State extends State<PaymentScreen2> {
  List<CartItemWithProduct> displayItems = [];
  bool _isLoading = true;
  bool _isError = false;

  String selectedPaymentMethod = "Thanh toán khi nhận hàng";

  double get subtotal => displayItems.fold(0, (sum, item) => sum + item.product.price * item.cart.quantity);
  double get shippingFee => 30000;
  double get total => subtotal + shippingFee;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
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
      body: Container(
        color: MyColors.lightGreyColor,
        child: Column(
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
                          _buildSectionTitle("SẢN PHẨM"),
                          _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: displayItems.length,
                                  itemBuilder: (context, index) =>
                                      OrderProductCard(item: displayItems[index]),
                                ),
                          _buildSectionTitle("PHƯƠNG THỨC VẬN CHUYỂN"),
                          _buildCardSection(child: _buildDeliveryCard("Giao hàng tiêu chuẩn", "25/8/2025")),
                          _buildSectionTitle("PHƯƠNG THỨC THANH TOÁN"),
                          _buildCardSection(
                            child: Column(
                              children: [
                                _buildPaymentMethodCard("Thanh toán khi nhận hàng", "assets/money.png"),
                                _buildPaymentMethodCard("Ví Momo", "assets/momo.png"),
                                _buildPaymentMethodCard("VNPAY", "assets/vnpay.png"),
                              ],
                            ),
                          ),
                          _buildSectionTitle("GIÁ TRỊ ĐƠN HÀNG"),
                          _buildCardSection(
                            child: Column(
                              children: [
                                _buildPriceTile("Tổng đơn hàng", subtotal),
                                _buildPriceTile("Phí vận chuyển", shippingFee),
                                Container(
                                  color: MyColors.darkGreyColor,
                                  height: 1,
                                ),
                                _buildPriceTile("Tổng tiền", total),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: MyButton(
                      text: "Xác nhận đơn hàng",
                      onPressed: () async{
                        final pref = await SharedPreferences.getInstance();
                        await pref.setString("paymentMethod", selectedPaymentMethod);
                        await pref.setDouble("shippingFee", shippingFee);

                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => PaymentScreen3(currentStep: 3,total: total,),
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
          _buildStep(step: 1, label: 'Giao hàng', isActive: true),
          _buildLine(),
          _buildStep(step: 2, label: 'Thanh toán', isActive: true),
          _buildLine(),
          _buildStep(step: 3, label: 'Kiểm tra', isActive: false),
        ],
      ),
    );
  }

  Widget _buildStep({required int step, required String label, required bool isActive}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
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

  Widget _buildLine() => Container(width: 20, height: 2, color: Colors.grey);

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: MyTextStyle.bold,
          fontSize: MyTextStyle.size_16,
        ),
      ),
    );
  }

  Widget _buildCardSection({required Widget child}) {
    return Container(
      color: MyColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: child,
      ),
    );
  }

  Widget _buildDeliveryCard(String name, String date) {
    return Row(
      children: [
        Radio(
          fillColor: MaterialStateProperty.all(MyColors.primaryColor),
          value: null,
          groupValue: null,
          onChanged: (_) {},
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text('Dự kiến giao: $date'),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard(String value, String imageUrl) {
    return Row(
      children: [
        Radio<String>(
          fillColor: MaterialStateProperty.all(MyColors.primaryColor),
          value: value,
          groupValue: selectedPaymentMethod,
          onChanged: (val) => setState(() => selectedPaymentMethod = val!),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imageUrl,
            width: 50,
            height: 25,
            fit: BoxFit.scaleDown,
          ),
        ),
        const SizedBox(width: 10),
        Text(value),
      ],
    );
  }

  Widget _buildPriceTile(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: MyTextStyle.size_16)),
          Text(MyTextStyle.formatCurrency(amount), style: TextStyle(fontSize: MyTextStyle.size_16)),
        ],
      ),
    );
  }
}
