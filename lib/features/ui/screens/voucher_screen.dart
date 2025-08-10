import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/features/ui/widgets/appbar.dart';

class Voucher {
  final String title;
  final String condition;
  final String code;
  final String expiry;

  const Voucher({
    required this.title,
    required this.condition,
    required this.code,
    required this.expiry,
  });
}

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  static const List<Voucher> mockVouchers = [
    Voucher(
      title: 'Mã Giảm 10K - Toàn Sàn',
      condition: 'Đơn hàng từ 130k - Không bao gồm sách Manga, Ngoại văn...',
      code: 'FHS10KT07',
      expiry: '31/07/2025',
    ),
    Voucher(
      title: 'Mã Giảm 20K - Toàn Sàn',
      condition: 'Đơn hàng từ 249k - Không bao gồm sách Manga, Ngoại văn...',
      code: 'FHS20KT07',
      expiry: '31/07/2025',
    ),
    Voucher(
      title: 'Mã Giảm 30K - Toàn Sàn',
      condition: 'Đơn hàng từ 249k - Không bao gồm sách Manga, Ngoại văn...',
      code: 'FHS30KT07',
      expiry: '31/07/2025',
    ),
    Voucher(
      title: 'Mã Giảm 50K - Toàn Sàn',
      condition: 'Đơn hàng từ 249k - Không bao gồm sách Manga, Ngoại văn...',
      code: 'FHS50KT07',
      expiry: '31/07/2025',
    ),
    Voucher(
      title: 'Mã Giảm 100K - Toàn Sàn',
      condition: 'Đơn hàng từ 900k - Không bao gồm sách Manga, Ngoại văn...',
      code: 'FHS100KT07',
      expiry: '31/07/2025',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Ví Voucher',
      ),
      body: Container(
        color: Colors.white,
        child: mockVouchers.isEmpty
            ? const Center(child: Text('Chưa có voucher nào'))
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: mockVouchers.length,
                itemBuilder: (context, index) {
                  final voucher = mockVouchers[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.confirmation_number, color: Colors.green),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  voucher.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: MyTextStyle.size_16,
                                    color: MyColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            voucher.condition,
                            style: TextStyle(fontSize: MyTextStyle.size_13),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              text: 'Mã voucher - ',
                              style: TextStyle(
                                color: MyColors.textColor,
                                fontSize: MyTextStyle.size_13,
                              ),
                              children: [
                                TextSpan(
                                  text: voucher.code,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text('HSD: ${voucher.expiry}',
                              style: TextStyle(fontSize: MyTextStyle.size_13)),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Đã copy mã ${voucher.code}')),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.green,
                                side: const BorderSide(color: Colors.green),
                              ),
                              child: const Text('Copy mã'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}