class Categories {
  int id;
  String createdAt;
  String updatedAt;
  String categoryName;
  String categoryCn;
  String categoryIt;
  String categoryFr;
  dynamic parentCategoryId;
  String imgUrl;
  dynamic imgName;
  List<SubCategories> subCategories;

  Categories(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.categoryCn,
      this.categoryIt,
      this.categoryFr,
      this.parentCategoryId,
      this.imgUrl,
      this.imgName,
      this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
    categoryCn = json['category_cn'];
    categoryIt = json['category_it'];
    categoryFr = json['category_fr'];
    parentCategoryId = json['parent_category_id'];
    imgUrl = json['img_url'];
    imgName = json['img_name'];
    if (json['sub_categories'] != null) {
      subCategories = new List<SubCategories>();
      json['sub_categories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    } else {
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
    data['category_cn'] = this.categoryCn;
    data['category_it'] = this.categoryIt;
    data['category_fr'] = this.categoryFr;
    data['parent_category_id'] = this.parentCategoryId;
    data['img_url'] = this.imgUrl;
    data['img_name'] = this.imgName;
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
  String categoryCn;
  String categoryIt;
  String categoryFr;
  int parentCategoryId;
  String imgUrl;
  dynamic imgName;

  SubCategories(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.categoryCn,
      this.categoryIt,
      this.categoryFr,
      this.parentCategoryId,
      this.imgUrl,
      this.imgName});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
    categoryCn = json['category_cn'];
    categoryIt = json['category_it'];
    categoryFr = json['category_fr'];
    parentCategoryId = json['parent_category_id'];
    imgUrl = json['img_url'];
    imgName = json['img_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    data['category_cn'] = this.categoryCn;
    data['category_it'] = this.categoryIt;
    data['category_fr'] = this.categoryFr;
    data['parent_category_id'] = this.parentCategoryId;
    data['img_url'] = this.imgUrl;
    data['img_name'] = this.imgName;
    return data;
  }
}
