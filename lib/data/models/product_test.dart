class Product {
  String _id;
  String _name;
  String _description;
  double _price;
  double _oldPrice;
  String _imageUrl;
  int _soldCount;
  double _discount = 0.0;
  Product({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    int soldCount = 0,
    double oldPrice = 0.0,
    double discount = 0.0,
  })  : _id = id,
        _name = name,
        _description = description,
        _price = price,
        _imageUrl = imageUrl,
        _soldCount = soldCount,
        _oldPrice = oldPrice,
        _discount = discount;

  // Getter và Setter cho id
  String get id => _id;
  set id(String value) => _id = value;

  // Getter và Setter cho name
  String get name => _name;
  set name(String value) => _name = value;

  // Getter và Setter cho description
  String get description => _description;
  set description(String value) => _description = value;

  // Getter và Setter cho price
  double get price => _price;
  set price(double value) => _price = value;

  // Getter và Setter cho oldPrice
  double get oldPrice => _oldPrice;
  set oldPrice(double value) => _oldPrice = value;

  // Getter và Setter cho imageUrl
  String get imageUrl => _imageUrl;
  set imageUrl(String value) => _imageUrl = value;

  // Getter và Setter cho soldCount
  int get soldCount => _soldCount;
  set soldCount(int value) => _soldCount = value;

  // Getter và Setter cho discount
  double get discount => _discount;
  set discount(double value) => _discount = value;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'] * 1.0,
      oldPrice: (map['oldPrice'] ?? 0.0) * 1.0,
      imageUrl: map['imageUrl'] ?? '',
      soldCount: map['soldCount'] ?? 0,
      discount: (map['discount'] ?? 0.0) * 1.0,
    );
  }
}