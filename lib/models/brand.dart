class Brand {
  dynamic id;
  dynamic brandName;
  dynamic brandLogo;
  dynamic createdAt;
  dynamic updatedAt;

  Brand(
      {this.id,
      this.brandName,
      this.brandLogo,
      this.createdAt,
      this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    brandLogo = json['brand_logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['brand_logo'] = this.brandLogo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}