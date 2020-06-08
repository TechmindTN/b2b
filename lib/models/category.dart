class Category {
  int id;
  String createdAt;
  String updatedAt;
  String categoryName;
  dynamic parentCategoryId;

  Category(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.parentCategoryId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name']==null ? 'NO CATEGORY':json['category_name'] ;
    parentCategoryId = json['parent_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    data['parent_category_id'] = this.parentCategoryId;
    return data;
  }
}