class Category {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  final String categoryStatus;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryStatus,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
      categoryImage: json['category_image'] as String? ?? '',
      categoryStatus: json['category_status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'category_image': categoryImage,
      'category_status': categoryStatus,
    };
  }
}
