class Product {
  int? id;
  String name;
  String des;
  double price;
  double oldprice;
  double discount;
  double soldCount;
  String imageUrl;
  int? categoryId;

  Product({
    this.id,
    required this.name,
    this.des = 'Không có mô tả',
    required this.price,
    this.oldprice = 0,
    this.discount = 0,
    this.soldCount = 9,
    this.imageUrl = 'assets/default_images/default_image.png',
    this.categoryId,
  });

  // Convert từ Map (dùng khi đọc từ SQLite)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      des: map['des'] ?? '',
      price: map['price'] is int ? (map['price'] as int).toDouble() : map['price'],
      oldprice: map['oldprice'] is int ? (map['oldprice'] as int).toDouble() : map['oldprice'],
      discount: map['discount'] is int ? (map['discount'] as int).toDouble() : map['discount'],
      imageUrl: map['imageUrl'] ?? 'assets/default_images/default_image.png',
      categoryId: map['categoryId'],
    );
  }

  // Convert thành Map (dùng khi insert/update)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'des': des,
      'price': price,
      'oldprice': oldprice,
      'discount': discount,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
    };
  }
}
