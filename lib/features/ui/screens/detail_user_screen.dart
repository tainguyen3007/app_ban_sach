import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/screens/address_screen.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/features/ui/widgets/text_field.dart';
import 'package:app_ban_sach/firebase_cloud/models/address.dart';
import 'package:app_ban_sach/firebase_cloud/service/address_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<List<Address>>? _futureAddresses;

  Future<List<Address>> fetchAddress() async {
    try {
      final userId = await UserService.getCurrentUserId();

      final loadedAddresses = await AddressService.getAddressesByUser(userId);

      return loadedAddresses;
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    _futureAddresses = fetchAddress();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Sửa Hồ Sơ"),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MyTextStyle.size_16),
                      child: Text(
                        "Cập nhật thông tin tài khoản",
                        style: TextStyle(
                          fontWeight: MyTextStyle.bold,
                          fontSize: MyTextStyle.size_16,
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
                  MyTextField(
                    labelText: "Email",
                    hintText: "user@gmail.com",
                    controller: emailController,
                  ),
                  MyTextField(
                    labelText: "Số điện thoại",
                    hintText: "0312586999",
                    controller: phoneController,
                  ),
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
                  const Text(
                    "Danh sách địa chỉ nhận hàng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: MyColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FutureBuilder<List<Address>>(
                    future: _futureAddresses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Lỗi: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Không có địa chỉ nào.'));
                      }

                      final addresses = snapshot.data!;
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addresses.length,
                            itemBuilder: (context, index) {
                              final address = addresses[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: _buildAddressCard(address, () async{
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddressScreen(),
                                    ),
                                  ).then((shouldRefresh) {
                                    if (shouldRefresh == true) {
                                      setState(() {
                                        _futureAddresses = fetchAddress();
                                      });
                                    }
                                  });
                                }),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: MyButton(
                        color: Colors.blue,
                        onPressed: () async {
                          // Đảm bảo không bị double push
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressScreen(),
                            ),
                          ).then((shouldRefresh) {
                            if (shouldRefresh == true) {
                              setState(() {
                                _futureAddresses = fetchAddress();
                              });
                            }
                          });
                        },
                        text: "+ Thêm địa chỉ mới",
                        isOutlined: true,
                      ),
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
  Widget _buildAddressCard(Address address, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.greyColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  address.receiverName,
                  style: TextStyle(fontWeight: MyTextStyle.bold),
                ),
                Text(" | ${address.phoneNumber}"),
              ],
            ),
            Text(address.streetAddress),
            Text(address.city),
          ],
        ),
      ),
    );
  }

}