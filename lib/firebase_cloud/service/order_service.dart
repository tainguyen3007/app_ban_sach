import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ban_sach/firebase_cloud/models/order.dart' as MyOrder;

class OrderService {
  static final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  static Future<void> addOrder(MyOrder.Order order) async {
    final docRef = ordersCollection.doc(); // tạo document mới, tự sinh id
    order.id = docRef.id;                  // gán id được sinh vào order
    await docRef.set(order.toMap());
  }


  // Lấy tất cả đơn hàng của 1 user
  static Future<List<MyOrder.Order>> getOrdersByUser(String userId) async {
    final querySnapshot = await ordersCollection
        .where('userId', isEqualTo: userId)
        .get();

    return querySnapshot.docs.map((doc) {
      return MyOrder.Order.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Lấy đơn hàng theo ID
  static Future<MyOrder.Order?> getOrderById(String orderId) async {
    final docSnapshot = await ordersCollection.doc(orderId).get();
    if (docSnapshot.exists) {
      return MyOrder.Order.fromMap(docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
    }
    return null;
  }

  // Cập nhật trạng thái đơn hàng
  static Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await ordersCollection.doc(orderId).update({'status': newStatus});
  }

  // Xóa đơn hàng (nếu cần)
  static Future<void> deleteOrder(String orderId) async {
    await ordersCollection.doc(orderId).delete();
  }
}
