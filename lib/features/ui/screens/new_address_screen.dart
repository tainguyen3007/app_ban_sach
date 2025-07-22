import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({super.key});

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isDefaultPayment = false;
  bool isDefaultShipping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Thêm địa chỉ mới",
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MyTextStyle.size_16),
                      child: Text(
                        "Nhập thông tin địa chỉ",
                        style: TextStyle(
                          fontWeight: MyTextStyle.bold,
                          fontSize: 20,
                          color: MyColors.textColor,
                        ),
                      ),
                    ),
                  ),
                  MyTextField(
                    labelText: "Họ và tên",
                    hintText: "Nhập họ và tên người nhận",
                    controller: nameController,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    labelText: "Số điện thoại",
                    hintText: "Nhập số điện thoại",
                    controller: phoneController,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    labelText: "Tỉnh/Thành phố",
                    hintText: "Chọn tỉnh/thành phố",
                    controller: cityController,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    labelText: "Quận/Huyện",
                    hintText: "Chọn quận/huyện",
                    controller: districtController,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    labelText: "Phường/Xã",
                    hintText: "Chọn phường/xã",
                    controller: wardController,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    labelText: "Địa chỉ nhận hàng",
                    hintText: "Nhập số nhà, tên đường",
                    controller: addressController,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Thiết lập mặc định",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: MyColors.textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isDefaultPayment,
                        onChanged: (value) {
                          setState(() {
                            isDefaultPayment = value ?? false;
                          });
                        },
                      ),
                      const Text("Địa chỉ thanh toán mặc định"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isDefaultShipping,
                        onChanged: (value) {
                          setState(() {
                            isDefaultShipping = value ?? false;
                          });
                        },
                      ),
                      const Text("Địa chỉ giao hàng mặc định"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: MyButton(
                text: "Xác nhận",
                onPressed: () {
                  // Xử lý lưu địa chỉ mới
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}