import 'package:sqflite/sqflite.dart';
import 'package:app_ban_sach/data/models/user.dart';
import 'package:app_ban_sach/data/datasources/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();
  final tableName = 'USER';

  // Thêm user
  Future<int> insertUser(User user) async {
    final db = await DBHelper.instance.database;
    return await db.insert(tableName, user.toMap());
  }

  // Lấy toàn bộ user
  Future<List<User>> getAllUsers() async {
    final db = await DBHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((map) => User.fromMap(map)).toList();
  }

  // Lấy user theo email
  Future<User?> getUserByEmail(String email) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // Cập nhật user
  Future<int> updateUser(User user) async {
    final db = await DBHelper.instance.database;
    return await db.update(
      tableName,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Xóa user
  Future<int> deleteUser(int id) async {
    final db = await DBHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Đăng nhập: kiểm tra email + password
  Future<User?> login(String email, String password) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      tableName,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }
  // Lấy id uerd ở hiện tại
   Future<int> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }
}
