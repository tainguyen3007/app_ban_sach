import 'package:uuid/uuid.dart';

class Product {
  String? id;
  String name;
  String des;
  double price;
  double oldprice;
  double discount;
  double soldCount;
  String imageUrl;
  String? categoryId;

  Product({
    String? id,
    required this.name,
    this.des = 'Không có mô tả',
    required this.price,
    this.oldprice = 0,
    this.discount = 0,
    this.soldCount = 9,
    this.imageUrl = 'assets/default_images/default_image.png',
    this.categoryId,
  }): id = id ?? Uuid().v4();

  factory Product.fromMap(Map<String, dynamic> map, String docId) {
    return Product(
      id: docId,
      name: map['name'] ?? '',
      des: map['des'] ?? 'Không có mô tả',
      price: (map['price'] as num).toDouble(),
      oldprice: (map['oldprice'] as num?)?.toDouble() ?? 0,
      discount: (map['discount'] as num?)?.toDouble() ?? 0,
      soldCount: (map['soldCount'] as num?)?.toDouble() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      categoryId: map['categoryId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'des': des,
      'price': price,
      'oldprice': oldprice,
      'discount': discount,
      'soldCount': soldCount,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
    };
  }
}
