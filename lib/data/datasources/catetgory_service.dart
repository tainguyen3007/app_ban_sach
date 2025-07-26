import 'package:app_ban_sach/data/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_ban_sach/data/datasources/db_helper.dart';

class CategoryService {
  static final CategoryService _instance = CategoryService._internal();
  factory CategoryService() => _instance;
  CategoryService._internal();
  final tableName = 'CATEGORY';

  // Thêm danh mục
  Future<int> insertCategory(Category category) async {
    final db = await DBHelper.instance.database;
    return await db.insert(tableName, category.toMap());
  }

  // Lấy tất cả danh mục
  Future<List<Category>> getAllCategories() async {
    final db = await DBHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((map) => Category.fromMap(map)).toList();
  }

  // Lấy danh mục theo ID
  Future<Category?> getCategoryById(int id) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Category.fromMap(result.first);
    }
    return null;
  }

  // Cập nhật danh mục
  Future<int> updateCategory(Category category) async {
    final db = await DBHelper.instance.database;
    return await db.update(
      tableName,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  // Xoá danh mục
  Future<int> deleteCategory(int id) async {
    final db = await DBHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
