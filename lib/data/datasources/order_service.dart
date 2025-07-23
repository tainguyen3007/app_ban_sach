import 'package:app_ban_sach/data/models/order.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_ban_sach/data/datasources/db_helper.dart';
import 'package:app_ban_sach/data/models/order_detail.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final String ordersTable = 'ORDERS';
  final String detailsTable = 'ORDER_DETAIL';

  /// Thêm đơn hàng (và chi tiết đơn hàng)
  Future<int> insertOrder(Order order, List<OrderDetail> details) async {
    final db = await DBHelper.instance.database;
    int orderId = 0;

    await db.transaction((txn) async {
      orderId = await txn.insert(ordersTable, order.toMap());

      for (var detail in details) {
        detail.orderId = orderId; // gán orderId sau khi insert
        await txn.insert(detailsTable, detail.toMap());
      }
    });

    return orderId;
  }

  /// Lấy danh sách đơn hàng
  Future<List<Order>> getAllOrders() async {
    final db = await DBHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(ordersTable);
    return maps.map((map) => Order.fromMap(map)).toList();
  }

  /// Lấy chi tiết đơn hàng theo orderId
  Future<List<OrderDetail>> getDetailsByOrderId(int orderId) async {
    final db = await DBHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      detailsTable,
      where: 'orderId = ?',
      whereArgs: [orderId],
    );
    return maps.map((map) => OrderDetail.fromMap(map)).toList();
  }

  /// Cập nhật trạng thái đơn hàng
  Future<int> updateStatus(int orderId, String newStatus) async {
    final db = await DBHelper.instance.database;
    return await db.update(
      ordersTable,
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [orderId],
    );
  }

  /// Xoá đơn hàng và chi tiết đơn hàng
  Future<void> deleteOrder(int orderId) async {
    final db = await DBHelper.instance.database;
    await db.transaction((txn) async {
      await txn.delete(detailsTable, where: 'orderId = ?', whereArgs: [orderId]);
      await txn.delete(ordersTable, where: 'id = ?', whereArgs: [orderId]);
    });
  }
}
