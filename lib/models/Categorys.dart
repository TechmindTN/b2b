class Categories {
  int id;
  String createdAt;
  String updatedAt;
  String categoryName;
  int parentCategoryId;
  List<SubCategories> subCategories;

  Categories(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.parentCategoryId,
      this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
    parentCategoryId = json['parent_category_id'];
    if (json['sub_categories'] != null) {
      subCategories = new List<SubCategories>();
      json['sub_categories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
    else{
      subCategories = new List<SubCategories>();
      json['get_child_categories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    data['parent_category_id'] = this.parentCategoryId;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int id;
  String createdAt;
  String updatedAt;
  String categoryName;
  int parentCategoryId;

  SubCategories(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.parentCategoryId});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
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