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
  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dbbansach.db');

    // Xoá file database hiện tại
    await deleteDatabase(path);

    // Tạo lại database
    _database = await _initDB('dbbansach.db');
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
    await db.insert('CATEGORY', {'name': 'Sách giáo dục'});
    await db.insert('CATEGORY', {'name': 'Truyện tranh'});
    await db.insert('CATEGORY', {'name': 'Kỹ năng sống'});
    await db.insert('CATEGORY', {'name': 'Tiểu thuyết'});
    await db.insert('CATEGORY', {'name': 'Tâm lý học'});

    // PRODUCT
    await db.insert('PRODUCT', {
      'name': 'Flutter cơ bản ',
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
    await db.insert('PRODUCT', {
      'name': 'Cho tôi xin một vé đi tuổi thơ',
      'des': 'Tác phẩm nổi tiếng của Nguyễn Nhật Ánh về tuổi thơ hồn nhiên.',
      'price': 48000,
      'oldprice': 60000,
      'discount': 20,
      'imageUrl': 'assets/cho-toi-xin-mot-ve-di-tuoi-tho.jpg',
      'categoryId': 1
    });

    await db.insert('PRODUCT', {
      'name': 'Đắc Nhân Tâm',
      'des': 'Cuốn sách kỹ năng sống kinh điển giúp bạn thành công hơn trong giao tiếp.',
      'price': 82000,
      'oldprice': 102000,
      'discount': 20,
      'imageUrl': 'assets/dac-nhan-tam.jpg',
      'categoryId': 2
    });

    await db.insert('PRODUCT', {
      'name': 'Kỹ năng sống cho tuổi teen',
      'des': 'Sách kỹ năng sống dành riêng cho lứa tuổi học sinh.',
      'price': 42000,
      'oldprice': 50000,
      'discount': 16,
      'imageUrl': 'assets/ky-nang-song.jpg',
      'categoryId': 2
    });

    await db.insert('PRODUCT', {
      'name': 'Những người khốn khổ',
      'des': 'Tác phẩm kinh điển của Victor Hugo về số phận con người.',
      'price': 105000,
      'oldprice': 130000,
      'discount': 19,
      'imageUrl': 'assets/nhung-nguoi-khuon-kho.jpg',
      'categoryId': 2
    });

    await db.insert('PRODUCT', {
      'name': 'Tiếng chim hót trong bụi mận gai',
      'des': 'Tiểu thuyết tình cảm nổi tiếng của Colleen McCullough.',
      'price': 99000,
      'oldprice': 120000,
      'discount': 18,
      'imageUrl': 'assets/tieng-chim-hot.jpg',
      'categoryId': 1
    });

    await db.insert('PRODUCT', {
      'name': 'Tuổi thơ dữ dội - Tập 1',
      'des': 'Truyện thiếu nhi mang yếu tố lịch sử chiến tranh cảm động.',
      'price': 65000,
      'oldprice': 80000,
      'discount': 19,
      'imageUrl': 'assets/tuoi-tho-du-doi.jpg',
      'categoryId': 1
    });

    await db.insert('PRODUCT', {
      'name': 'Truyện ngắn Nam Cao',
      'des': 'Tuyển chọn những truyện ngắn đặc sắc của Nam Cao.',
      'price': 47000,
      'oldprice': 60000,
      'discount': 22,
      'imageUrl': 'assets/truyen-ngan-nam-cao.jpg',
      'categoryId': 2
    });

    await db.insert('PRODUCT', {
      'name': 'Thám tử lừng danh Conan - Tập 105',
      'des': 'Tập truyện tranh trinh thám nổi tiếng dành cho thiếu nhi.',
      'price': 25000,
      'oldprice': 30000,
      'discount': 17,
      'imageUrl': 'assets/conan-10.png',
      'categoryId': 1
    });

    await db.insert('PRODUCT', {
      'name': 'Cún con - Nuôi dưỡng tâm hồn',
      'des': 'Giúp trẻ phát triển tư duy và sáng tạo thông qua kể chuyện mỗi ngày.',
      'price': 33000,
      'oldprice': 42000,
      'discount': 21,
      'imageUrl': 'assets/cun-con.jpg',
      'categoryId': 1
    });
    //user
    await db.insert('USER', {
      'email': 'a@gmail.com', 'password': '123456', 'name': 'An',
      'birthday': '2000-01-01', 'gender': 1, 'phoneNumber': '0900000001'
    });
    await db.insert('USER', {
      'email': 'b@gmail.com', 'password': '123456', 'name': 'Bình',
      'birthday': '2001-01-01', 'gender': 0, 'phoneNumber': '0900000002'
    });
    await db.insert('USER', {
      'email': 'c@gmail.com', 'password': '123456', 'name': 'Cường',
      'birthday': '1999-01-01', 'gender': 1, 'phoneNumber': '0900000003'
    });
    await db.insert('USER', {
      'email': 'd@gmail.com', 'password': '123456', 'name': 'Dương',
      'birthday': '1998-01-01', 'gender': 0, 'phoneNumber': '0900000004'
    });
    await db.insert('USER', {
      'email': 'admin@gmail.com', 'password': 'admin', 'name': 'Admin',
      'birthday': '1990-01-01', 'gender': 1, 'phoneNumber': '0900000005', 'role': 'admin'
    });

  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
