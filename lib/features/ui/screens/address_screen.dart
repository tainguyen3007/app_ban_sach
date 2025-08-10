import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:app_ban_sach/firebase_cloud/models/address.dart';
import 'package:app_ban_sach/firebase_cloud/service/address_service.dart';
import 'package:flutter/material.dart';
import 'package:app_ban_sach/data/models/address_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  bool? isEdit; 
  final Address? address;
  AddressScreen({super.key, this.isEdit,this.address});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedCity;
  
  bool isDefaultPayment = false;
  bool isDefaultShipping = false;
  final formKey = GlobalKey<FormState>();
  final msgValidator = 'Bắt buộc*';
  @override
  void initState() {
    super.initState();
    if (widget.isEdit == true && widget.address != null) {
      nameController.text = widget.address!.receiverName;
      phoneController.text = widget.address!.phoneNumber;
      addressController.text = widget.address!.streetAddress;
      cityController.text = widget.address!.city;
      selectedCity = widget.address!.city;
    }
  }

  void _onSaveAddress() async {
  if (!formKey.currentState!.validate()) return;

  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString("userId") ?? "";

  final address = Address(
    id: widget.isEdit == true ? widget.address!.id : "", // Dùng ID cũ nếu sửa
    userId: userId,
    receiverName: nameController.text.trim(),
    phoneNumber: phoneController.text.trim(),
    streetAddress: addressController.text.trim(),
    city: selectedCity ?? "",
  );

  try {
    if (widget.isEdit == true) {
      await AddressService.updateAddress(address); // 🔁 Sửa
    } else {
      await AddressService.saveAddress(address);   // ➕ Thêm
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.isEdit == true
            ? "Cập nhật địa chỉ thành công"
            : "Thêm địa chỉ thành công"),
      ),
    );
    Navigator.pop(context, true);
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.isEdit == true
            ? "Cập nhật địa chỉ thất bại"
            : "Thêm địa chỉ thất bại"),
      ),
    );
  }
}

  Widget buildTextFieldForm({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: TextStyle(
            fontWeight: MyTextStyle.bold,
          ),),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: MyColors.greyColor),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: MyRadius.mediumRadius,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: MyRadius.mediumRadius,
                borderSide: const BorderSide(color: MyColors.textColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: MyRadius.mediumRadius,
                borderSide: const BorderSide(color: MyColors.textColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cities = DataCity.cities;
    return Scaffold(
      appBar: MyAppBar(
        title: (widget.isEdit?? false) ?  "Sửa địa chỉ" : "Thêm địa chỉ mới",
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70, left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        buildTextFieldForm(
                          controller: nameController,
                          labelText: 'Họ và tên',
                          hintText: 'Nhập họ tên',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return msgValidator;
                            }
                            return null;
                          },
                        ),
                        buildTextFieldForm(
                          controller: phoneController,
                          labelText: 'Số điện thoại',
                          hintText: 'Nhập SĐT',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return msgValidator;
                            }
                            return null;
                          },
                        ),
                        buildTextFieldForm(
                          controller: addressController,
                          labelText: 'Địa chỉ nhận hàng',
                          hintText: 'Nhập địa chỉ',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return msgValidator;
                            }
                            return null;
                          },
                        ),
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
                            child: TextFormField(
                              controller: cityController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return msgValidator;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Chọn tỉnh/thành phố",
                                hintStyle: const TextStyle(color: MyColors.greyColor),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                border: OutlineInputBorder(
                                  borderRadius: MyRadius.mediumRadius,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: MyRadius.mediumRadius,
                                  borderSide: const BorderSide(color: MyColors.textColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: MyRadius.mediumRadius,
                                  borderSide: const BorderSide(color: MyColors.textColor, width: 2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
            bottom: 20,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: MyButton(
                text: "Xác nhận",
                onPressed: _onSaveAddress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}