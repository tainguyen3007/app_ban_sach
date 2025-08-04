import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ban_sach/firebase_cloud/models/address.dart';

class AddressService {
  static final _addressCollection =
      FirebaseFirestore.instance.collection('addresses');

  /// 🔽 Thêm và cập nhật địa chỉ mới
  static Future<void> saveAddress(Address address) async {
    final docId = address.id.isEmpty ? _addressCollection.doc().id : address.id;
    await _addressCollection.doc(docId).set(address.toMap(), SetOptions(merge: true));
  }


  /// 📃 Lấy danh sách địa chỉ theo userId
  static Future<List<Address>> getAddressesByUser(String userId) async {
    final snapshot = await _addressCollection
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      return Address.fromMap(doc.data() , doc.id);
    }).toList();
  }

  /// 🔄 Cập nhật địa chỉ
  static Future<void> updateAddress(Address address) async {
    await _addressCollection.doc(address.id).update(address.toMap());
  }

  /// ❌ Xóa địa chỉ
  static Future<void> deleteAddress(String addressId) async {
    await _addressCollection.doc(addressId).delete();
  }

  /// 📄 Lấy địa chỉ cụ thể theo ID
  static Future<Address?> getAddressById(String addressId) async {
    final doc = await _addressCollection.doc(addressId).get();
    if (doc.exists) {
      return Address.fromMap(doc.data()!, doc.id);
    }
    return null;
  }
}
