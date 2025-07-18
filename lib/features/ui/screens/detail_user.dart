import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/new_address.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';

class DetailUserScreen extends StatefulWidget {
  const DetailUserScreen({super.key});

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String gender = "Nam";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Sửa Hồ Sơ",
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120), // Để tránh che nút
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10), // Thêm dòng này để cách xa AppBar
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MyTextStyle.size_16),
                      child: Text(
                        "Cập nhật thông tin tài khoản",
                        style: TextStyle(
                          fontWeight: MyTextStyle.bold,
                          fontSize: MyTextStyle.size_16, // Tăng font size
                          color: MyColors.textColor,
                        ),
                      ),
                    ),
                  ),
                  MyTextField(
                    labelText: "Họ và tên",
                    hintText: "Nhập họ và tên",
                    controller: nameController,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    labelText: "Email",
                    hintText: "user@gmail.com",
                    controller: emailController,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    labelText: "Số điện thoại",
                    hintText: "0312586999",
                    controller: phoneController,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
                      }
                    },
                    child: AbsorbPointer(
                      child: MyTextField(
                        labelText: "Ngày sinh",
                        hintText: "Chọn ngày sinh",
                        controller: dobController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Giới tính",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: MyColors.textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Nam",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      const Text("Nam"),
                      const SizedBox(width: 20),
                      Radio<String>(
                        value: "Nữ",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      const Text("Nữ"),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Danh sách địa chỉ nhận hàng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: MyColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.greyColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("[Tên người nhận] | [SĐT]", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        const Text("[Số nhà]"),
                        const Text("[Phường, quận, tp]"),
                        const SizedBox(height: 2),
                        const Text(
                          "trạng thái mặc định",
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onPressed: () async {
                              // Đảm bảo không bị double push
                              FocusScope.of(context).unfocus();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NewAddressScreen(),
                                ),
                              );
                            },
                            text: "+ Thêm địa chỉ mới",
                            isOutlined: true,
                          ),
                        ),
                      ],
                    ),
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
                onPressed: () {},
                text: "Lưu",
              ),
            ),
          ),
        ],
      ),
    );
  }
}