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

  // 🔹 Tìm kiếm sản phẩm theo tên (bắt đầu bằng query)
  static Future<List<Product>> searchProductsByName(String query) async {
    if (query.isEmpty) return [];

    final upperQuery = query.trim().toLowerCase();
    final endQuery = upperQuery.substring(0, upperQuery.length - 1) +
        String.fromCharCode(upperQuery.codeUnitAt(upperQuery.length - 1) + 1);

    final snapshot = await _productRef
        .where('name_lowercase', isGreaterThanOrEqualTo: upperQuery)
        .where('name_lowercase', isLessThan: endQuery)
        .get();

    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  static Future<List<Product>> searchProductsByName1(String query) async {
    final keyword = query.toLowerCase().trim();

    final snapshot = await _productRef.get(); // 🔹 Lấy toàn bộ sản phẩm

    final results = snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .where((product) =>
            product.name.toLowerCase().contains(keyword) ||
            product.des.toLowerCase().contains(keyword)) // 🔹 Tìm cả trong name và des
        .toList();

    return results;
  }

  static Future<List<Product>> getProductsByCategory(String categoryId) async {
    final snapshot = await _productRef
        .where('categoryId', isEqualTo: categoryId)
        .get();

    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
  List<Product> sortProducts(List<Product> products, String sortOption) {
    final sortedList = List<Product>.from(products); // tạo bản sao để không thay đổi gốc

    switch (sortOption) {
      case 'Giá thấp → cao':
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Giá cao → thấp':
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Bán chạy':
        sortedList.sort((a, b) => b.soldCount.compareTo(a.soldCount));
        break;
      case 'Giảm giá nhiều':
        sortedList.sort((a, b) => b.discount.compareTo(a.discount));
        break;
      case 'Mặc định':
      default:
        // Không sắp xếp lại
        break;
    }

    return sortedList;
  }


}
