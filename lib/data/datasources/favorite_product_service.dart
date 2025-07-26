import 'package:app_ban_sach/data/datasources/db_helper.dart';
import 'package:app_ban_sach/data/datasources/user_service.dart';
import 'package:app_ban_sach/data/models/favorite_product.dart';
import 'package:app_ban_sach/data/models/product.dart';

class FavoriteProductService {
  final tableName = 'FAVORITE_PRODUCT';

  Future<int> insert(FavoriteProduct favorite) async {
    final db = await DBHelper.instance.database;
    return await db.insert(tableName, favorite.toMap());
  }

  Future<int> delete(int userId, int productId) async {
    final db = await DBHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'userId = ? AND productId = ?',
      whereArgs: [userId, productId],
    );
  }

  Future<bool> isFavorite(int userId, int productId) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      tableName,
      where: 'userId = ? AND productId = ?',
      whereArgs: [userId, productId],
    );
    return result.isNotEmpty;
  }

  Future<List<int>> getFavoriteProductIdsByUser(int userId) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((e) => e['productId'] as int).toList();
  }

  Future<List<FavoriteProduct>> getAll() async {
    final db = await DBHelper.instance.database;
    final result = await db.query(tableName);
    return result.map((e) => FavoriteProduct.fromMap(e)).toList();
  }

  Future<List<Product>> getAllFavoriteProducts() async {
    final db = await DBHelper.instance.database;

    final result = await db.rawQuery('''
      SELECT PRODUCT.*
      FROM FAVORITE_PRODUCT
      JOIN PRODUCT ON FAVORITE_PRODUCT.productId = PRODUCT.id
      WHERE FAVORITE_PRODUCT.userId = ?
    ''', 
      [await UserService().getCurrentUserId()]
    );
    return result.map((map) => Product.fromMap(map)).toList();
  }
}
