class FavoriteProduct {
  final int? id;
  final int userId;
  final int productId;

  FavoriteProduct({
    this.id,
    required this.userId,
    required this.productId,
  });

  // Convert object to Map (dùng khi insert/update DB)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
    };
  }

  // Convert Map từ DB sang object FavoriteProduct
  factory FavoriteProduct.fromMap(Map<String, dynamic> map) {
    return FavoriteProduct(
      id: map['id'],
      userId: map['userId'],
      productId: map['productId'],
    );
  }
}
