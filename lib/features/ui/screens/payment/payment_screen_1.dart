import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/address_data.dart';
import 'package:app_ban_sach/features/ui/screens/address_screen.dart';
import 'package:app_ban_sach/features/ui/screens/payment/payment_screen_2.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';
import 'package:app_ban_sach/features/ui/widgets/button.dart';
import 'package:app_ban_sach/firebase_cloud/models/address.dart';
import 'package:app_ban_sach/firebase_cloud/service/address_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen1 extends StatefulWidget {
  final int currentStep; // 1, 2, 3
  const PaymentScreen1({super.key, required this.currentStep});

  @override
  State<PaymentScreen1> createState() => _PaymentScreen1State();
}

class _PaymentScreen1State extends State<PaymentScreen1> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String selectedAddressId = '';

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
    _futureAddresses = fetchAddress().then((addresses) {
    if (addresses.isNotEmpty && selectedAddressId.isEmpty) {
      setState(() {
        selectedAddressId = addresses.first.id;
      });
    }
    return addresses;
  });
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
                        _buildStep(1, 'Giao hàng'),
                        _buildLine(),
                        _buildStep(2, 'Thanh toán'),
                        _buildLine(),
                        _buildStep(3, 'Kiểm tra'),
                      ],
                    ),
                  ),

                  // Title
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "ĐỊA CHỈ NHẬN HÀNG",
                      style: TextStyle(
                        fontWeight: MyTextStyle.bold,
                        fontSize: MyTextStyle.size_16,
                      ),
                    ),
                  ),
                  FutureBuilder<List<Address>>(
                    future: _futureAddresses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Lỗi: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: const Center(child: Text('Không có địa chỉ nào.')),
                        );
                      }

                      final listAddress = snapshot.data!;
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listAddress.length,
                            itemBuilder: (context, index) {
                              final address = listAddress[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: _buildAddressCard(
                                  address:  address,
                                  onTap: () => onTapItemAddress(address),
                                  groupValue: selectedAddressId,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAddressId = value!;
                                    });
                                  },
                                  onDeleted: () {
                                    setState(() {
                                      _futureAddresses = fetchAddress().then((addresses) {
                                        // Nếu địa chỉ bị xoá là đang được chọn thì chọn địa chỉ đầu tiên
                                        if (!addresses.any((a) => a.id == selectedAddressId) && addresses.isNotEmpty) {
                                          selectedAddressId = addresses.first.id;
                                        }
                                        return addresses;
                                      });
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyButton(
                      isOutlined: true,
                      color: Colors.blue,
                      text: "+ Thêm địa chỉ mới",
                      onPressed: ()async{
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
                    ),
                  )
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
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setString('addressId', selectedAddressId);
                await Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen2(currentStep: 2),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // bắt đầu từ bên phải
                      const end = Offset.zero;       // kết thúc tại vị trí hiện tại
                      const curve = Curves.ease;
                      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 300), // Tùy chỉnh tốc độ
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String label) {
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
  Widget _buildAddressCard({
    required Address address,
    required String groupValue, // địa chỉ ID được chọn
    required Function(String?) onChanged, // callback khi chọn
    required VoidCallback onTap, // nhấn vào để sửa
    VoidCallback? onDeleted,
  }) {
    return InkWell(
      onTap: onTap,
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Xác nhận xóa"),
              content: const Text("Bạn có chắc chắn muốn xóa địa chỉ này không?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // Hủy
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context); // Đóng dialog
                    await AddressService.deleteAddress(address.id);
                    if (onDeleted != null) onDeleted(); // Gọi callback load lại danh sách nếu có
                  },
                  child: const Text("Xóa", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.greyColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<String>(
              fillColor: MaterialStateProperty.all(MyColors.primaryColor),
              value: address.id,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            Column(
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
          ],
        ),
      ),
    );
  }
  void onTapItemAddress(Address selectedAddress) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressScreen(
          isEdit: true,
          address: selectedAddress,
        ),
      ),
    ).then((shouldRefresh) {
      if (shouldRefresh == true) {
        setState(() {
          _futureAddresses = fetchAddress();
        });
      }
    });
  }
}
