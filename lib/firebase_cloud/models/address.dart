class Address {
  String id;
  String userId;         // ID người tạo
  String receiverName;   // Tên người nhận
  String phoneNumber;
  String streetAddress;
  String city;

  Address({
    required this.id,
    required this.userId,
    required this.receiverName,
    required this.phoneNumber,
    required this.streetAddress,
    required this.city,
  });

  // Tạo Address từ Firestore document
  factory Address.fromMap(Map<String, dynamic> map, String docId) {
    return Address(
      id: docId,
      userId: map['userId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      streetAddress: map['streetAddress'] ?? '',
      city: map['city'] ?? '',
    );
  }

  // Convert Address sang Map để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'receiverName': receiverName,
      'phoneNumber': phoneNumber,
      'streetAddress': streetAddress,
      'city': city,
    };
  }
}
