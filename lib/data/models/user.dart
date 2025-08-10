class User {
  int? id;
  String email;
  String password;
  String? name;
  String? birthday; // dạng 'YYYY-MM-DD'
  int gender; // 1: Nam, 2: Nữ, 0: Khác
  String phoneNumber;
  String role;
  String avatar;

  User({
    this.id,
    required this.email,
    required this.password,
    this.name,
    this.birthday,
    this.gender = 1,
    required this.phoneNumber,
    this.role = 'user',
    this.avatar = 'assets/default_images/default_avatar.jpg',
  });

  // Tạo User từ Map (SQLite row)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      birthday: map['birthday'],
      gender: map['gender'] ?? 1,
      phoneNumber: map['phoneNumber'],
      role: map['role'] ?? 'user',
      avatar: map['avatar'] ?? 'assets/default_images/default_avatar.jpg',
    );
  }

  // Chuyển User thành Map để insert/update
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'email': email,
      'password': password,
      'name': name,
      'birthday': birthday,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'role': role,
      'avatar': avatar,
    };
  }
}
