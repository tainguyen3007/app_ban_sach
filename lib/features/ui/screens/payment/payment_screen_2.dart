import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/address_data.dart';
import 'package:app_ban_sach/features/ui/screens/add_address_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/firebase_cloud/models/address.dart';
import 'package:app_ban_sach/firebase_cloud/service/address_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:flutter/material.dart';

class PaymentScreen2 extends StatefulWidget {
  final int currentStep; // 1, 2, 3
  const PaymentScreen2({super.key, required this.currentStep});

  @override
  State<PaymentScreen2> createState() => _PaymentScreen2State();
}

class _PaymentScreen2State extends State<PaymentScreen2> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Thanh toán"),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              color: MyColors.lightGreyColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step progress
                  Container(
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "PHƯƠNG THỨC VẬN CHUYỂN",
                      style: TextStyle(
                        fontWeight: MyTextStyle.bold,
                        fontSize: MyTextStyle.size_16
                      ),
                    ),
                  ),
                  Container(
                    color: MyColors.whiteColor,
                    child: Column(
                      children: [
                        _buildDeliveryCard(deliveryName: "Giao hàng tiêu chuẩn", expectedDate: "25/8/2025")
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "PHƯƠNG THỨC THANH TOÁN",
                      style: TextStyle(
                        fontWeight: MyTextStyle.bold,
                        fontSize: MyTextStyle.size_16
                      ),
                    ),
                  ),
                  Container(
                    color: MyColors.whiteColor,
                    child: Column(
                      children: [

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Nút "Giao hàng" đặt dưới cùng
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: MyButton(
              text: "Giao đến địa chỉ này",
              onPressed: () {
                // TODO: xử lý tiếp theo
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({required int step, required String label, required bool isActive}) {
    double r = 32;
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
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      width: 20,
      height: 2,
      color: Colors.grey,
    );
  }
  Widget _buildDeliveryCard({required String deliveryName, required String expectedDate}){
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Radio(
            fillColor: MaterialStateProperty.all(MyColors.primaryColor),
            value: null, 
            groupValue: null, 
            onChanged: (value) => {}
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(deliveryName),
              Text('Dự kiến giao: $expectedDate'),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildPaymentMethodCard({required String paymentMethod}){
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Radio(
            fillColor: MaterialStateProperty.all(MyColors.primaryColor),
            value: null, 
            groupValue: null, 
            onChanged: (value) => {}
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(paymentMethod),
            ],
          ),
        ],
      ),
    );
  }
}
