import 'package:app_ban_sach/firebase_cloud/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final _db = FirebaseFirestore.instance;

  /// ✅ Thêm hoặc cập nhật user
  static Future<void> saveUser(User user) async {
    await _db.collection('users').doc(user.email).set(
          user.toMap(),
          SetOptions(merge: true),
        );
  }

  /// ✅ Lấy user từ Firestore theo uid
  static Future<User?> getUserByUid(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return User.fromMap(doc.data()!);
    }
    return null;
  }

  /// ✅ Xóa user
  static Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).delete();
  }
  //Gọi userId
  static Future<String> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? "null";
  }
}
