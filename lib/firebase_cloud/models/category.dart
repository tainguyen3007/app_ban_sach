class Category {
  String? id;
  String name;
  String description;

  Category({
    this.id,
    required this.name,
    this.description = 'Không có mô tả',
  });

  factory Category.fromMap(Map<String, dynamic> map, String docId) {
    return Category(
      id: docId,
      name: map['name'] ?? '',
      description: map['description'] ?? 'Không có mô tả',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}
