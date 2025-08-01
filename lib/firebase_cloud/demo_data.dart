import 'package:app_ban_sach/firebase_cloud/models/category.dart';
import 'package:app_ban_sach/firebase_cloud/models/product.dart';
import 'package:app_ban_sach/firebase_cloud/service/category_service.dart';
import 'package:app_ban_sach/firebase_cloud/service/product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DemoDataSeeder {
  static Future<void> seedCategories() async {
    final categories = [
      Category(id: 'c001', name: 'Lập trình', description: 'Sách lập trình'),
      Category(id: 'c002', name: 'Thiết kế', description: 'UI/UX, Design'),
      Category(id: 'c003', name: 'Kinh doanh', description: 'Marketing, bán hàng'),
    ];

    for (final category in categories) {
      await CategoryService.saveCategory(category);
    }
  }

  static Future<void> seedProducts() async {
  final List<Product> products = [
    Product(
      id: Uuid().v4(),
      name: 'Đắc Nhân Tâm',
      des: 'Cuốn sách kinh điển về nghệ thuật giao tiếp và ảnh hưởng người khác.',
      price: 89000,
      oldprice: 109000,
      discount: 18,
      soldCount: 1243,
      imageUrl: 'assets/dac-nhan-tam.jpg',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Kỹ năng sống tuổi teen',
      des: 'Dành cho học sinh và cha mẹ, rèn luyện kỹ năng mềm.',
      price: 62000,
      discount: 10,
      soldCount: 843,
      imageUrl: 'assets/ky-nang-song.jpg',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Những người khốn khổ',
      des: 'Tác phẩm nổi tiếng của Victor Hugo - Les Misérables.',
      price: 135000,
      oldprice: 150000,
      discount: 10,
      soldCount: 321,
      imageUrl: 'assets/nhung-nguoi-khuon-kho.jpg',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Tiếng chim hót trong bụi mận gai',
      des: 'Tác phẩm nổi tiếng của Colleen McCullough.',
      price: 118000,
      discount: 5,
      soldCount: 290,
      imageUrl: 'assets/tieng-chim-hot.jpg',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Tuổi thơ dữ dội',
      des: 'Tập 1 - Phùng Quán. Câu chuyện cảm động về tuổi thơ chiến tranh.',
      price: 88000,
      discount: 0,
      soldCount: 1021,
      imageUrl: 'assets/tuoi-tho-du-doi.jpg',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Truyện ngắn Nam Cao',
      des: 'Tuyển chọn các truyện ngắn đặc sắc của nhà văn Nam Cao.',
      price: 78000,
      discount: 8,
      soldCount: 674,
      imageUrl: 'assets/truyen-ngan-nam-cao.jpg',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Thám tử lừng danh Conan - Tập 105',
      des: 'Tiếp tục hành trình phá án hấp dẫn của Conan.',
      price: 25000,
      discount: 0,
      soldCount: 9999,
      imageUrl: 'assets/conan-10.png',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Cún Con - Nuôi dưỡng tâm hồn',
      des: 'Chuyện kể mỗi ngày giúp trẻ sáng tạo và linh hoạt hơn.',
      price: 43000,
      discount: 0,
      soldCount: 473,
      imageUrl: 'assets/cun-con.jpg',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Cho tôi xin một vé đi tuổi thơ',
      des: 'Tác phẩm nổi tiếng của Nguyễn Nhật Ánh - đầy xúc cảm.',
      price: 72000,
      discount: 12,
      soldCount: 1543,
      imageUrl: 'assets/cho-toi-xin-mot-ve-di-tuoi-tho.jpg',
    ),
    Product(
      id: Uuid().v4(),
      name: 'Logo Kim Đồng',
      des: 'Biểu tượng của NXB Kim Đồng - dành cho sản phẩm mặc định.',
      price: 0,
      discount: 0,
      soldCount: 0,
      imageUrl: 'assets/nxb-kim-dong.jpg',
    ),
  ];

    for (final product in products) {
      await ProductService.saveProduct(product);
    }
  }

  static Future<void> seedAll() async {
    await seedCategories();
    await seedProducts();
    print('🎉 Tất cả dữ liệu mẫu đã được thêm!');
  }
}
