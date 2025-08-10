class User {
  String? uid;
  String email;
  String password;
  String? name;
  String? birthday;
  int gender;
  String phoneNumber;
  String role;
  String avatar;

  User({
    this.uid,
    required this.email,
    required this.password,
    this.name,
    this.birthday = "2000/1/1",
    this.gender = 1,
    required this.phoneNumber,
    this.role = 'user',
    this.avatar = 'assets/default_images/default_avatar.jpg',
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
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

  Map<String, dynamic> toMap() {
    return {
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
