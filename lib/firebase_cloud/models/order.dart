import 'order_item.dart';

class Order {
  String id;
  final String userId;
  final double totalAmount;
  final double discount;
  final double shippingFee;
  final String createdAt;
  final String shippingAddressId;
  final String paymentMethod;
  final String status;
  final String note;
  final List<OrderItem> orderItems; // ✅ lồng vào

  Order({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.discount,
    required this.shippingFee,
    required this.createdAt,
    required this.shippingAddressId,
    required this.paymentMethod,
    required this.status,
    required this.note,
    required this.orderItems,
  });

  factory Order.fromMap(Map<String, dynamic> map, String docId) {
    return Order(
      id: docId,
      userId: map['userId'] ?? '',
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      shippingFee: (map['shippingFee'] ?? 0).toDouble(),
      createdAt: map['createdAt'] ?? '',
      shippingAddressId: map['shippingAddressId'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      status: map['status'] ?? '',
      note: map['note'] ?? '',
      orderItems: (map['orderItems'] as List<dynamic>? ?? [])
          .map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalAmount': totalAmount,
      'discount': discount,
      'shippingFee': shippingFee,
      'createdAt': createdAt,
      'shippingAddressId': shippingAddressId,
      'paymentMethod': paymentMethod,
      'status': status,
      'note': note,
      'orderItems': orderItems.map((item) => item.toMap()).toList(), 
    };
  }
}
