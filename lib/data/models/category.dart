class Category {
  int? id;
  String name;
  String description;

  Category({
    this.id,
    required this.name,
    this.description = 'Không có mô tả',
  });

  // Tạo Category từ SQLite Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? 'Không có mô tả',
    );
  }

  // Chuyển Category thành Map để insert/update
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
    };
  }
}
