import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dbbansach.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // DROP TABLE nếu đã tồn tại (xóa sạch dữ liệu cũ)
    await db.execute('DROP TABLE IF EXISTS ORDER_DETAIL;');
    await db.execute('DROP TABLE IF EXISTS ORDERS;');
    await db.execute('DROP TABLE IF EXISTS CART;');
    await db.execute('DROP TABLE IF EXISTS PRODUCT;');
    await db.execute('DROP TABLE IF EXISTS CATEGORY;');
    await db.execute('DROP TABLE IF EXISTS USER;');

    await db.execute('''
      CREATE TABLE USER (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        name TEXT,
        birthday TEXT,
        gender INTEGER DEFAULT 1,
        phoneNumber TEXT NOT NULL,
        role TEXT DEFAULT 'user',
        avatar TEXT DEFAULT 'assets/default-avatar.png'
      );
    ''');

    await db.execute('''
      CREATE TABLE CATEGORY (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT DEFAULT 'Không có mô tả'
      );
    ''');

    await db.execute('''
      CREATE TABLE PRODUCT (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        des TEXT DEFAULT 'Không có mô tả',
        price REAL NOT NULL,
        oldprice REAL DEFAULT 0,
        discount REAL DEFAULT 0,
        imageUrl TEXT DEFAULT 'https://example.com/images/default.jpg',
        categoryId INTEGER,
        FOREIGN KEY (categoryId) REFERENCES CATEGORY(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE CART (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        productId INTEGER NOT NULL,
        quantity INTEGER DEFAULT 1,
        FOREIGN KEY (userId) REFERENCES USER(id),
        FOREIGN KEY (productId) REFERENCES PRODUCT(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE ORDERS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        totalAmount REAL NOT NULL,
        status TEXT DEFAULT 'chờ xử lý',
        note TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (userId) REFERENCES USER(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE ORDER_DETAIL (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId INTEGER NOT NULL,
        productId INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        FOREIGN KEY (orderId) REFERENCES ORDERS(id),
        FOREIGN KEY (productId) REFERENCES PRODUCT(id)
      );
    ''');
    //categories
    await db.insert('CATEGORY', {'name': 'Sách Lập trình', 'description': 'Sách dành cho lập trình viên'});
    await db.insert('CATEGORY', {'name': 'Thiếu nhi', 'description': 'Sách cho bé'});
    // PRODUCT
    await db.insert('PRODUCT', {
      'name': 'Flutter cơ bản',
      'des': 'Hướng dẫn học Flutter từ A đến Z',
      'price': 150000,
      'oldprice': 200000,
      'discount': 25,
      'imageUrl': 'assets/sachhoc.png',
      'categoryId': 1
    });

    await db.insert('PRODUCT', {
      'name': 'Doraemon Tập 1',
      'des': 'Truyện tranh thiếu nhi nổi tiếng',
      'price': 25000,
      'oldprice': 30000,
      'discount': 17,
      'imageUrl': 'assets/ngoaivan.png',
      'categoryId': 2
    });
    await db.insert('PRODUCT', {
      'name': 'Doraemon Tập 3',
      'des': 'Truyện tranh thiếu nhi nổi tiếng',
      'price': 25000,
      'oldprice': 30000,
      'discount': 17,
      'imageUrl': 'assets/sgk_tv_2_1.jpg',
      'categoryId': 1
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
