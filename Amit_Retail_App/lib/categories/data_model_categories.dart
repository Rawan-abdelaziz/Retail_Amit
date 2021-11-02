class DataModel {
  List<Categories> categories;

  DataModel({
    this.categories,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = List<Categories>();
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
  }
}

class Categories {
  final int id;
  final String name;
  final String avatar;

  Categories({
    this.name,
    this.id,
    this.avatar,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}