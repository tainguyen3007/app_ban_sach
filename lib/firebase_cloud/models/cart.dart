class Cart {
  String? id;
  String userId;
  String productId;
  int quantity;
  bool isChecked;

  Cart({
    this.id,
    required this.userId,
    required this.productId,
    this.quantity = 1,
    this.isChecked = false,
  });

  factory Cart.fromMap(Map<String, dynamic> map, {String? docId}) {
    return Cart(
      id: docId,
      userId: map['userId'],
      productId: map['productId'],
      quantity: map['quantity'],
      isChecked: map['isChecked'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'isChecked': isChecked,
    };
  }
}
