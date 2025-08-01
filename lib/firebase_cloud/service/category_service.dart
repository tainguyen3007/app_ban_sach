import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ban_sach/firebase_cloud/models/category.dart';

class CategoryService {
  static final CollectionReference _categoryRef =
      FirebaseFirestore.instance.collection('categories');

  // 🔹 Thêm hoặc cập nhật category
  static Future<void> saveCategory(Category category) async {
    final docId = category.id ?? _categoryRef.doc().id;
    await _categoryRef.doc(docId).set(category.toMap(), SetOptions(merge: true));
  }

  // 🔹 Lấy category theo ID
  static Future<Category?> getCategoryById(String id) async {
    final doc = await _categoryRef.doc(id).get();
    if (doc.exists) {
      return Category.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // 🔹 Lấy tất cả categories
  static Future<List<Category>> getAllCategories() async {
    final snapshot = await _categoryRef.get();
    return snapshot.docs
        .map((doc) => Category.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // 🔹 Xóa category
  static Future<void> deleteCategory(String id) async {
    await _categoryRef.doc(id).delete();
  }
  Future<void> initSampleCategories() async {
  final categories = [
    Category(id: 'c001', name: 'Lập trình', description: 'Sách lập trình'),
    Category(id: 'c002', name: 'Thiết kế', description: 'UI/UX, Design'),
    Category(id: 'c003', name: 'Kinh doanh', description: 'Marketing, bán hàng'),
  ];

  for (final category in categories) {
    await CategoryService.saveCategory(category);
  }
}
}
