class Cart {
  int? id;
  int userId;
  int productId;
  int quantity;

  Cart({
    this.id,
    required this.userId,
    required this.productId,
    this.quantity = 1,
  });

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      userId: map['userId'],
      productId: map['productId'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
