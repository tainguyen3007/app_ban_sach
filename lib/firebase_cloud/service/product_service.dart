import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  static final String nameCollection = 'products';
  static final CollectionReference _productRef =
      FirebaseFirestore.instance.collection(nameCollection);

  // 🔹 Thêm hoặc cập nhật product
  static Future<void> saveProduct(Product product) async {
    final docId = product.id ?? _productRef.doc().id;
    await _productRef.doc(docId).set(product.toMap(), SetOptions(merge: true));
  }

  // 🔹 Lấy product theo ID
  static Future<Product?> getProductById(String id) async {
    final doc = await _productRef.doc(id).get();
    if (doc.exists) {
      return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // 🔹 Lấy danh sách tất cả sản phẩm
  static Future<List<Product>> getAllProducts() async {
    final snapshot = await _productRef.get();
    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // 🔹 Xóa sản phẩm
  static Future<void> deleteProduct(String id) async {
    await _productRef.doc(id).delete();
  }
}
