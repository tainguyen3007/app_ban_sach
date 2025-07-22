import 'package:app_ban_sach/data/models/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mydb.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  //Khởi tạo db
  Future _onCreate(Database db, int version) async {
    // Xóa bảng nếu tồn tại
    await db.execute('DROP TABLE IF EXISTS product');
    await db.execute('DROP TABLE IF EXISTS user');

    // Tạo bảng product
    await db.execute('''
      CREATE TABLE product (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL,
        oldPrice REAL,
        imageUrl TEXT,
        soldCount INTEGER DEFAULT 0,
        discount REAL DEFAULT 0.0
      );
    ''');
    await db.insert('product', {
      'id': 'p001',
      'name': 'Áo sơ mi trắng',
      'description': 'Áo sơ mi tay dài, vải cotton thoáng mát.',
      'price': 250000,
      'oldPrice': 300000,
      'imageUrl': 'https://example.com/images/shirt_white.jpg',
      'soldCount': 120,
      'discount': 17.0
    });

    await db.insert('product', {
      'id': 'p002',
      'name': 'Giày sneaker',
      'description': 'Giày thể thao phong cách Hàn Quốc, unisex.',
      'price': 750000,
      'oldPrice': 800000,
      'imageUrl': 'https://example.com/images/sneaker.jpg',
      'soldCount': 85,
      'discount': 6.0
    });

  }
  // Hàm test: lấy tất cả sản phẩm
    Future<List<Map<String, dynamic>>> getAllProducts() async {
      final db = await database;
      return await db.query('product');
    }

    Future<List<Product>> getAllProductObjects() async {
      final db = await database;
      final maps = await db.query('product');
      return maps.map((map) => Product.fromMap(map)).toList();
    }
}
