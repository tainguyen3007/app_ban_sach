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
      Category(id: 'c004', name: 'Tâm lý', description: 'Tâm lý học và phát triển bản thân'),
      Category(id: 'c005', name: 'Tiểu thuyết', description: 'Văn học hiện đại và cổ điển'),
      Category(id: 'c006', name: 'Trinh thám', description: 'Truyện trinh thám, phá án'),
      Category(id: 'c007', name: 'Khoa học', description: 'Khoa học tự nhiên và khám phá'),
      Category(id: 'c008', name: 'Thiếu nhi', description: 'Sách cho trẻ em'),
      Category(id: 'c009', name: 'Học ngoại ngữ', description: 'Tiếng Anh, Nhật, Hàn...'),
      Category(id: 'c010', name: 'Lịch sử', description: 'Sự kiện và nhân vật lịch sử'),
      Category(id: 'c011', name: 'Đời sống', description: 'Ẩm thực, làm đẹp, phong cách sống'),
      Category(id: 'c012', name: 'Giáo khoa', description: 'Sách giáo khoa các cấp học'),
      Category(id: 'c013', name: 'Kỹ năng sống', description: 'Giao tiếp, làm việc nhóm...'),
      Category(id: 'c014', name: 'Y học & Sức khỏe', description: 'Chăm sóc sức khỏe, dinh dưỡng'),
      Category(id: 'c015', name: 'Tôn giáo', description: 'Phật giáo, Thiên chúa giáo...'),
    ];


    for (final category in categories) {
      await CategoryService.saveCategory(category);
    }
  }

  static Future<void> seedProducts() async {
  final List<Product> products = [
    // c001 - Lập trình
    Product(
      id: Uuid().v4(),
      categoryId: 'c001',
      name: 'Lập trình Python cơ bản',
      des: 'Học cách lập trình với Python từ cơ bản đến nâng cao.',
      price: 95000,
      oldprice: 120000,
      discount: 20,
      soldCount: 500,
      imageUrl: 'assets/product_images/python.jpg',
    ),
    Product(
      id: Uuid().v4(),
      categoryId: 'c001',
      name: 'Java cho người mới bắt đầu',
      des: 'Giới thiệu về lập trình hướng đối tượng với Java.',
      price: 105000,
      oldprice: 130000,
      discount: 19,
      soldCount: 620,
      imageUrl: 'assets/product_images/java.png',
    ),

    // c002 - Thiết kế
    Product(
      id: Uuid().v4(),
      categoryId: 'c002',
      name: 'Thiết kế ',
      des: 'Hướng dẫn chi tiết về thiết kế.',
      price: 89000,
      oldprice: 110000,
      discount: 18,
      soldCount: 320,
      imageUrl: 'assets/product_images/designer.jpg',
    ),
    Product(
      id: Uuid().v4(),
      categoryId: 'c002',
      name: 'Nguyên lý thiết kế đồ họa',
      des: 'Tổng quan về các nguyên tắc thiết kế cơ bản.',
      price: 99000,
      oldprice: 125000,
      discount: 21,
      soldCount: 410,
      imageUrl: 'assets/product_images/designer-1.jpg',
    ),

    // c003 - Kinh doanh
    Product(
      id: Uuid().v4(),
      categoryId: 'c003',
      name: 'Bí quyết kinh doanh bạc tỷ',
      des: 'Chiến lược marketing hiện đại trong kỷ nguyên số.',
      price: 115000,
      oldprice: 140000,
      discount: 18,
      soldCount: 750,
      imageUrl: 'assets/product_images/kinh-doanh-1.jpg',
    ),
    Product(
      id: Uuid().v4(),
      categoryId: 'c003',
      name: 'Bài học để đời từ những doanh nghiệp thất bại',
      des: 'Kỹ năng chốt sales hiệu quả dành cho người đi làm.',
      price: 99000,
      oldprice: 119000,
      discount: 16,
      soldCount: 530,
      imageUrl: 'assets/product_images/kinh-doanh-2.jpg',
    ),

    // c004 - Tâm lý
    Product(
      id: Uuid().v4(),
      categoryId: 'c004',
      name: 'Tâm lý học xã hội',
      des: 'Hiểu về tâm lý con người và hành vi xã hội.',
      price: 95000,
      oldprice: 115000,
      discount: 17,
      soldCount: 410,
      imageUrl: 'assets/product_images/tam-ly-1.jpg',
    ),
    Product(
      id: Uuid().v4(),
      categoryId: 'c004',
      name: 'Tâm lý học nhân cách',
      des: 'Hành trình khám phá nội tâm và phát triển bản thân.',
      price: 85000,
      oldprice: 99000,
      discount: 14,
      soldCount: 360,
      imageUrl: 'assets/product_images/tam-ly-2.jpg',
    ),

    // c005 - Kỹ năng sống
    Product(
      id: Uuid().v4(),
      categoryId: 'c005',
      name: 'Đắc nhân tâm',
      des: 'Phát triển thói quen tốt để thành công bền vững.',
      price: 109000,
      oldprice: 135000,
      discount: 19,
      soldCount: 880,
      imageUrl: 'assets/product_images/dac-nhan-tam.jpg',
    ),
    Product(
      id: Uuid().v4(),
      categoryId: 'c005',
      name: 'Giao tiếp thông minh',
      des: 'Nâng cao kỹ năng giao tiếp trong công việc và đời sống.',
      price: 89000,
      oldprice: 110000,
      discount: 19,
      soldCount: 470,
      imageUrl: 'assets/product_images/giao-tiep-1.jpg',
    ),

    // c006 - Văn học
    Product(
      id: Uuid().v4(),
      categoryId: 'c006',
      name: 'Truyện ngắn - Nam Cao',
      des: 'Tác phẩm kinh điển phản ánh hiện thực xã hội Việt Nam.',
      price: 75000,
      oldprice: 95000,
      discount: 21,
      soldCount: 600,
      imageUrl: 'assets/product_images/truyen-ngan-nam-cao.jpg',
    ),
    Product(
      id: Uuid().v4(),
      categoryId: 'c006',
      name: 'Tắt đèn - Ngô Tất Tố',
      des: 'Tiểu thuyết phản ánh xã hội phong kiến bất công.',
      price: 79000,
      oldprice: 99000,
      discount: 20,
      soldCount: 420,
      imageUrl: 'assets/product_images/tat-den.jpg',
    ),

    // c010 - Ngoại ngữ
    Product(
      id: Uuid().v4(),
      categoryId: 'c010',
      name: 'Tiếng Anh lớp 10',
      des: 'Tổng hợp toàn bộ ngữ pháp cần thiết cho người học.',
      price: 87000,
      oldprice: 105000,
      discount: 17,
      soldCount: 680,
      imageUrl: 'assets/product_images/eng-10.jpg',
    ),
    Product(
      id: Uuid().v4(),
      categoryId: 'c010',
      name: 'Phương pháp học Tiếng Anh gioa tiếp',
      des: 'Học và ghi nhớ từ vựng tiếng Anh hiệu quả.',
      price: 92000,
      oldprice: 115000,
      discount: 20,
      soldCount: 740,
      imageUrl: 'assets/product_images/hoc-ta.png',
    ),
  ];


    for (final product in products) {
      await ProductService.saveProduct(product);
    }
  }

  static Future<void> seedAll() async {
    await seedCategories();
    await seedProducts();
  }
}
