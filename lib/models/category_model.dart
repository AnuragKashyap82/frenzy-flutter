class CategoryModel {
  final String categoryName;
  final String imageUrl;

  CategoryModel(
      {required this.categoryName,
        required this.imageUrl,});

  Map<String, dynamic> getJson() {
    return {
      'categoryName': categoryName,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryModel.getModelFromJson({required Map<String, dynamic> json}) {
    return CategoryModel(
        categoryName: json["categoryName"],
        imageUrl: json["imageUrl"]);
  }
}
