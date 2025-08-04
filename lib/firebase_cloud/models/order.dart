import 'package:app_ban_sach/firebase_cloud/models/address.dart';

class Order {
  String id;
  String userId;
  double totalAmount;
  double discount;
  double shippingFee;
  String createdAt;
  Address shippingAddress;
  String paymentMethod;
  String status;
  String note;

  Order({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.discount,
    required this.shippingFee,
    required this.createdAt,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.status,
    required this.note,
  });

  // Convert from Map (Firestore) to Order object
  factory Order.fromMap(Map<String, dynamic> map, String docId) {
    return Order(
      id: docId,
      userId: map['userId'] ?? '',
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      shippingFee: (map['shippingFee'] ?? 0).toDouble(),
      createdAt: map['createdAt'] ?? '',
      shippingAddress: Address.fromMap(map['shippingAddress'] ?? {}, ''),
      paymentMethod: map['paymentMethod'] ?? '',
      status: map['status'] ?? '',
      note: map['note'] ?? '',
    );
  }

  // Convert Order to Map to save to Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalAmount': totalAmount,
      'discount': discount,
      'shippingFee': shippingFee,
      'createdAt': createdAt,
      'shippingAddress': shippingAddress.toMap(),
      'paymentMethod': paymentMethod,
      'status': status,
      'note': note,
    };
  }
}
