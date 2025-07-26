import 'package:sqflite/sqflite.dart';
import '../models/product.dart';
import 'db_helper.dart';

class ProductService {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();
  final tablename = 'PRODUCT';

  // Thêm sản phẩm mới
  Future<int> insertProduct(Product product) async {
    final db = await DBHelper.instance.database;
    return await db.insert(tablename, product.toMap());
  }

  // Lấy toàn bộ sản phẩm
  Future<List<Product>> getAllProducts() async {
    final db = await DBHelper.instance.database;
    final result = await db.query(tablename);
    return result.map((e) => Product.fromMap(e)).toList();
  }

  // Tìm sản phẩm theo ID
  Future<Product?> getProductById(int id) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(tablename, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Product.fromMap(result.first);
    }
    return null;
  }

  // Cập nhật sản phẩm
  Future<int> updateProduct(Product product) async {
    final db = await DBHelper.instance.database;
    return await db.update(
      tablename,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Xoá sản phẩm theo ID
  Future<int> deleteProduct(int id) async {
    final db = await DBHelper.instance.database;
    return await db.delete(tablename, where: 'id = ?', whereArgs: [id]);
  }

  // Tìm theo từ khóa tên (search)
  Future<List<Product>> searchProducts(String keyword) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      tablename,
      where: 'name LIKE ?',
      whereArgs: ['%$keyword%'],
    );
    return result.map((e) => Product.fromMap(e)).toList();
  }

  // Lọc theo categoryId
  Future<List<Product>> getProductsByCategory(int categoryId) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      tablename,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
    return result.map((e) => Product.fromMap(e)).toList();
  }
}
