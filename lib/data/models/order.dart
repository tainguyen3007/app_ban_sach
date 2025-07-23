class Order {
  int? id;
  int userId;
  double totalAmount;
  String status;
  String? note;
  String createdAt;

  Order({
    this.id,
    required this.userId,
    required this.totalAmount,
    this.status = 'chờ xử lý',
    this.note,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['userId'],
      totalAmount: map['totalAmount'] is int ? (map['totalAmount'] as int).toDouble() : map['totalAmount'],
      status: map['status'] ?? 'chờ xử lý',
      note: map['note'],
      createdAt: map['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'totalAmount': totalAmount,
      'status': status,
      'note': note,
      'created_at': createdAt,
    };
  }
}
