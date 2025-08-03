import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/data/models/address_data.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({super.key});

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedCity;
  
  bool isDefaultPayment = false;
  bool isDefaultShipping = false;

  @override
  Widget build(BuildContext context) {
    final cities = DataCity.cities;
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
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView(
                            children: cities.map((city) {
                              return ListTile(
                                title: Text(city),
                                onTap: () {
                                  setState(() {
                                    selectedCity = city;
                                    cityController.text = city;
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    child: AbsorbPointer(
                      child: MyTextField(
                        labelText: "Tỉnh/Thành phố",
                        hintText: "Chọn tỉnh/thành phố",
                        controller: cityController,
                      ),
                    ),
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
                      fontSize: MyTextStyle.size_13,
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
                      const Text(
                        "Địa chỉ thanh toán mặc định",
                        style: TextStyle(fontSize: MyTextStyle.size_13),
                      ),
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
                      const Text(
                        "Địa chỉ giao hàng mặc định",
                        style: TextStyle(fontSize: MyTextStyle.size_13),
                      ),
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