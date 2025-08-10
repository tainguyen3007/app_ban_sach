import 'package:app_ban_sach/firebase_cloud/models/product.dart';

class SavedProduct {
  final String userId;
  final String productId;
  final bool isSaved;

  SavedProduct({
    required this.userId,
    required this.productId,
    required this.isSaved,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'isSaved': isSaved,
    };
  }

  factory SavedProduct.fromMap(Map<String, dynamic> map) {
    return SavedProduct(
      userId: map['userId'],
      productId: map['productId'],
      isSaved: map['isSaved'] ?? false,
    );
  }
}
