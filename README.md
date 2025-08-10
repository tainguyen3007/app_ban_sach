# 📚 BookStore Flutter — Ứng dụng bán sách (Flutter + Firebase)

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Backend-orange?logo=firebase)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)

> Ứng dụng bán sách đa nền tảng (Android & iOS) phát triển bằng **Flutter**.  
> Tích hợp **Firebase** để quản lý dữ liệu, xác thực, lưu trữ ảnh, và đồng bộ real-time.  
> Phù hợp cho mô hình thương mại điện tử nhỏ và vừa.

---

## 📑 Mục lục
- [✨ Tính năng](#-tính-năng)
- [🖼️ Demo giao diện](#️-demo-giao-diện)
- [🛠️ Công nghệ](#️-công-nghệ)
- [📂 Cấu trúc thư mục](#-cấu-trúc-thư-mục)
- [⚙️ Cài đặt & chạy](#️-cài-đặt--chạy)
- [🗄️ Mô tả dữ liệu Firestore](#️-mô-tả-dữ-liệu-firestore)
- [🧪 Testing](#-testing)
- [🚀 CI/CD](#-cicd)
- [🤝 Đóng góp](#-đóng-góp)
- [📜 License](#-license)
- [📬 Liên hệ](#-liên-hệ)

---

## ✨ Tính năng
- 🔐 Đăng ký / Đăng nhập với Firebase Authentication (Email/Password).
- 📚 Duyệt sách theo danh mục, tìm kiếm, lọc nâng cao.
- 📖 Xem chi tiết sách (ảnh, mô tả, giá, đánh giá).
- 🛒 Giỏ hàng và thanh toán (tích hợp Momo/VNPay hoặc mô phỏng).
- 📦 Quản lý đơn hàng, trạng thái (Đang xử lý, Đã giao...).
- ⭐ Đánh giá & bình luận sản phẩm.
- 📤 Upload ảnh sản phẩm qua Firebase Storage.
- ⚡ Đồng bộ dữ liệu real-time với Firestore.

---

## 🖼️ Demo giao diện
> *(Thêm ảnh chụp màn hình hoặc video demo tại đây)*

| Trang chủ | Chi tiết sách | Giỏ hàng |
|-----------|---------------|----------|
| ![Home](./assets/screenshots/home.png) | ![Detail](./assets/screenshots/detail.png) | ![Cart](./assets/screenshots/cart.png) |

---

## 🛠️ Công nghệ
- **Frontend:** Flutter (Dart)  
  - State management: Provider / Riverpod / Bloc (tùy chọn)  
  - Local storage: sqflite (tùy chọn)
- **Backend:** Firebase  
  - Firebase Authentication  
  - Cloud Firestore  
  - Firebase Storage  
  - Cloud Functions (nếu cần)  
- **Khác:** Git, GitHub Actions, Postman

---

## 📂 Cấu trúc thư mục
```plaintext
lib/
 ├─ main.dart
 ├─ features/
 │   ├─ screens/
 │   ├─ widgets/
 │   ├─ models/
 │   ├─ services/
 │   ├─ providers/
 │   └─ utils/
assets/
 ├─ images/
 └─ screenshots/
