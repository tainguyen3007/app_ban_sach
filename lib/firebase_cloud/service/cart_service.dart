import 'package:app_ban_sach/firebase_cloud/models/cart.dart';
import 'package:app_ban_sach/firebase_cloud/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CartItemWithProduct {
  final Cart cart;
  final Product product;

  CartItemWithProduct({
    required this.cart,
    required this.product,
  });
}

class CartService {
  static final CollectionReference _cartRef =
      FirebaseFirestore.instance.collection('carts');
  static final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');

  /// ✅ Thêm sản phẩm vào giỏ, cập nhật nếu sản phẩm đã thêm vào trước đó
  static Future<void> insertCart(Cart cart) async {
    final cartId = '${cart.userId}_${cart.productId}';
    cart.id = cartId;

    final doc = await _cartRef.doc(cartId).get();

    if (doc.exists) {
      // Nếu đã tồn tại, tăng quantity
      final currentQty = (doc.data() as Map<String, dynamic>)['quantity'] ?? 1;
      await _cartRef.doc(cartId).update({
        'quantity': currentQty + cart.quantity,
      });
    } else {
      // Nếu chưa có, tạo mới
      await _cartRef.doc(cartId).set(cart.toMap());
    }
  }
  static Future<void> updateCart(Cart cart) async {
    final cartId = '${cart.userId}_${cart.productId}';
    cart.id = cartId;

    await _cartRef.doc(cartId).update({
      'quantity': cart.quantity,
      'isChecked': cart.isChecked,
    });
  }

  /// ✅ Xóa sản phẩm khỏi giỏ
  static Future<void> deleteCart(String cartId) async {
    await _cartRef.doc(cartId).delete();
  }

  /// ✅ Lấy tất cả giỏ hàng của 1 user 
  static Future<List<Cart>> getCartByUser(String userId) async {
    final query = await _cartRef.where('userId', isEqualTo: userId).get();
    return query.docs
      .map((doc) => Cart.fromMap(doc.data() as Map<String, dynamic>, docId: doc.id))
      .toList();
  }


  /// ✅ Xóa tất cả giỏ hàng của 1 user (khi checkout xong chẳng hạn)
  static Future<void> clearCartByUser(String userId) async {
    final query = await _cartRef.where('userId', isEqualTo: userId).get();
    for (var doc in query.docs) {
      await doc.reference.delete();
    }
  }

  /// ✅ Lấy giỏ hàng của user kèm thông tin sản phẩm
  static Future<List<CartItemWithProduct>> getCartWithProductByUser(String userId) async {
    final cartQuery = await _cartRef.where('userId', isEqualTo: userId).get();

    List<CartItemWithProduct> result = [];

    for (var doc in cartQuery.docs) {
      final cart = Cart.fromMap(doc.data() as Map<String, dynamic>, docId: doc.id);
      final productDoc = await _productRef.doc(cart.productId).get();

      //Kiểm tra product có tồn tại 
      if (productDoc.exists) {
        final product = Product.fromMap(productDoc.data() as Map<String, dynamic>, productDoc.id);
        result.add(CartItemWithProduct(cart: cart, product: product));
      }
    }

    return result;
  }
}
