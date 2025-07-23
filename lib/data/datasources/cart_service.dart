import 'package:sqflite/sqflite.dart';
import 'package:app_ban_sach/data/models/cart.dart';
import 'package:app_ban_sach/data/datasources/db_helper.dart';

class CartService {
  final String tableName = 'CART';

  // Thêm vào giỏ hàng
  Future<int> insertCart(Cart cart) async {
    final db = await DBHelper.instance.database;
    return await db.insert(tableName, cart.toMap());
  }

  // Lấy tất cả sản phẩm trong giỏ hàng của user
  Future<List<Cart>> getCartByUser(int userId) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((e) => Cart.fromMap(e)).toList();
  }
  Future<int> updateCart(int id, int quantity) async {
  final db = await DBHelper.instance.database;
  return await db.update(
    'cart',
    {'quantity': quantity},
    where: 'id = ?',
    whereArgs: [id],
  );
}
  // Xoá sản phẩm khỏi giỏ hàng
  Future<int> deleteCartItem(int cartId) async {
    final db = await DBHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [cartId],
    );
  }
  // Xoá toàn bộ giỏ hàng của user
  Future<int> clearCart(int userId) async {
    final db = await DBHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
}
